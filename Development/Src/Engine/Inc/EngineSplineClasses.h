/*===========================================================================
    C++ class definitions exported from UnrealScript.
    This is automatically generated by the tools.
    DO NOT modify this manually! Edit the corresponding .uc files instead!
    Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
===========================================================================*/
#if SUPPORTS_PRAGMA_PACK
#pragma pack (push,4)
#endif

#include "EngineNames.h"

// Split enums from the rest of the header so they can be included earlier
// than the rest of the header file by including this file twice with different
// #define wrappers. See Engine.h and look at EngineClasses.h for an example.
#if !NO_ENUMS && !defined(NAMES_ONLY)

#ifndef INCLUDED_ENGINE_SPLINE_ENUMS
#define INCLUDED_ENGINE_SPLINE_ENUMS 1


#endif // !INCLUDED_ENGINE_SPLINE_ENUMS
#endif // !NO_ENUMS

#if !ENUMS_ONLY

#ifndef NAMES_ONLY
#define AUTOGENERATE_FUNCTION(cls,idx,name)
#endif


#ifndef NAMES_ONLY

#ifndef INCLUDED_ENGINE_SPLINE_CLASSES
#define INCLUDED_ENGINE_SPLINE_CLASSES 1
#define ENABLE_DECLARECLASS_MACRO 1
#include "UnObjBas.h"
#undef ENABLE_DECLARECLASS_MACRO

struct FSplineConnection
{
    class USplineComponent* SplineComponent;
    class ASplineActor* ConnectTo;

    /** Constructors */
    FSplineConnection() {}
    FSplineConnection(EEventParm)
    {
        appMemzero(this, sizeof(FSplineConnection));
    }
};

class ASplineActor : public AActor
{
public:
    //## BEGIN PROPS SplineActor
    TArrayNoInit<struct FSplineConnection> Connections;
    FVector SplineActorTangent;
    FColor SplineColor;
    BITFIELD bDisableDestination:1;
    BITFIELD bAlreadyVisited:1;
    TArrayNoInit<class ASplineActor*> LinksFrom;
    class ASplineActor* nextOrdered;
    class ASplineActor* prevOrdered;
    class ASplineActor* previousPath;
    INT bestPathWeight;
    INT visitedWeight;
    FInterpCurveFloat SplineVelocityOverTime;
    //## END PROPS SplineActor

