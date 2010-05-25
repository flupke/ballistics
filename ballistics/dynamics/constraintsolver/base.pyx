cdef class ConstraintSolver:

    def __init__(self):
        raise TypeError("can't instantiate abstract base class "
                "ConstraintSolver")

    def __dealloc__(self):
        print "dealloc constraint solver"
        del self.wrapped
