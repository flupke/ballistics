cdef extern from "BulletDynamics/ConstraintSolver/btTypedConstraint.h":

    cdef cppclass btTypedConstraint:
        pass


cdef class TypedConstraint:

    cdef btTypedConstraint *wrapped

