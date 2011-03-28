from ballistics.dynamics.constraintsolver.typed_constraint cimport TypedConstraint
from ballistics.dynamics.rigid_body cimport btRigidBody
from ballistics.linearmath.quaternion cimport btQuaternion
from ballistics.linearmath.vector3 cimport btVector3
from ballistics.linearmath.transform cimport btTransform
from ballistics.linearmath.common cimport btScalar


cdef extern from "BulletDynamics/ConstraintSolver/btConeTwistConstraint.h":

    cdef cppclass btConeTwistConstraint:

        btConeTwistConstraint(btRigidBody &rbA, btRigidBody &rbB, 
                btTransform &rbAFrame, btTransform &rbBFrame)
        btConeTwistConstraint(btRigidBody &rbA, btTransform &rbAFrame)
        void updateRHS(btScalar timeStep)
        btRigidBody& getRigidBodyA()
        btRigidBody& getRigidBodyB()
        void setAngularOnly(int angularOnly)
        void setLimit(int limitIndex, btScalar limitValue)
        void setLimit(btScalar swingSpan1, btScalar swingSpan2, 
                btScalar twistSpan, btScalar softness, 
                btScalar biasFactor, btScalar relaxationFactor)
        btTransform & getAFrame()
        btTransform & getBFrame()
        int getSolveTwistLimit()
        int getSolveSwingLimit()
        btScalar getTwistLimitSign()
        btScalar getSwingSpan1()
        btScalar getSwingSpan2()
        btScalar getTwistSpan()
        btScalar getTwistAngle()
        int isPastSwingLimit()
        void setDamping(btScalar damping)
        void enableMotor(int b)
        void setMaxMotorImpulse(btScalar maxMotorImpulse)
        void setMaxMotorImpulseNormalized(btScalar maxMotorImpulse)
        btScalar getFixThresh()
        void setFixThresh(btScalar fixThresh)
        void setMotorTarget(btQuaternion &q)
        void setMotorTargetInConstraintSpace(btQuaternion &q)
        btVector3 GetPointForAngle(btScalar fAngleInRadians, btScalar fLength)
        void setParam(int num, btScalar value, int axis)
        btScalar getParam(int num, int axis)


cdef class ConeTwistConstraint(TypedConstraint):

    pass
