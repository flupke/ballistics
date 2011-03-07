from ballistics.dynamics.constraintsolver.typed_constraint cimport TypedConstraint


cdef extern from "BulletDynamics/ConstraintSolver/btPoint2PointConstraint.h":

    cdef cppclass btPoint2PointConstraint:
        
        btPoint2PointConstraint(btRigidBody &rbA, btRigidBody &rbB, 
                btVector3 &pivotInA, btVector3 &pivotInB)
        btPoint2PointConstraint(btRigidBody &rbA, btVector3 &pivotInA)
        void updateRHS (btScalar timeStep)
        void setPivotA (btVector3 &pivotA)
        void setPivotB (btVector3 &pivotB)
        btVector3& getPivotInA() 
        btVector3& getPivotInB()
        void setParam (int num, btScalar value, int axis=-1)
        """
        Override the default global value of a parameter (such as ERP or CFM),
        optionally provide the axis (0..5). 
        """
        btScalar getParam (int num, int axis=-1) const
        """
        Return the local value of parameter 
        """


cdef class Point2PointConstraint(TypedConstraint):

    cdef btPoint2PointConstraint *wrapped
