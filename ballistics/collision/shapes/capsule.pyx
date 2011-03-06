from ballistics.collision.shapes.base cimport btCollisionShape


cdef class CapsuleShape(CollisionShape):

    def __init__(self, btScalar radius, btScalar height):
        self.wrapped = <btCollisionShape*>(new btCapsuleShape(radius, height))


cdef class CapsuleShapeX(CollisionShape):

    def __init__(self, btScalar radius, btScalar height):
        self.wrapped = <btCollisionShape*>(new btCapsuleShapeX(radius, height))


cdef class CapsuleShapeZ(CollisionShape):

    def __init__(self, btScalar radius, btScalar height):
        self.wrapped = <btCollisionShape*>(new btCapsuleShapeZ(radius, height))


