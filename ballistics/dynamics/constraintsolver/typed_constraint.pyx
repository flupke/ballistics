cdef class TypedConstraint:
    """
    Base class of constraints.
    """

    def __init__(self):
        raise TypeError("can't instantiate abstract class")

    def __dealloc__(self):
        del self.wrapped
