from ballistics.linearmath.common cimport btScalar
from ballistics.linearmath.vector3 cimport btVector3
from ballistics.collision.shapes.base cimport CollisionShape


cdef extern from "BulletCollision/CollisionShapes/btStaticPlaneShape.h":

    cdef cppclass btStaticPlaneShape:
        btStaticPlaneShape(btVector3& planeNormal, btScalar planeConstant)


cdef class StaticPlaneShape(CollisionShape):
    
    cdef object planeNormal

