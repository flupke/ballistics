from ballistics.linearmath.common cimport btScalar
from ballistics.linearmath.vector3 cimport btVector3
from ballistics.collision.shapes.base cimport CollisionShape


cdef extern from "BulletCollision/CollisionShapes/btBoxShape.h":

    cdef cppclass btBoxShape:
        btBoxShape(btVector3& boxHalfExtents) 


cdef class BoxShape(CollisionShape):
    pass 
