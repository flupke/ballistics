from ballistics.collision.broadphase.interface cimport btBroadphaseInterface


cdef class DbvtBroadphase:

    def __init__(self):
        self.wrapped = <btBroadphaseInterface*>(new btDbvtBroadphase())

