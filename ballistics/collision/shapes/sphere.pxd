from ballistics.linearmath.common cimport btScalar
from ballistics.collision.shapes.base cimport CollisionShape


cdef extern from "BulletCollision/CollisionShapes/btSphereShape.h":

    cdef cppclass btSphereShape:
        btSphereShape(btScalar radius)


cdef class SphereShape(CollisionShape):
    pass 
