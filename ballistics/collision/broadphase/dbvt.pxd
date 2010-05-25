from ballistics.collision.broadphase.overlapping_pair_cache cimport \
        btOverlappingPairCache
from ballistics.collision.broadphase.dispatcher cimport btDispatcher
from ballistics.collision.broadphase.proxy cimport btBroadphaseProxy
from ballistics.collision.broadphase.interface cimport btBroadphaseRayCallback, \
        btBroadphaseAabbCallback
from ballistics.linearmath.common cimport btScalar
from ballistics.linearmath.vector3 cimport btVector3
from ballistics.collision.broadphase.interface cimport BroadphaseInterface


cdef extern from "BulletCollision/BroadphaseCollision/btDbvtBroadphase.h":

    cdef cppclass btDbvtBroadphase:
        btDbvtBroadphase()
        btDbvtBroadphase(btOverlappingPairCache *paircache)
        void collide(btDispatcher *dispatcher)
        void optimize()
        btBroadphaseProxy* createProxy(btVector3 &aabbMin, btVector3 &aabbMax,
                int shapeType, void *userPtr, short int collisionFilterGroup,
                short int collisionFilterMask, btDispatcher *dispatcher,
                void *multiSapProxy)
        void destroyProxy(btBroadphaseProxy *proxy,
                btDispatcher *dispatcher)
        void setAabb(btBroadphaseProxy *proxy,  btVector3 &aabbMin,
                btVector3 &aabbMax, btDispatcher *dispatcher)
        void rayTest(btVector3 &rayFrom,  btVector3 &rayTo, 
                btBroadphaseRayCallback &rayCallback,
                btVector3 &aabbMin=?, btVector3 &aabbMax=?)
        void aabbTest(btVector3 &aabbMin, 
                btVector3 &aabbMax, btBroadphaseAabbCallback &callback)
        void getAabb(btBroadphaseProxy *proxy, btVector3 &aabbMin,
                btVector3 &aabbMax) 
        void calculateOverlappingPairs(btDispatcher *dispatcher)
        btOverlappingPairCache* getOverlappingPairCache()
        btOverlappingPairCache* getOverlappingPairCache() 
        void getBroadphaseAabb(btVector3 &aabbMin, btVector3 &aabbMax) 
        void printStats()
        void resetPool(btDispatcher *dispatcher)
        void performDeferredRemoval(btDispatcher *dispatcher)
        void setVelocityPrediction(btScalar prediction)
        btScalar getVelocityPrediction() 
        void setAabbForceUpdate(btBroadphaseProxy *absproxy, 
                btVector3 &aabbMin, btVector3 &aabbMax, btDispatcher *)


cdef class DbvtBroadphase(BroadphaseInterface):
    pass
