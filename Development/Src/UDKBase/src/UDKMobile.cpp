// Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.

#include "UDKBase.h"


// should we use the memcpy-less particle path (takes a decent amount of memory)
// @todo ngp: This is causing a crash on some devices, so we are disabling it for now. It might be a mem allocation alignment issue, it's unclear at this time
#define USE_SUPER_FAST_PATH 0 // USE_GXM_RHI

// how many buffers for particles - 3 minimum for Game thread / render thread / GPU
#define NUM_PARTICLE_BUFFERS 3


#if USE_SUPER_FAST_PATH

/**
 * GPU delayed memory releasing
 */
class FDelayedGpuFree
{
protected:
	/** Buffer to delete later */
	void* Buffer;

public:

	/**
	 * Constructor. 
	 * 
	 * @param Pathname Path to the music file
	 */
	FDelayedGpuFree(void* InBuffer)
		:	Buffer(InBuffer)
	{
	}

	/**
	 * Performs the async hash verification
	 */
	void DoWork()
	{
		// free in roughly 3 frames (at 15 fps)
		appSleep(3.0 / 15.0f);
		appNGPGPUFree(Buffer);
	}

	/**
	 * Task API, return true to indicate that we can abandon
	 */
	UBOOL CanAbandon()
	{
		return FALSE;
	}

	/**
	 * Abandon task, deletes the buffer if that is what was requested
	 */
	void Abandon()
	{
	}
	/** Give the name for external event viewers
	* @return	the name to display in external event viewers
	*/
	static const TCHAR *Name()
	{
		return TEXT("FDelayedGpuFree");
	}
};


#endif



struct FParticleSnowEmitterInstance : public FParticleSpriteEmitterInstance
{
	DECLARE_PARTICLEEMITTERINSTANCE_TYPE(FParticleSnowEmitterInstance, FParticleSpriteEmitterInstance);

	/** Pointer to the spinner TypeDatModule.         */
	UParticleModuleTypeDataSnow* SnowTypeData;

	/** Cache the dynamic data we filled out during tick */
	FDynamicEmitterDataBase* CachedDynamicData;

	/** Which double buffer to use */
	BYTE WhichBuffer;

	/** Render data ready for use by render thread (double buffered)	*/
	FParticleSpriteVertex* RenderData[NUM_PARTICLE_BUFFERS];
	WORD* IndexData[NUM_PARTICLE_BUFFERS];

	/** Track last active particles, so we can resize the buffer if needed */
	INT LastMaxActiveParticles[NUM_PARTICLE_BUFFERS];

	/** Constructor   */
	FParticleSnowEmitterInstance()
		: FParticleSpriteEmitterInstance()
		, CachedDynamicData(NULL)
	{
		for (INT Buffer = 0; Buffer < NUM_PARTICLE_BUFFERS; Buffer++)
		{
			RenderData[Buffer] = NULL;
			IndexData[Buffer] = NULL;
			LastMaxActiveParticles[Buffer] = 0;
		}
		WhichBuffer = 0;
	}

	virtual ~FParticleSnowEmitterInstance()
	{
		for (INT Buffer = 0; Buffer < NUM_PARTICLE_BUFFERS; Buffer++)
		{
#if USE_SUPER_FAST_PATH
			// the GPU could still be using these buffers, so put off deallocation
			new FAutoDeleteAsyncTask<FDelayedGpuFree>(RenderData[Buffer])->StartBackgroundTask();
			new FAutoDeleteAsyncTask<FDelayedGpuFree>(IndexData[Buffer])->StartBackgroundTask();
#else
			appFree(RenderData[Buffer]);
			appFree(IndexData[Buffer]);
#endif
		}
	}

	virtual void InitParameters(UParticleEmitter* InTemplate, UParticleSystemComponent* InComponent, UBOOL bClearResources = TRUE)
	{
		// Call the super InitParameters.
		FParticleEmitterInstance::InitParameters(InTemplate, InComponent, bClearResources);

		// Get the type data module
		UParticleLODLevel* LODLevel = InTemplate->GetLODLevel(0);
		check(LODLevel);
		SnowTypeData = CastChecked<UParticleModuleTypeDataSnow>(LODLevel->TypeDataModule);
	}

	FDynamicEmitterDataBase* GetDynamicData(UBOOL bSelected)
	{
#if !USE_SUPER_FAST_PATH
		// if we aren't making direct render data in Tick, then let the normal process happen
		return FParticleSpriteEmitterInstance::GetDynamicData(bSelected);
#endif

		// make sure that we have ticked at least once
		if (!CachedDynamicData)
		{
			return NULL;
		}

		// return the dynamic data that was created in the last tick
		FDynamicEmitterDataBase* LastEmitterData = CachedDynamicData;

		// note that we have now returns 
		CachedDynamicData = NULL;
		return LastEmitterData;
	}