    virtual FVector GetWorldSpaceTangent();
    virtual void UpdateSplineComponents();
    virtual void UpdateConnectedSplineComponents(UBOOL bFinish);
    virtual void AddConnectionTo(class ASplineActor* NextActor);
    virtual UBOOL IsConnectedTo(class ASplineActor* NextActor,UBOOL bCheckForDisableDestination) const;
    virtual class USplineComponent* FindSplineComponentTo(class ASplineActor* NextActor);
    virtual class ASplineActor* FindTargetForComponent(class USplineComponent* SplineComp);
    virtual void BreakConnectionTo(class ASplineActor* NextActor);
    virtual void BreakAllConnections();
    virtual void BreakAllConnectionsFrom();
    virtual class ASplineActor* GetRandomConnection(UBOOL bUseLinksFrom=FALSE);
    virtual class ASplineActor* GetBestConnectionInDirection(FVector DesiredDir,UBOOL bUseLinksFrom=FALSE);
    virtual UBOOL FindSplinePathTo(class ASplineActor* Goal,TArray<class ASplineActor*>& OutRoute);
    virtual void GetAllConnectedSplineActors(TArray<class ASplineActor*>& OutSet);
    DECLARE_FUNCTION(execGetWorldSpaceTangent)
    {
        P_FINISH;
        *(FVector*)Result=this->GetWorldSpaceTangent();
    }
    DECLARE_FUNCTION(execUpdateSplineComponents)
    {
        P_FINISH;
        this->UpdateSplineComponents();
    }
    DECLARE_FUNCTION(execUpdateConnectedSplineComponents)
    {
        P_GET_UBOOL(bFinish);
        P_FINISH;
        this->UpdateConnectedSplineComponents(bFinish);
    }
    DECLARE_FUNCTION(execAddConnectionTo)
    {
        P_GET_OBJECT(ASplineActor,NextActor);
        P_FINISH;
        this->AddConnectionTo(NextActor);
    }
    DECLARE_FUNCTION(execIsConnectedTo)
    {
        P_GET_OBJECT(ASplineActor,NextActor);
        P_GET_UBOOL(bCheckForDisableDestination);
        P_FINISH;
        *(UBOOL*)Result=this->IsConnectedTo(NextActor,bCheckForDisableDestination);
    }
    DECLARE_FUNCTION(execFindSplineComponentTo)
    {
        P_GET_OBJECT(ASplineActor,NextActor);
        P_FINISH;
        *(class USplineComponent**)Result=this->FindSplineComponentTo(NextActor);
    }
    DECLARE_FUNCTION(execFindTargetForComponent)
    {
        P_GET_OBJECT(USplineComponent,SplineComp);
        P_FINISH;
        *(class ASplineActor**)Result=this->FindTargetForComponent(SplineComp);
    }
    DECLARE_FUNCTION(execBreakConnectionTo)
    {
        P_GET_OBJECT(ASplineActor,NextActor);
        P_FINISH;
        this->BreakConnectionTo(NextActor);
    }
    DECLARE_FUNCTION(execBreakAllConnections)
    {
        P_FINISH;
        this->BreakAllConnections();
    }
    DECLARE_FUNCTION(execBreakAllConnectionsFrom)
    {
        P_FINISH;
        this->BreakAllConnectionsFrom();
    }
    DECLARE_FUNCTION(execGetRandomConnection)
    {
        P_GET_UBOOL_OPTX(bUseLinksFrom,FALSE);
        P_FINISH;
        *(class ASplineActor**)Result=this->GetRandomConnection(bUseLinksFrom);
    }
    DECLARE_FUNCTION(execGetBestConnectionInDirection)
    {
        P_GET_STRUCT(FVector,DesiredDir);
        P_GET_UBOOL_OPTX(bUseLinksFrom,FALSE);
        P_FINISH;
        *(class ASplineActor**)Result=this->GetBestConnectionInDirection(DesiredDir,bUseLinksFrom);
    }
    DECLARE_FUNCTION(execFindSplinePathTo)
    {
        P_GET_OBJECT(ASplineActor,Goal);
        P_GET_TARRAY_REF(class ASplineActor*,OutRoute);
        P_FINISH;
        *(UBOOL*)Result=this->FindSplinePathTo(Goal,OutRoute);
    }
    DECLARE_FUNCTION(execGetAllConnectedSplineActors)
    {
        P_GET_TARRAY_REF(class ASplineActor*,OutSet);
        P_FINISH;
        this->GetAllConnectedSplineActors(OutSet);
    }
    DECLARE_CLASS(ASplineActor,AActor,0,Engine)
	virtual void PostLoad();	
	virtual void PostScriptDestroyed();

	virtual void PostEditMove(UBOOL bFinished);
	virtual void PostEditChangeProperty(FPropertyChangedEvent& PropertyChangedEvent);
	
	// SplineActor interface
	
	/** Called when spline is selected in editor, to overlay extra information */
	virtual void EditModeSelectedDraw(const FSceneView* View,FViewport* Viewport,FPrimitiveDrawInterface* PDI) {}
	
	/** Clear the transient properties used for path finding */
	void ClearForSplinePathFinding();
};

class ASplineLoftActor : public ASplineActor
{
public:
    //## BEGIN PROPS SplineLoftActor
    FLOAT ScaleX;
    FLOAT ScaleY;
    TArrayNoInit<class USplineMeshComponent*> SplineMeshComps;
    class UStaticMesh* DeformMesh;
    TArrayNoInit<class UMaterialInterface*> DeformMeshMaterials;
    FLOAT Roll;
    FVector WorldXDir;
    FVector2D Offset;
    BITFIELD bSmoothInterpRollAndScale:1;
    BITFIELD bAcceptsLights:1;
    class UDynamicLightEnvironmentComponent* MeshLightEnvironment;
    FLOAT MeshMaxDrawDistance;
    //## END PROPS SplineLoftActor

    virtual void ClearLoftMesh();
    virtual void UpdateSplineParams();
    DECLARE_FUNCTION(execClearLoftMesh)
    {
        P_FINISH;
        this->ClearLoftMesh();
    }
    DECLARE_FUNCTION(execUpdateSplineParams)
    {
        P_FINISH;
        this->UpdateSplineParams();
    }
    DECLARE_CLASS(ASplineLoftActor,ASplineActor,0,Engine)
	virtual void PostLoad();		
	virtual void UpdateComponentsInternal(UBOOL bCollisionUpdate = FALSE);

    virtual void UpdateSplineComponents();	
};

class ASplineLoftActorMovable : public ASplineLoftActor
{
public:
    //## BEGIN PROPS SplineLoftActorMovable
    //## END PROPS SplineLoftActorMovable

