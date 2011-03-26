from ballistics.linearmath.common cimport btScalar
from ballistics.linearmath.vector3 cimport btVector3
from ballistics.collision.broadphase.dispatcher cimport btDispatcher
from ballistics.collision.broadphase.interface cimport btBroadphaseInterface
from ballistics.collision.dispatch.config cimport btCollisionConfiguration
from ballistics.dynamics.constraintsolver.base cimport btConstraintSolver
from ballistics.dynamics.rigid_body cimport btRigidBody
from ballistics.dynamics.constraintsolver.typed_constraint cimport \
        btTypedConstraint
from ballistics.debug.debug_ cimport btIDebugDraw


cdef extern from "BulletDynamics/Dynamics/btDiscreteDynamicsWorld.h":

    cdef cppclass btDiscreteDynamicsWorld:
        btDiscreteDynamicsWorld(btDispatcher* dispatcher, 
                btBroadphaseInterface* pairCache,
                btConstraintSolver* constraintSolver,
                btCollisionConfiguration* collisionConfiguration)
        void setGravity(btVector3 &gravity)
        void addRigidBody(btRigidBody *body)
        void addRigidBody(btRigidBody *body, short group, short mask)
        void removeRigidBody(btRigidBody *body)
        int stepSimulation(btScalar timeStep) nogil
        int stepSimulation(btScalar timeStep, int maxSubSteps) nogil
        int stepSimulation(btScalar timeStep, int maxSubSteps, 
                btScalar fixedTimeStep) nogil
        void addConstraint(btTypedConstraint *raint, 
                int disableCollisionsBetweenLinkedBodies)
        void removeConstraint(btTypedConstraint *raint)
        # From btCollisionWorld
        void setDebugDrawer(btIDebugDraw *debugDrawer)
        void debugDrawWorld()

"""
        void synchronizeMotionStates()
        void synchronizeSingleMotionState(btRigidBody *body)
        void addAction(btActionInterface*)
        void removeAction(btActionInterface*)
        btSimulationIslandManager* getSimulationIslandManager()
        btSimulationIslandManager* getSimulationIslandManager() 
        btCollisionWorld* getCollisionWorld()
        btVector3 getGravity() 
        void addCollisionObject(btCollisionObject *collisionObject, short int collisionFilterGroup=btBroadphaseProxy::StaticFilter, short int collisionFilterMask=btBroadphaseProxy::AllFilter^btBroadphaseProxy::StaticFilter)
        void removeCollisionObject(btCollisionObject *collisionObject)
        void debugDrawConstraint(btTypedConstraint *raint)
        void debugDrawWorld()
        void setConstraintSolver(btConstraintSolver *solver)
        btConstraintSolver * getConstraintSolver()
        int getNumConstraints() 
        btTypedConstraint * getConstraint(int index)
        btDynamicsWorldType getWorldType() 
        void clearForces()
        void applyGravity()
        void setNumTasks(int numTasks)
        void setSynchronizeAllMotionStates(bool synchronizeAll)
        bool getSynchronizeAllMotionStates() 
"""

cdef class DiscreteDynamicsWorld:

    cdef btDiscreteDynamicsWorld *wrapped
    cdef object dispatcher 
    cdef object pairCache 
    cdef object constraintSolver 
    cdef object collisionConfiguration 
    cdef set rigidBodies
    cdef btIDebugDraw *debugDrawer
