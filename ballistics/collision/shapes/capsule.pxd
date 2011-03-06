from ballistics.linearmath.common cimport btScalar
from ballistics.collision.shapes.base cimport CollisionShape


cdef extern from "BulletCollision/CollisionShapes/btCapsuleShape.h":

    cdef cppclass btCapsuleShape:
        btCapsuleShape(btScalar radius, btScalar height)

    cdef cppclass btCapsuleShapeX:
        btCapsuleShapeX(btScalar radius, btScalar height)

    cdef cppclass btCapsuleShapeZ:
        btCapsuleShapeZ(btScalar radius, btScalar height)


cdef class CapsuleShape(CollisionShape):
    pass 


cdef class CapsuleShapeX(CollisionShape):
    pass 


cdef class CapsuleShapeZ(CollisionShape):
    pass 

