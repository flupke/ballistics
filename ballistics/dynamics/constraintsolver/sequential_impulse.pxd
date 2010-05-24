from ballistics.dynamics.constraintsolver.base cimport btConstraintSolver, \
        ConstraintSolver


cdef extern from "BulletDynamics/ConstraintSolver/btSequentialImpulseConstraintSolver.h":

    cdef cppclass btSequentialImpulseConstraintSolver:
        pass


cdef class SequentialImpulseConstraintSolver(ConstraintSolver):
    pass