    DECLARE_CLASS(ASplineLoftActorMovable,ASplineLoftActor,0,Engine)
    NO_DEFAULT_CONSTRUCTOR(ASplineLoftActorMovable)
};

class USplineComponent : public UPrimitiveComponent
{
public:
    //## BEGIN PROPS SplineComponent
    FInterpCurveVector SplineInfo;
    FLOAT SplineCurviness;
    FColor SplineColor;
    FLOAT SplineDrawRes;
    FLOAT SplineArrowSize;
    BITFIELD bSplineDisabled:1;
    SCRIPT_ALIGN;
    FInterpCurveFloat SplineReparamTable;
    //## END PROPS SplineComponent

    virtual void UpdateSplineCurviness();
    virtual void UpdateSplineReparamTable();
    virtual FLOAT GetSplineLength() const;
    virtual FVector GetLocationAtDistanceAlongSpline(FLOAT Distance) const;
    virtual FVector GetTangentAtDistanceAlongSpline(FLOAT Distance) const;
    DECLARE_FUNCTION(execUpdateSplineCurviness)
    {
        P_FINISH;
        this->UpdateSplineCurviness();
    }
    DECLARE_FUNCTION(execUpdateSplineReparamTable)
    {
        P_FINISH;
        this->UpdateSplineReparamTable();
    }
    DECLARE_FUNCTION(execGetSplineLength)
    {
        P_FINISH;
        *(FLOAT*)Result=this->GetSplineLength();
    }
    DECLARE_FUNCTION(execGetLocationAtDistanceAlongSpline)
    {
        P_GET_FLOAT(Distance);
        P_FINISH;
        *(FVector*)Result=this->GetLocationAtDistanceAlongSpline(Distance);
    }
    DECLARE_FUNCTION(execGetTangentAtDistanceAlongSpline)
    {
        P_GET_FLOAT(Distance);
        P_FINISH;
        *(FVector*)Result=this->GetTangentAtDistanceAlongSpline(Distance);
    }
    DECLARE_CLASS(USplineComponent,UPrimitiveComponent,0,Engine)
	// UPrimitiveComponent interface.
	virtual FPrimitiveSceneProxy* CreateSceneProxy();
	virtual void UpdateBounds();
	
};

#undef DECLARE_CLASS
#undef DECLARE_CASTED_CLASS
#undef DECLARE_ABSTRACT_CLASS
#undef DECLARE_ABSTRACT_CASTED_CLASS
#endif // !INCLUDED_ENGINE_SPLINE_CLASSES
#endif // !NAMES_ONLY

AUTOGENERATE_FUNCTION(ASplineActor,-1,execGetAllConnectedSplineActors);
AUTOGENERATE_FUNCTION(ASplineActor,-1,execFindSplinePathTo);
AUTOGENERATE_FUNCTION(ASplineActor,-1,execGetBestConnectionInDirection);
AUTOGENERATE_FUNCTION(ASplineActor,-1,execGetRandomConnection);
AUTOGENERATE_FUNCTION(ASplineActor,-1,execBreakAllConnectionsFrom);
AUTOGENERATE_FUNCTION(ASplineActor,-1,execBreakAllConnections);
AUTOGENERATE_FUNCTION(ASplineActor,-1,execBreakConnectionTo);
AUTOGENERATE_FUNCTION(ASplineActor,-1,execFindTargetForComponent);
AUTOGENERATE_FUNCTION(ASplineActor,-1,execFindSplineComponentTo);
AUTOGENERATE_FUNCTION(ASplineActor,-1,execIsConnectedTo);
AUTOGENERATE_FUNCTION(ASplineActor,-1,execAddConnectionTo);
AUTOGENERATE_FUNCTION(ASplineActor,-1,execUpdateConnectedSplineComponents);
AUTOGENERATE_FUNCTION(ASplineActor,-1,execUpdateSplineComponents);
AUTOGENERATE_FUNCTION(ASplineActor,-1,execGetWorldSpaceTangent);
AUTOGENERATE_FUNCTION(ASplineLoftActor,-1,execUpdateSplineParams);
AUTOGENERATE_FUNCTION(ASplineLoftActor,-1,execClearLoftMesh);
AUTOGENERATE_FUNCTION(USplineComponent,-1,execGetTangentAtDistanceAlongSpline);
AUTOGENERATE_FUNCTION(USplineComponent,-1,execGetLocationAtDistanceAlongSpline);
AUTOGENERATE_FUNCTION(USplineComponent,-1,execGetSplineLength);
AUTOGENERATE_FUNCTION(USplineComponent,-1,execUpdateSplineReparamTable);
AUTOGENERATE_FUNCTION(USplineComponent,-1,execUpdateSplineCurviness);