	virtual void Tick(FLOAT DeltaTime, UBOOL bSuppressSpawning)
	{
		SCOPE_CYCLE_COUNTER(STAT_SpriteTickTime);

		// If this the FirstTime we are being ticked?
		UBOOL bFirstTime = (SecondsSinceCreation > 0.0f) ? FALSE : TRUE;

		// Grab the current LOD level
		UParticleLODLevel* LODLevel = SpriteTemplate->GetCurrentLODLevel(this);
		check(LODLevel);

		// update location
		OldLocation	= Location;
		Location	= Component->LocalToWorld.GetOrigin();

		// distance from player
		FLOAT DistAlpha = 1.0f;
		if (GIsGame)
		{
			// figure out player location
			// NOTE: This only works in non-split screen. For split screen to work, we could pass in the fade as
			// a shader parameter
			FVector& PlayerLocation = GEngine->GamePlayers(0)->LastViewLocation;
			FLOAT DistanceSquared = Component->Bounds.GetBox().ComputeSquaredDistanceToPoint(PlayerLocation);

			// fade if needed
			if (DistanceSquared > SnowTypeData->FadeStart * SnowTypeData->FadeStart)
			{
				if (DistanceSquared < SnowTypeData->FadeStop * SnowTypeData->FadeStop)
				{
					FLOAT Distance = appSqrt(DistanceSquared);
					DistAlpha = Clamp(1.0f - (Distance - SnowTypeData->FadeStart) / (SnowTypeData->FadeStop - SnowTypeData->FadeStart), 0.0f, 1.0f);
				}
				else
				{
					DistAlpha = 0.0f;
				}
			}
		}

		// don't do anything if we are faded all the way out
		if (DistAlpha == 0.0f && !Component->bWarmingUp)
		{
			return;
		}

		// spawn as needed
		SpawnFraction = Tick_SpawnParticles(DeltaTime, LODLevel, bSuppressSpawning, bFirstTime);

		CurrentMaterial = LODLevel->RequiredModule->Material;

		// don't mess with Tick_EmitterTimeSetup (right)
		FLOAT EmitterDelay = DeltaTime;

		// buffers to render into (will be NULL for non-NGP)
		FParticleSpriteVertex* FillVertex = NULL;
		WORD* FillIndex = NULL;

// on NGP only, make sure we have GPU memory allocated large enough for render data
#if USE_SUPER_FAST_PATH
		// if we still have dynamic data cached, we don't need to fill anything out
		if (CachedDynamicData == NULL && Component->bWarmingUp == FALSE)
		{
			// object with knowledge of what we are rendering
			FDynamicSpriteEmitterData* DynamicData = (FDynamicSpriteEmitterData*)FParticleSpriteEmitterInstance::GetDynamicData(FALSE);
			if (DynamicData == NULL)
			{
				return;
			}

			// make sure there's enough space to render into
			if (MaxActiveParticles > LastMaxActiveParticles[WhichBuffer])
			{
				// free any previously allocated buffers
				appNGPGPUFree(RenderData[WhichBuffer]);
				appNGPGPUFree(IndexData[WhichBuffer]);

				// allocate enough space for vertices and indices
				INT VertexRenderSize = DynamicData->GetDynamicVertexStride();
				RenderData[WhichBuffer] = (FParticleSpriteVertex*)appNGPGPUAllocate(VertexRenderSize * MaxActiveParticles * 4);
				IndexData[WhichBuffer] = (WORD*)appNGPGPUAllocate(2 * MaxActiveParticles * 6);

				// cache
				LastMaxActiveParticles[WhichBuffer] = MaxActiveParticles;
			}

			// set up buffers to render into
			FillVertex = RenderData[WhichBuffer];
			FillIndex = IndexData[WhichBuffer];
			WhichBuffer = (WhichBuffer + 1) % NUM_PARTICLE_BUFFERS;

			// tell render thread where to render from
			DynamicData->Source.ParticleRenderData = (BYTE*)FillVertex;
			DynamicData->Source.ParticleRenderIndices = FillIndex;
			CachedDynamicData = DynamicData;
		}
#endif // USE_SUPER_FAST_PATH


#if !FINAL_RELEASE
		// reset the bounding box if we are going to calculate it (used by editor when calculating max in cascade)
		if (!Component->Template->bUseFixedRelativeBoundingBox)
		{
			ParticleBoundingBox.Init();
		}
#endif

		SCOPE_CYCLE_COUNTER(STAT_ParticleUpdateTime);
		for (INT ParticleIndex = 0; ParticleIndex < ActiveParticles; ParticleIndex++)
		{
			INT RealParticleIndex = ParticleIndices[ParticleIndex];
			DECLARE_PARTICLE(Particle, ParticleData + ParticleStride * RealParticleIndex);
			Particle.RelativeTime	+= Particle.OneOverMaxLifetime * DeltaTime;

			// colorize it
			FVector ColorVec = SnowTypeData->ColorOverLife.GetValue(Particle.RelativeTime, Component, 0, NULL);
			FLOAT Alpha = SnowTypeData->AlphaOverLife.GetValue(Particle.RelativeTime, Component, NULL);
			Particle_SetColorFromVector(ColorVec, Alpha * DistAlpha, Particle.Color);

			// move it
			Particle.OldLocation = Particle.Location;
			Particle.Location += (DeltaTime * Particle.Velocity);

			// move the particle to the after the active particles to "kill" it
			if (Particle.RelativeTime > 1.0f || Particle.Location.Z < Location.Z + SnowTypeData->KillHeight)
			{
				// swap for the last active one
				Swap(ParticleIndices[ParticleIndex], ParticleIndices[ActiveParticles-1]);
				// reduce number of particles, making the one we just swapped inactive
				ActiveParticles--;
				// redo the current index
				ParticleIndex--;
				continue;
			}

#if !FINAL_RELEASE
			// update bounding box
			if (!Component->Template->bUseFixedRelativeBoundingBox)
			{
				const FLOAT MaxComponentSize = Particle.Size.GetAbsMax();
				const FVector ParticleExtent(MaxComponentSize / 2.0f, MaxComponentSize / 2.0f, MaxComponentSize / 2.0f);
				// Treat each particle as a cube whose sides are the length of the maximum component
				// This handles the particle's extents changing due to being camera facing
				ParticleBoundingBox += FBox(Particle.Location - ParticleExtent, Particle.Location + ParticleExtent);
			}
#endif

			// do we want to fill out data?
			if (FillVertex)
			{
				// create render data
				FVector Size = Particle.Size;
				if (LODLevel->RequiredModule->ScreenAlignment == PSA_Square)
				{
					Size.Y = Size.X;
				}

				FVector ParticlePosition = Particle.Location;
				FVector ParticleOldPosition = Particle.OldLocation;

				// 0
				FillVertex->Position	= ParticlePosition;
				FillVertex->OldPosition	= ParticleOldPosition;
				FillVertex->Size		= Size;
#if !PARTICLES_USE_INDEXED_SPRITES
				FillVertex->Tex_U		= 0.f;
				FillVertex->Tex_V		= 0.f;
#endif
				FillVertex->Rotation	= Particle.Rotation;
				FillVertex->Color		= Particle.Color;
				FillVertex++;

				// 1
				FillVertex->Position	= ParticlePosition;
				FillVertex->OldPosition	= ParticleOldPosition;
				FillVertex->Size		= Size;
#if !PARTICLES_USE_INDEXED_SPRITES
				FillVertex->Tex_U		= 0.f;
				FillVertex->Tex_V		= 1.f;
#endif
				FillVertex->Rotation	= Particle.Rotation;
				FillVertex->Color		= Particle.Color;
				FillVertex++;

				// 2
				FillVertex->Position	= ParticlePosition;
				FillVertex->OldPosition	= ParticleOldPosition;
				FillVertex->Size		= Size;
#if !PARTICLES_USE_INDEXED_SPRITES
				FillVertex->Tex_U		= 1.f;
				FillVertex->Tex_V		= 1.f;
#endif
				FillVertex->Rotation	= Particle.Rotation;
				FillVertex->Color		= Particle.Color;
				FillVertex++;

				// 3
				FillVertex->Position	= ParticlePosition;
				FillVertex->OldPosition	= ParticleOldPosition;
				FillVertex->Size		= Size;
#if !PARTICLES_USE_INDEXED_SPRITES
				FillVertex->Tex_U		= 1.f;
				FillVertex->Tex_V		= 0.f;
#endif
				FillVertex->Rotation	= Particle.Rotation;
				FillVertex->Color		= Particle.Color;
				FillVertex++;

				if (FillIndex)
				{
					*FillIndex++ = (ParticleIndex * 4) + 0;
					*FillIndex++ = (ParticleIndex * 4) + 2;
					*FillIndex++ = (ParticleIndex * 4) + 3;
					*FillIndex++ = (ParticleIndex * 4) + 0;
					*FillIndex++ = (ParticleIndex * 4) + 1;
					*FillIndex++ = (ParticleIndex * 4) + 2;
				}
			}
		}

		INC_DWORD_STAT_BY(STAT_SpriteParticles, ActiveParticles);
		INC_DWORD_STAT_BY(STAT_SpriteParticlesUpdated, ActiveParticles );

		// Invalidate the contents of the vertex/index buffer.
		IsRenderDataDirty = 1;

		// 'Reset' the emitter time so that the delay functions correctly
		EmitterTime += EmitterDelay;
	}

