cdef class TypedConstraint:
    """
    Base class of constraints.
    """

    def __init__(self):
        raise TypeError("can't instantiate abstract class")

    def __dealloc__(self):
        if self.wrapped:
            del self.wrapped
