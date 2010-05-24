cdef class SequentialImpulseConstraintSolver(ConstraintSolver):

    def __init__(self):
        self.wrapped = <btConstraintSolver*>(
                new btSequentialImpulseConstraintSolver())