	UBOOL FillReplayData( FDynamicEmitterReplayDataBase& OutData )
	{
#if !USE_SUPER_FAST_PATH
		// if we aren't making direct render data in Tick, then let the normal process happen
		return FParticleSpriteEmitterInstance::FillReplayData(OutData);
#endif

		// basic info
		OutData.eEmitterType = DET_Sprite;
		OutData.ActiveParticleCount = ActiveParticles;
		OutData.ParticleStride = ParticleStride;
		OutData.Scale = FVector(1.0f, 1.0f, 1.0f);
		OutData.SortMode = SortMode;


		FDynamicSpriteEmitterReplayData* NewReplayData = static_cast< FDynamicSpriteEmitterReplayData* >( &OutData );

		// Get the material instance. If there is none, or the material isn't flagged for use with particle systems, use the DefaultMaterial.
		UMaterialInterface* MaterialInst = CurrentMaterial;
		if ((MaterialInst == NULL) || (MaterialInst->CheckMaterialUsage(MATUSAGE_ParticleSprites) == FALSE))
		{
			MaterialInst = GEngine->DefaultMaterial;
		}
		NewReplayData->MaterialInterface = MaterialInst;

		// pull some info out of the particle system
		NewReplayData->MaxDrawCount = -1;
		UParticleLODLevel* LODLevel = SpriteTemplate->GetCurrentLODLevel(this);
		NewReplayData->ScreenAlignment	= LODLevel->RequiredModule->ScreenAlignment;
		NewReplayData->bUseLocalSpace = LODLevel->RequiredModule->bUseLocalSpace;
		NewReplayData->EmitterRenderMode = SpriteTemplate->EmitterRenderMode;
		NewReplayData->DynamicParameterDataOffset = DynamicParameterDataOffset;
		NewReplayData->CameraPayloadOffset = CameraPayloadOffset;
		NewReplayData->bLockAxis = FALSE;

		return TRUE;
	}

