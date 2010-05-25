from ballistics.linearmath.vector3 cimport Vector3
from ballistics.collision.shapes.base cimport btCollisionShape


cdef class StaticPlaneShape(CollisionShape):

    def __init__(self, Vector3 planeNormal, btScalar planeConstant):
        self.planeNormal = planeNormal
        self.wrapped = <btCollisionShape*>(
                new btStaticPlaneShape(planeNormal.wrapped[0], planeConstant))
