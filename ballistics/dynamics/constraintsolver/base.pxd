cdef extern from "BulletDynamics/ConstraintSolver/btConstraintSolver.h":

    cdef cppclass btConstraintSolver:
        pass


cdef class ConstraintSolver:

    cdef btConstraintSolver *wrapped
