from ballistics.linearmath.common cimport btScalar
from ballistics.linearmath.vector3 cimport btVector3
from ballistics.linearmath.motion_state cimport btMotionState, MotionState
from ballistics.collision.shapes.base cimport btCollisionShape


cdef extern from "BulletDynamics/Dynamics/btRigidBody.h":

    cdef cppclass btRigidBodyConstructionInfo "btRigidBody::btRigidBodyConstructionInfo":
        btRigidBodyConstructionInfo(btScalar mass, btMotionState* motionState,
                btCollisionShape* collisionShape)
        btRigidBodyConstructionInfo(btScalar mass, btMotionState* motionState,
                btCollisionShape* collisionShape, btVector3& localInertia)

    cdef cppclass btRigidBody:
        btRigidBody(btRigidBodyConstructionInfo& constructionInfo)
        btMotionState* getMotionState()
        void setMotionState(btMotionState* motionState)
        void setDamping(btScalar lin_damping, btScalar ang_damping)
        btScalar getLinearDamping() 
        btScalar getAngularDamping()
        void applyCentralForce(btVector3 &force)
        void applyForce(btVector3 &force, btVector3 &rel_pos)
        void applyCentralImpulse(btVector3 &impulse)
        void applyImpulse(btVector3 &force, btVector3 &rel_pos)


cdef class RigidBodyConstructionInfo:

    cdef btRigidBodyConstructionInfo *wrapped
    cdef public MotionState motionState
    cdef object collisionShape
    cdef object localInertia


cdef class RigidBody:

    cdef btRigidBody *wrapped
    cdef object constructionInfo

