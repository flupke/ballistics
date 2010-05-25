from ballistics.collision.shapes.base cimport btCollisionShape


cdef class SphereShape(CollisionShape):

    def __init__(self, btScalar radius):
        self.wrapped = <btCollisionShape*>(new btSphereShape(radius))

