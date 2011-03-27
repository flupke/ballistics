from ballistics.dynamics.constraintsolver.typed_constraint cimport TypedConstraint
from ballistics.dynamics.rigid_body cimport btRigidBody
from ballistics.linearmath.vector3 cimport btVector3
from ballistics.linearmath.transform cimport btTransform
from ballistics.linearmath.common cimport btScalar


cdef extern from "BulletDynamics/ConstraintSolver/btGeneric6DofConstraint.h":

    cdef cppclass btGeneric6DofConstraint:

        btGeneric6DofConstraint(btRigidBody &rbA, btRigidBody &rbB,
                btTransform &frameInA,btTransform &frameInB, int
                useLinearReferenceFrameA)
        btGeneric6DofConstraint(btRigidBody &rbB,btTransform &frameInB,
                int useLinearReferenceFrameB)
        void calculateTransforms(btTransform &transA,btTransform &transB)
        void calculateTransforms()
        btTransform & getCalculatedTransformA()
        btTransform & getCalculatedTransformB()
        btTransform & getFrameOffsetA()
        btTransform & getFrameOffsetB()
        void buildJacobian()
        void updateRHS(btScalar timeStep)
        btVector3 getAxis(int axis_index)
        btScalar getAngle(int axis_index)
        btScalar getRelativePivotPosition(int axis_index)
        int testAngularLimitMotor(int axis_index)
        void setLinearLowerLimit(btVector3 &linearLower)
        void setLinearUpperLimit(btVector3 &linearUpper)
        void setAngularLowerLimit(btVector3 &angularLower)
        void setAngularUpperLimit(btVector3 &angularUpper)
        #btRotationalLimitMotor * getRotationalLimitMotor(int index)
        #btTranslationalLimitMotor * getTranslationalLimitMotor()
        void setLimit(int axis, btScalar lo, btScalar hi)
        int isLimited(int limitIndex)
        void calcAnchorPos()
        int getUseFrameOffset()
        void setUseFrameOffset(int frameOffsetOnOff)
        void setParam(int num, btScalar value, int axis)
        btScalar getParam(int num, int axis)


cdef class Generic6DofConstraint(TypedConstraint):

    pass
