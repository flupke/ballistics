cdef extern from "BulletCollision/CollisionDispatch/btCollisionConfiguration.h":

    cdef cppclass btCollisionConfiguration:
        pass


cdef extern from "BulletCollision/CollisionDispatch/btDefaultCollisionConfiguration.h":

    cdef cppclass btDefaultCollisionConfiguration:
        pass


cdef class CollisionConfiguration:

    cdef btCollisionConfiguration *wrapped


cdef class DefaultCollisionConfiguration(CollisionConfiguration):    
    pass
