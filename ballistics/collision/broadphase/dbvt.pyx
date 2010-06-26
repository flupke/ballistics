from ballistics.collision.broadphase.interface cimport btBroadphaseInterface
from ballistics.collision.broadphase.dispatcher cimport Dispatcher


cdef class DbvtBroadphase:
    """
    The DbvtBroadphase implements a broadphase using two dynamic AABB
    bounding volume hierarchies/trees (see btDbvt).

    One tree is used for static/non-moving objects, and another tree is used
    for dynamic objects. Objects can move from one tree to the other. This is a
    very fast broadphase, especially for very dynamic worlds where many objects
    are moving. Its insert/add and remove of objects is generally faster than
    the sweep and prune broadphases AxisSweep3 and _32BitAxisSweep3.
    """

    def __init__(self):
        self.wrapped = <btBroadphaseInterface*>(new btDbvtBroadphase())
