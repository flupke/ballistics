from ballistics.linearmath.vector3 cimport Vector3


cdef class CollisionShape:

    def __init__(self):
        raise TypeError("can't instantiate abstract base class "
                "CollisionShape")

    def __dealloc__(self):
        print "dealloc collision shape"
        del self.wrapped

    def calculateLocalInertia(self, btScalar mass):
        ret = Vector3()
        self.wrapped.calculateLocalInertia(mass, ret.wrapped[0])
        return ret
