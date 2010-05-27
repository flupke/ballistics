cimport numpy as np
import numpy as np
from ballistics.linearmath.vector3 cimport Vector3, wrap_vector3
from ballistics.linearmath.quaternion cimport Quaternion, wrap_quaternion
from ballistics.linearmath.matrix3x3 cimport Matrix3x3, wrap_matrix3x3


cdef public api class Transform[type BstxTransformType, object BstxTransform]:

    def __init__(self, *args):
        nargs = len(args)
        if nargs == 0:
            self.wrapped = new btTransform()
        elif nargs == 1:
            arg = args[0]
            if isinstance(arg, Quaternion):
                self.wrapped = new btTransform((<Quaternion>arg).wrapped[0])
            elif isinstance(arg, Matrix3x3):
                self.wrapped = new btTransform((<Matrix3x3>arg).wrapped[0])
            elif isinstance(arg, Transform):
                self.wrapped = new btTransform((<Transform>arg).wrapped[0])
            else:
                raise TypeError("argument 1 must be a Quaternion, a "
                        "Matrix3x3 or a Transform")
        elif nargs == 2:
            arg1, arg2 = args
            if isinstance(arg1, Quaternion):
                self.wrapped = new btTransform((<Quaternion>arg1).wrapped[0],
                        (<Vector3>arg2).wrapped[0])
            elif isinstance(arg1, Matrix3x3):
                self.wrapped = new btTransform((<Matrix3x3>arg1).wrapped[0],
                        (<Vector3>arg2).wrapped[0])
            else:
                raise TypeError("argument 1 must be a Quaternion or a "
                        "Matrix3x3")    
        else:
            raise ValueError("incorrect number of arguments for "
                    "constructor: %r" % args)

    def __dealloc__(self):
        del self.wrapped

    def getOpenGLMatrix(self):
        """Return the matrix as a 16 elements flat numpy array."""
        cdef btScalar m[16]
        cdef np.ndarray ret = np.empty(16)
        self.wrapped.getOpenGLMatrix(m)
        for i in range(16):
            ret[i] = m[i]
        return ret

    def setFromOpenGLMatrix(self, m):
        """
        Set from a numpy array containing an OpenGL transformation matrix.
        """
        cdef btScalar tmp[16]
        m = m.flatten()
        if m.shape != (16,):
            raise ValueError("input array must have 16 elements")
        for i in range(16):
            tmp[i] = m[i]
        self.wrapped.setFromOpenGLMatrix(tmp)

    property openGLMatrix:
        def __get__(self):
            return self.getOpenGLMatrix()
        def __set__(self, value):
            self.setFromOpenGLMatrix(value)

    def getOrigin(self):
        """Return the origin vector translation."""
        return wrap_vector3(self.wrapped.getOrigin())

    def setOrigin(self, Vector3 origin):
        """Set the translational element."""
        self.wrapped.setOrigin(origin.wrapped[0])

    property origin:
        def __get__(self):
            return self.getOrigin()
        def __set__(self, value):
            self.setOrigin(value)

    def getBasis(self):
        """Return the basis matrix for the rotation."""
        return wrap_matrix3x3(self.wrapped.getBasis())

    def setBasis(self, Matrix3x3 basis):
        """Set the rotational element by Matrix3x3."""
        self.wrapped.setBasis(basis.wrapped[0])

    property basis:
        def __get__(self):
            return self.getBasis()
        def __set__(self, value):
            self.setBasis(value)

    def getRotation(self):
        """Return a quaternion representing the rotation."""
        return wrap_quaternion(self.wrapped.getRotation())

    def setRotation(self, Quaternion q):
        """Set the rotational element by Quaternion."""
        self.wrapped.setRotation(q.wrapped[0])

    property rotation:
        def __get__(self):
            return self.getRotation()
        def __set__(self, value):
            self.setRotation(value)

    def setIdentity(self):
        """Set this transformation to the identity."""
        self.wrapped.setIdentity()

    def mult(self, Transform t1,  Transform t2):
        """
        Set the current transform as the value of the product of two
        transforms.
        """
        self.wrapped.mult(t1.wrapped[0], t2.wrapped[0])

    def inverse(self):
        """Return the inverse of this transform."""
        return wrap_transform(self.wrapped.inverse())

    def inverseTimes(self, Transform t):
        """Return the inverse of this transform times the other transform."""
        return wrap_transform(self.wrapped.inverseTimes(t.wrapped[0]))

    def invXform(self, Vector3 inVec):
        return wrap_vector3(self.wrapped.invXform(inVec.wrapped[0]))

    def copy(self):
        """Return a copy of this Transform object."""
        return Transform(self.basis, self.origin)

    def __call__(self, Vector3 x):
        return wrap_vector3(self.wrapped[0](x.wrapped[0]))

    def __mul__(op1, op2):
        if not isinstance(op1, Transform):
            return NotImplemented
        if isinstance(op2, Vector3):
            return wrap_vector3(
                    (<Transform>op1).wrapped[0] * (<Vector3>op2).wrapped[0])
        if isinstance(op2, Quaternion):
            return wrap_quaternion(
                    (<Transform>op1).wrapped[0] * (<Quaternion>op2).wrapped[0])
        if isinstance(op2, Transform):
            return wrap_transform(
                    (<Transform>op1).wrapped[0] * (<Transform>op2).wrapped[0])
        return NotImplemented

    def __imul__(self, Transform other):
        cdef Transform self_copy = self.copy()
        self_copy.wrapped.imul(other.wrapped[0])
        return self_copy

    def __richcmp__(self, other, int op):
        if not isinstance(other, Transform):
            return False
        eq = (self.basis == other.basis and self.origin == other.origin)
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
        return "Transform(origin=%s, basis=%s)" % (self.origin, self.basis)


def identity():
    """Return an identity transform."""
    return wrap_transform(btTransform_getIdentity())


cdef api wrap_transform(btTransform trans):
    """
    Construct a Transform instance from its C++ counterpart.
    """
    return Transform(wrap_matrix3x3(trans.getBasis()), 
            wrap_vector3(trans.getOrigin()))

