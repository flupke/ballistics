from ballistics.dynamics.constraintsolver.typed_constraint cimport TypedConstraint
from ballistics.dynamics.rigid_body cimport btRigidBody
from ballistics.linearmath.vector3 cimport btVector3
from ballistics.linearmath.common cimport btScalar


cdef extern from "BulletDynamics/ConstraintSolver/btPoint2PointConstraint.h":

    cdef cppclass btPoint2PointConstraint:
        
        btPoint2PointConstraint(btRigidBody &rbA, btRigidBody &rbB, 
                btVector3 &pivotInA, btVector3 &pivotInB)
        btPoint2PointConstraint(btRigidBody &rbA, btVector3 &pivotInA)
        void updateRHS(btScalar timeStep)
        void setPivotA(btVector3 &pivotA)
        void setPivotB(btVector3 &pivotB)
        btVector3& getPivotInA() 
        btVector3& getPivotInB()
        void setParam(int num, btScalar value, int axis)
        btScalar getParam(int num, int axis) 


cdef class Point2PointConstraint(TypedConstraint):

    pass
