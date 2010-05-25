

cdef class BroadphaseInterface:

    def __init__(self):
        raise TypeError("can't instantiate abstract base class "
                "BroadphaseInterface")

    def __dealloc__(self):
        print "dealloc broadphase interface"
        del self.wrapped