#ifndef NAMES_ONLY
#undef AUTOGENERATE_FUNCTION
#endif

#ifdef STATIC_LINKING_MOJO
#ifndef ENGINE_SPLINE_NATIVE_DEFS
#define ENGINE_SPLINE_NATIVE_DEFS

#define AUTO_INITIALIZE_REGISTRANTS_ENGINE_SPLINE \
	ASplineActor::StaticClass(); \
	GNativeLookupFuncs.Set(FName("SplineActor"), GEngineASplineActorNatives); \
	ASplineLoftActor::StaticClass(); \
	GNativeLookupFuncs.Set(FName("SplineLoftActor"), GEngineASplineLoftActorNatives); \
	ASplineLoftActorMovable::StaticClass(); \
	USplineComponent::StaticClass(); \
	GNativeLookupFuncs.Set(FName("SplineComponent"), GEngineUSplineComponentNatives); \

#endif // ENGINE_SPLINE_NATIVE_DEFS

#ifdef NATIVES_ONLY
FNativeFunctionLookup GEngineASplineActorNatives[] = 
{ 
	MAP_NATIVE(ASplineActor, execGetAllConnectedSplineActors)
	MAP_NATIVE(ASplineActor, execFindSplinePathTo)
	MAP_NATIVE(ASplineActor, execGetBestConnectionInDirection)
	MAP_NATIVE(ASplineActor, execGetRandomConnection)
	MAP_NATIVE(ASplineActor, execBreakAllConnectionsFrom)
	MAP_NATIVE(ASplineActor, execBreakAllConnections)
	MAP_NATIVE(ASplineActor, execBreakConnectionTo)
	MAP_NATIVE(ASplineActor, execFindTargetForComponent)
	MAP_NATIVE(ASplineActor, execFindSplineComponentTo)
	MAP_NATIVE(ASplineActor, execIsConnectedTo)
	MAP_NATIVE(ASplineActor, execAddConnectionTo)
	MAP_NATIVE(ASplineActor, execUpdateConnectedSplineComponents)
	MAP_NATIVE(ASplineActor, execUpdateSplineComponents)
	MAP_NATIVE(ASplineActor, execGetWorldSpaceTangent)
	{NULL, NULL}
};

FNativeFunctionLookup GEngineASplineLoftActorNatives[] = 
{ 
	MAP_NATIVE(ASplineLoftActor, execUpdateSplineParams)
	MAP_NATIVE(ASplineLoftActor, execClearLoftMesh)
	{NULL, NULL}
};

FNativeFunctionLookup GEngineUSplineComponentNatives[] = 
{ 
	MAP_NATIVE(USplineComponent, execGetTangentAtDistanceAlongSpline)
	MAP_NATIVE(USplineComponent, execGetLocationAtDistanceAlongSpline)
	MAP_NATIVE(USplineComponent, execGetSplineLength)
	MAP_NATIVE(USplineComponent, execUpdateSplineReparamTable)
	MAP_NATIVE(USplineComponent, execUpdateSplineCurviness)
	{NULL, NULL}
};

#endif // NATIVES_ONLY
#endif // STATIC_LINKING_MOJO

#ifdef VERIFY_CLASS_SIZES
VERIFY_CLASS_OFFSET_NODIE(ASplineActor,SplineActor,Connections)
VERIFY_CLASS_OFFSET_NODIE(ASplineActor,SplineActor,SplineVelocityOverTime)
VERIFY_CLASS_SIZE_NODIE(ASplineActor)
VERIFY_CLASS_OFFSET_NODIE(ASplineLoftActor,SplineLoftActor,ScaleX)
VERIFY_CLASS_OFFSET_NODIE(ASplineLoftActor,SplineLoftActor,MeshMaxDrawDistance)
VERIFY_CLASS_SIZE_NODIE(ASplineLoftActor)
VERIFY_CLASS_SIZE_NODIE(ASplineLoftActorMovable)
VERIFY_CLASS_OFFSET_NODIE(USplineComponent,SplineComponent,SplineInfo)
VERIFY_CLASS_OFFSET_NODIE(USplineComponent,SplineComponent,SplineReparamTable)
VERIFY_CLASS_SIZE_NODIE(USplineComponent)
#endif // VERIFY_CLASS_SIZES
#endif // !ENUMS_ONLY

#if SUPPORTS_PRAGMA_PACK
#pragma pack (pop)
#endif
