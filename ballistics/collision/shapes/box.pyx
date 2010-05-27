from ballistics.collision.shapes.base cimport btCollisionShape
from ballistics.linearmath.vector3 cimport Vector3


cdef class BoxShape(CollisionShape):

    def __init__(self, Vector3 boxHalfExtents):
        self.wrapped = <btCollisionShape*>(new
                btBoxShape(boxHalfExtents.wrapped[0]))

