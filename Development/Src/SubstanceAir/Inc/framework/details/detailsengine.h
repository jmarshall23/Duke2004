//! @file detailsengine.h
//! @brief Substance Air Framework Engine/Linker wrapper definition
//! @author Christophe Soum - Allegorithmic
//! @date 20111031
//! @copyright Allegorithmic. All rights reserved.
//!
 

#ifndef _SUBSTANCE_AIR_FRAMEWORK_DETAILS_DETAILSENGINE_H
#define _SUBSTANCE_AIR_FRAMEWORK_DETAILS_DETAILSENGINE_H

#include "detailsgraphbinary.h"
#include "detailssync.h"

#pragma pack ( push, 8 )
#include <substance/handle.h>
#include <substance/linker/handle.h>
#pragma pack ( pop )

namespace SubstanceAir
{
namespace Details
{

class RenderJob;
struct LinkGraphs;
struct LinkContext;

//! @brief Substance Engine Wrapper
class Engine : Uncopyable
{
public:
	//! @brief Constructor
	Engine();

	//! @brief Destructor
	~Engine();
	
	
	//! @brief Accessor on current Substance Handle
	//! @return Return the current handle or NULL not already linked
	SubstanceHandle* getHandle() const { return mHandle; }
	
	//! @brief Link/Relink all states in pending render jobs
	//! @param renderJobBegin Begin of chained list of render jobs to link
	//! @return Return true if link process succeed
	bool link(RenderJob* renderJobBegin);
	
	//! @brief Function called just before pushing I/O to compute
	//! @post Engine render queue is flushed
	void beginPush();
	
	//! @brief Stop any generation
	//! Thread safe stop call on current handle if present 
	//! @note Called from user thread
	void stop();
	
	//! @brief Linker Collision UID callback implementation
	//! @param collisionType Output or input collision flag
	//! @param previousUid Initial UID that collide
	//! @param newUid New UID generated
	//! @note Called by linker callback
	void callbackLinkerUIDCollision(
		SubstanceLinkerUIDCollisionType collisionType,
		UINT previousUid,
		UINT newUid);
	
protected:

	//! @brief Engine Contexts class
	class Context
	{
	public:
		//! @brief Constructor, create Substance Context
		Context();
		
		//! @brief Destructor, release Substance Context
		~Context();
		
		//! @brief Accessor on Substance Engine Context
		SubstanceContext *getContext() const { return mContext; }
	
	protected:
		//! @brief Substance Engine Context
		SubstanceContext *mContext;
		
	};  // class Context
	
	
	//! @brief Context singleton instance
	static std::tr1::weak_ptr<Context> mContextGlobal;
	
	//! @brief This instance Context shared ptr (mark context as currently used)
	std::tr1::shared_ptr<Context> mContextInstance;
	
	//! @brief SBSBIN data, double buffer
	//! Two buffers are used for cache transfer
	//! @invariant At least one buffer is empty
	std::string mSbsbinDatas[2];
	
	//! @brief Linker cache data generated by linker
	const unsigned char* mLinkerCacheData;
	
	//! @brief The current substance handle
	//! NULL if not yet linked
	SubstanceHandle *mHandle;
	
	//! @brief Mutex on handle stop/create/switch
	//! Used for stop() thread safe action
	Sync::mutex mMutexHandle;
	
	//! @brief Substance Linker Context
	//! One linker context/handle per Renderer to avoid concurrency issues
	SubstanceLinkerContext *mLinkerContext;	
	
	//! @brief Substance Linker Handle
	//! One linker context/handle per Renderer to avoid concurrency issues
	SubstanceLinkerHandle *mLinkerHandle;
	
	//! @brief Memory budget in bytes
	size_t mMemoryBudget;
	
	//! @brief Contains current filled binary, used during link (by callbacks)
	LinkContext *mCurrentLinkContext;
	
	
	//! @brief Fill Graph binaries w/ new Engine handle SBSBIN indices
	//! @param linkGraphs Contains Graph binaries to fill indices
	void fillIndices(LinkGraphs& linkGraphs) const;
	
};  // class Engine


} // namespace Details
} // namespace SubstanceAir

#endif // ifndef _SUBSTANCE_AIR_FRAMEWORK_DETAILS_DETAILSENGINE_H
