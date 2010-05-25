from ballistics.linearmath.common cimport btScalar
from ballistics.linearmath.vector3 cimport btVector3


cdef extern from "BulletCollision/CollisionShapes/btCollisionShape.h":

    cdef cppclass btCollisionShape:
        void calculateLocalInertia(btScalar mass, btVector3& inertia)


cdef class CollisionShape:

    cdef btCollisionShape *wrapped
