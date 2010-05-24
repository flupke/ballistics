

cdef class BroadphaseInterface:

    def __init__(self):
        raise TypeError("can't instantiate abstract base class "
                "BroadphaseInterface")

    def __dealloc__(self):
        del self.wrapped
