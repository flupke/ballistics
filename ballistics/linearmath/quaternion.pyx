"""
Wrapper for the btQuaternion class.
"""

from ballistics.linearmath.vector3 cimport Vector3, wrap_vector3


cdef class Quaternion:

    def __init__(self, *args):
        if len(args) == 4:
            x, y, z, w = args
            self.wrapped = new btQuaternion(x, y, z, w)
        elif len(args) == 3:
            yaw, pitch, roll = args
            self.wrapped = new btQuaternion(yaw, pitch, roll)
        elif len(args) == 2:
            axis, angle = args
            self.wrapped = new btQuaternion((<Vector3>axis).wrapped[0], angle)
        elif len(args) == 0:
            self.wrapped = new btQuaternion()
        else:
            raise ValueError("incorrect number of arguments for "
                    "constructor: %r" % args)

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

    property w:
        def __get__(self):
            return self.wrapped.w()
        def __set__(self, value):
            self.wrapped.setW(value)

    def dot(self, Quaternion other):
        """Return the dot product between this quaternion and another."""
        return self.wrapped.dot(other.wrapped[0])

    def length(self):
        """Return the length of the quaternion."""
        return self.wrapped.length()
    
    def length2(self):
        """Return the length of the quaternion squared."""
        return self.wrapped.length2()

    def normalize(self):
        """Normalize the quaternion Such that x^2 + y^2 + z^2 +w^2 = 1."""
        return wrap_quaternion(self.wrapped.normalize())

    def normalized(self):
        """Return a normalized version of this quaternion."""
        return wrap_quaternion(self.wrapped.normalized())

    def angle(self, Quaternion other):
        """Return the angle between this quaternion and the other."""
        return self.wrapped.angle(other.wrapped[0])
    
    def getAngle(self):
        """Return the angle of rotation represented by this quaternion."""
        return self.wrapped.getAngle()

    def getAxis(self):
        """Return the axis of the rotation represented by this quaternion."""
        return wrap_vector3(self.wrapped.getAxis())
    
    def inverse(self):
        """Return the inverse of this quaternion."""
        return wrap_quaternion(self.wrapped.inverse())

    def farthest(self, Quaternion qd):
        return wrap_quaternion(self.wrapped.farthest(qd.wrapped[0]))

    def nearest(self, Quaternion qd):
        return wrap_quaternion(self.wrapped.nearest(qd.wrapped[0]))
    
    def slerp(self, Quaternion q, btScalar t):
        """
        Return the quaternion which is the result of Spherical Linear
        Interpolation between this and the other quaternion.
        """
        return wrap_quaternion(self.wrapped.slerp(q.wrapped[0], t))

    def setRotation(self, Vector3 axis, btScalar angle):
        """Set the rotation using axis angle notation."""
        self.wrapped.setRotation(axis.wrapped[0], angle)

    def setEuler(self, btScalar yaw, btScalar pitch, btScalar roll):
        """Set the quaternion using Euler angles."""
        self.wrapped.setEuler(yaw, pitch, roll)

    def copy(self):
        """Return a copy of this quaternion."""
        return Quaternion(self.x, self.y, self.z, self.w)

    def __repr__(self):
        return "Quaternion(%s, %s, %s, %s)" % (self.x, self.y, self.z, self.w)

    def __richcmp__(self, other, int op):
        if not isinstance(other, Quaternion):
            return False
        eq = (self.x == other.x and self.y == other.y and self.z == other.z and
                self.w == other.w)
        if op == 2:
            # ==
            return eq
        elif op == 3:
            # !=
            return not eq
        else:
            raise NotImplementedError("comparison operator not implemented, "
                    "only == and != are supported.")

    def __mul__(op1, op2):
       if isinstance(op1, Quaternion):
           return wrap_quaternion((<Quaternion>op1).wrapped[0] * <float>op2)
       else:
           return wrap_quaternion((<Quaternion>op2).wrapped[0] * <float>op1)

    def __div__(op1, op2):
       if isinstance(op1, Quaternion):
           return wrap_quaternion((<Quaternion>op1).wrapped[0] / <float>op2)
       else:
           return NotImplemented

    def __add__(Quaternion op1, Quaternion op2):
        return wrap_quaternion(op1.wrapped[0] + op2.wrapped[0])

    def __sub__(Quaternion op1, Quaternion op2):
        return wrap_quaternion(op1.wrapped[0] - op2.wrapped[0])

    def __neg__(self):
        return wrap_quaternion(-self.wrapped[0])


cdef wrap_quaternion(btQuaternion quat):
    """
    Construct a Quaternion instance from its C++ counterpart.
    """
    return Quaternion(quat.x(), quat.y(), quat.z(), quat.w())
