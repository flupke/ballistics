cdef extern from "BulletCollision/BroadphaseCollision/btBroadphaseInterface.h":

    cdef cppclass btBroadphaseAabbCallback:
        pass

    cdef cppclass btBroadphaseRayCallback:
        pass

    cdef cppclass btBroadphaseInterface:
        pass


cdef class BroadphaseInterface:

    cdef btBroadphaseInterface *wrapped
