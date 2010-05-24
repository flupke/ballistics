"""
Wrapper for the btVector3 class.
"""

cdef class Vector3:
    """
    Python wrapper for the btVector3 class.
    """

    def __init__(self, *args):
        if args:
            x, y, z = args
            self.wrapped = new btVector3(x, y, z)
        else:
            self.wrapped = new btVector3()

    def __dealloc__(self):
        del self.wrapped

    property x:
        def __get__(self):
            return self.wrapped.x()
        def __set__(self, value):
            self.wrapped.setX(value)

    property y:
        def __get__(self):
            return self.wrapped.y()
        def __set__(self, value):
            self.wrapped.setY(value)

    property z:
        def __get__(self):
            return self.wrapped.z()
        def __set__(self, value):
            self.wrapped.setZ(value)

    def dot(self, Vector3 other):
        """Return the dot product."""
        return self.wrapped.dot(other.wrapped[0])

    def length(self):
        """Return the length of the vector."""
        return self.wrapped.length()
    
    def length2(self):
        """Return the length of the vector squared."""
        return self.wrapped.length2()

    def distance(self, Vector3 other):
        """
        Return the distance between the ends of this and another vector This
        is symantically treating the vector like a point.
        """
        return self.wrapped.distance(other.wrapped[0])

    def distance2(self, Vector3 other):
        """
        Return the distance squared between the ends of this and another vector
        This is symantically treating the vector like a point.
        """
        return self.wrapped.distance2(other.wrapped[0])

    def normalize(self):
        """Normalize this vector x^2 + y^2 + z^2 = 1."""
        return from_c_obj(self.wrapped.normalize())

    def normalized(self):
        """Return a normalized version of this vector."""
        return from_c_obj(self.wrapped.normalized())

    def rotate(self, Vector3 w_axis, btScalar angle):
        """Rotate this vector."""
        return from_c_obj(self.wrapped.rotate(w_axis.wrapped[0], angle))

    def angle(self, Vector3 other):
        """Return the angle between this and another vector."""
        return self.wrapped.angle(other.wrapped[0])
    
    def absolute(self):
        """Return a vector will the absolute values of each element."""
        return from_c_obj(self.wrapped[0])

    def cross(self, Vector3 other):
        """Return the cross product between this and another vector."""
        return from_c_obj(self.wrapped.cross(other.wrapped[0]))

    def triple(self, Vector3 v1, Vector3 v2):
        return self.wrapped.triple(v1.wrapped[0], v2.wrapped[0])

    def minAxis(self):
        """
        Return the axis with the smallest value.
        
        Note: return values are 0, 1, 2 for x, y, or z.
        """
        return self.wrapped.minAxis()

    def maxAxis(self):
        """
        Return the axis with the largest value.
        
        Note: return values are 0, 1, 2 for x, y, or z.
        """        
        return self.wrapped.maxAxis()

    def furthestAxis(self):
        return self.wrapped.furthestAxis()

    def closestAxis(self):
        return self.wrapped.closestAxis()

    def setInterpolate3(self, Vector3 v0, Vector3 v1, btScalar rt):
        self.wrapped.setInterpolate3(v0.wrapped[0], v1.wrapped[0], rt)

    def lerp(self, Vector3 v, btScalar t):
        """Return the linear interpolation between this and another vector."""
        return from_c_obj(self.wrapped.lerp(v.wrapped[0], t))
    
    def setMax(self, Vector3 other):
        """
        Set each element to the max of the current values and the values of
        another Vector3.
        """
        self.wrapped.setMax(other.wrapped[0])

    def setMin(self, Vector3 other):
        """
        Set each element to the min of the current values and the values of
        another Vector3.
        """
        self.wrapped.setMin(other.wrapped[0])

    def setValue(self, btScalar x, btScalar y, btScalar z):
        self.wrapped.setValue(x, y, z)

    def getSkewSymmetricMatrix(self, Vector3 v0, Vector3 v1, Vector3 v2):
        self.wrapped.getSkewSymmetricMatrix(v0.wrapped, v1.wrapped,
                v2.wrapped)

    def setZero(self):
        self.wrapped.setZero()

    def isZero(self):
        return self.wrapped.isZero()

    def fuzzyZero(self):
        return self.wrapped.fuzzyZero()

    def copy(self):
        """
        Return a copy of this vector.
        """
        return Vector3(self.x, self.y, self.z)

    def __iadd__(self, other):
        self.x = self.x + other.x
        self.y = self.y + other.y
        self.z = self.z + other.z
        return self

    def __isub__(self, other):
        self.x = self.x - other.x
        self.y = self.y - other.y
        self.z = self.z - other.z
        return self

    def __imul__(self, other):
        self.x = self.x * other.x
        self.y = self.y * other.y
        self.z = self.z * other.z
        return self

    def __idiv__(self, other):
        self.x = self.x / other.x
        self.y = self.y / other.y
        self.z = self.z / other.z
        return self

    def __richcmp__(self, other, int op):
        if not isinstance(other, Vector3):
            return False
        eq = (self.x == other.x and self.y == other.y and self.z == other.z)
        if op == 2:
            # ==
            return eq
        elif op == 3:
            # !=
            return not eq
        else:
            raise NotImplementedError("comparison operator not implemented, "
                    "only == and != are supported.")

    def __repr__(self):
        return "Vector3(%s, %s, %s)" % (self.x, self.y, self.z)


cdef from_c_obj(btVector3 vec):
    """
    Construct a Vector3 instance from its C++ counterpart.
    """
    return Vector3(vec.x(), vec.y(), vec.z())
