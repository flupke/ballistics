cdef class CollisionConfiguration:
    """
    Virtual base class.
    """

    def __init__(self):
        raise TypeError("can't instantiate abstract base class "
                "CollisionConfiguration")

    def __dealloc__(self):
        del self.wrapped


cdef class DefaultCollisionConfiguration(CollisionConfiguration):
    
    def __cinit__(self):
        self.wrapped = <btCollisionConfiguration*>(
                new btDefaultCollisionConfiguration())

    def __init__(self):
        pass
