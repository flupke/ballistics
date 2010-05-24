from ballistics.linearmath.quaternion cimport Quaternion
from ballistics.linearmath.vector3 cimport Vector3, \
        from_c_obj as vector3_from_c_obj
cimport numpy as np
import numpy as np


cdef class Matrix3x3:

    def __init__(self, *args):
        nargs = len(args)
        if nargs == 0:
            self.wrapped = new btMatrix3x3()
        elif nargs == 1:
            arg = args[0]
            if isinstance(arg, Quaternion):
                self.wrapped = new btMatrix3x3((<Quaternion>arg).wrapped[0])
            elif isinstance(arg, Matrix3x3):
                self.wrapped = new btMatrix3x3((<Matrix3x3>arg).wrapped[0])
            else:
                raise TypeError("expected a Quaternion or Matrix3x3 instance, "
                        "got %s" % type(arg))
        elif nargs == 9:
            xx, xy, xz, yx, yy, yz, zx, zy, zz = args
            self.wrapped = new btMatrix3x3(xx, xy, xz, yx, yy, yz, zx, zy, zz)
        else:
            raise ValueError("incorrect number of arguments for "
                    "constructor: %r" % args)

    def __dealloc__(self):
        del self.wrapped

    def getColumn(self, int i):
        """Get a column of the matrix as a vector."""
        return vector3_from_c_obj(self.wrapped.getColumn(i))

    def getRow(self, int i):
        """Get a row of the matrix as a vector."""
        return vector3_from_c_obj(self.wrapped.getRow(i))

    def __getitem__(self, int i):
        """Get a row of the matrix as a vector."""
        return self.getRow(i)

    def setValue(self, btScalar xx, btScalar xy, btScalar xz, btScalar yx,
            btScalar yy, btScalar yz, btScalar zx, btScalar zy, btScalar zz):
        """Set the values of the matrix explicitly (row major)."""
        self.wrapped.setValue(xx, xy, xz, yx, yy, yz, zx, zy, zz)

    def setRotation(self, Quaternion q):
        """Set the matrix from a quaternion."""
        self.wrapped.setRotation(q.wrapped[0])
    
    def setIdentity(self):
        """Set the matrix to the identity."""
        self.wrapped.setIdentity()

    def setFromOpenGLSubMatrix(self, m):
        """Set from a carray of btScalars."""
        cdef btScalar tmp[12]
        m = m.flatten()
        if m.shape != (12,):
            raise ValueError("input array must have 12 elements")
        for i in range(12):
            tmp[i] = m[i]
        self.wrapped.setFromOpenGLSubMatrix(tmp)

    def getOpenGLSubMatrix(self):
        """Return the matrix as a 12 elements flat numpy array."""
        cdef btScalar m[12]
        cdef np.ndarray ret = np.empty(12)
        self.wrapped.getOpenGLSubMatrix(m)
        for i in range(12):
            ret[i] = m[i]
        return ret

    def getRotation(self):
        """Get the matrix represented as a :class:`Quaternion`."""
        cdef Quaternion q = Quaternion()
        self.wrapped.getRotation(q.wrapped[0])
        return q

    def getEulerYPR(self):
        """
        Get the matrix represented as euler angles around YXZ, roundtrip with
        setEulerYPR.
        """
        cdef btScalar yaw, pitch, roll
        self.wrapped.getEulerYPR(yaw, pitch, roll)
        return (yaw, pitch, roll)

    def setEulerYPR(self, btScalar yaw, btScalar pitch, btScalar roll):
        """
        Set the matrix from euler angles using YPR around YXZ respectively.
        """
        self.wrapped.setEulerYPR(yaw, pitch, roll)

    def getEulerZYX(self):
        """
        Get the matrix represented as euler angles around ZYX.
        """
        cdef btScalar yaw, pitch, roll
        self.wrapped.getEulerZYX(yaw, pitch, roll, 1)
        return (yaw, pitch, roll)

    def setEulerZYX(self, btScalar eulerX, btScalar eulerY, btScalar eulerZ):
        """Set the matrix from euler angles YPR around ZYX axes."""
        self.wrapped.setEulerZYX(eulerX, eulerY, eulerZ)

    def scaled(self, Vector3 s):
        """Create a scaled copy of the matrix."""
        return from_c_obj(self.wrapped.scaled(s.wrapped[0]))

    def determinant(self):
        """Return the determinant of the matrix."""
        return self.wrapped.determinant()

    def adjoint(self):
        """Return the adjoint of the matrix."""
        return from_c_obj(self.wrapped.adjoint())

    def absolute(self):
        """Return the matrix with all values non negative."""
        return from_c_obj(self.wrapped.absolute())

    def transpose(self):
        """Return the transpose of the matrix."""
        return from_c_obj(self.wrapped.transpose())

    def inverse(self):
        """Return the inverse of the matrix."""
        return from_c_obj(self.wrapped.inverse())

    def transposeTimes(self, Matrix3x3 m):
        return from_c_obj(self.wrapped.transposeTimes(m.wrapped[0]))

    def timesTranspose(self, Matrix3x3 m):
        return from_c_obj(self.wrapped.timesTranspose(m.wrapped[0]))

    def tdotx(self, Vector3 v):
        return self.wrapped.tdotx(v.wrapped[0])

    def tdoty(self, Vector3 v):
        return self.wrapped.tdoty(v.wrapped[0])

    def tdotz(self, Vector3 v):
        return self.wrapped.tdotz(v.wrapped[0])

    def diagonalize(self, Matrix3x3 rot, btScalar threshold, int maxSteps):
        """Diagonalizes this matrix by the Jacobi method."""
        self.wrapped.diagonalize(rot.wrapped[0], threshold, maxSteps)

    def cofac(self, int r1, int c1, int r2, int c2):
        """Calculate the matrix cofactor."""
        return self.wrapped.cofac(r1, c1, r2, c2)

    def copy(self):
        """Return a copy of this matrix."""
        return Matrix3x3(self)

    def __imul__(self, Matrix3x3 other):
        cdef btMatrix3x3 ret
        cdef Matrix3x3 self_copy = self.copy()
        self_copy.wrapped.imul(other.wrapped[0])
        return self_copy

    def __repr__(self):
        parts = ["Matrix3x3("]
        for i in range(3):
            row = self.getRow(i)
            parts.append("    %-8.5f %-8.5f %-8.5f" % (row.x, row.y, row.z))
        parts.append(")")
        return "\n".join(parts)

    def __richcmp__(self, other, int op):
        if not isinstance(other, Matrix3x3):
            return False
        eq = True
        for i in range(3):
            if self.getRow(i) != other.getRow(i):
                eq = False
                break
        if op == 2:
            # ==
            return eq
        elif op == 3:
            # !=
            return not eq
        else:
            raise NotImplementedError("comparison operator not implemented, "
                    "only == and != are supported.")


def identity():
    """
    Return the identity matrix.
    """
    return from_c_obj(btMatrix3x3_getIdentity())


cdef from_c_obj(btMatrix3x3 mat):
    """
    Construct a Matrix3x3 instance from its C++ counterpart.
    """
    cdef btScalar xx, xy, xz, yx, yy, yz, zx, zy, zz
    cdef btVector3 row
    row = mat.getRow(0)
    xx = row.x()
    xy = row.y()
    xz = row.z()
    row = mat.getRow(1)
    yx = row.x()
    yy = row.y()
    yz = row.z()
    row = mat.getRow(2)
    zx = row.x()
    zy = row.y()
    zz = row.z()
    return Matrix3x3(xx, xy, xz, yx, yy, yz, zx, zy, zz)
