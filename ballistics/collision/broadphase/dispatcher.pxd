cdef extern from "BulletCollision/BroadphaseCollision/btDispatcher.h":

    cdef cppclass btDispatcher:
        pass


cdef class Dispatcher:

    cdef btDispatcher *wrapped