	virtual void UpdateBoundingBox(FLOAT DeltaTime)
	{
		// nothing to do here
	}
};

IMPLEMENT_PARTICLEEMITTERINSTANCE_TYPE(FParticleSnowEmitterInstance);




FParticleEmitterInstance* UParticleModuleTypeDataSnow::CreateInstance(UParticleEmitter *InEmitterParent, UParticleSystemComponent *InComponent)
{
	// Create our Spinner emitter instance.
	FParticleSnowEmitterInstance* SnowInst = new FParticleSnowEmitterInstance;
	if (SnowInst)
	{
		// Initialize the parameters for the emitter.
		SnowInst->InitParameters(InEmitterParent, InComponent);
		return SnowInst;
	}

	// We failed. Return NULL to let a default sprite emitter be generated, or assert.
	return NULL;
}


void UParticleModuleTypeDataSnow::Spawn(FParticleEmitterInstance* Owner, INT Offset, FLOAT SpawnTime)
{
	SPAWN_INIT;
	{
		// location
		FVector StartLoc = StartLocation.GetValue(Owner->EmitterTime, Owner->Component, 0, NULL);
		StartLoc = Owner->Component->LocalToWorld.TransformNormal(StartLoc);
		Particle.Location += StartLoc;

		// velocity
		FVector StartVel = StartVelocity.GetValue(Owner->EmitterTime, Owner->Component, 0, NULL);
		Particle.Velocity += StartVel;
		Particle.BaseVelocity += StartVel;

		// size
		FVector Size = StartSize.GetValue(Owner->EmitterTime, Owner->Component, 0, NULL);
		Particle.Size += Size;
		Particle.BaseSize += Size;

		// color
 		FVector ColorVec = ColorOverLife.GetValue(Owner->EmitterTime, Owner->Component, 0, NULL);
 		FLOAT Alpha = AlphaOverLife.GetValue(Owner->EmitterTime, Owner->Component, NULL);
 		Particle_SetColorFromVector(ColorVec, Alpha, Particle.Color);
 		Particle.BaseColor	= Particle.Color;

		// random rotation
		Particle.Rotation = appRand() * 2;

		// lifetime
		FLOAT TimeToLive = Lifetime.GetValue(Owner->EmitterTime, Owner->Component, NULL);
		Particle.OneOverMaxLifetime = 1.0f / TimeToLive;
	}
}


IMPLEMENT_CLASS(UParticleModuleTypeDataSnow);