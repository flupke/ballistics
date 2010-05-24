from ballistics.linearmath.common cimport btScalar
from ballistics.linearmath.vector3 cimport btVector3
from ballistics.linearmath.quaternion cimport btQuaternion


cdef extern from "LinearMath/btMatrix3x3.h":

    cdef cppclass btMatrix3x3:
        btMatrix3x3()
        btMatrix3x3(btQuaternion &q)
        btMatrix3x3(float xx, float xy, float xz, float yx, float yy,
                float yz, float zx, float zy, float zz)
        btMatrix3x3(btMatrix3x3 &other)
        btVector3 getColumn(int i) 
        btVector3& getRow(int i) 
        btVector3& operator[](int i) 
        void setFromOpenGLSubMatrix(float *m)
        void setValue(float &xx, float &xy, float &xz, float &yx, float &yy,
                float &yz, float &zx, float &zy, float &zz)
        void setRotation(btQuaternion &q)
        void setEulerYPR(float &yaw, float &pitch, float &roll)
        void setEulerZYX(float eulerX, float eulerY, float eulerZ)
        void setIdentity()
        void getOpenGLSubMatrix(float *m) 
        void getRotation(btQuaternion &q) 
        void getEulerYPR(float &yaw, float &pitch, float &roll) 
        void getEulerZYX(float &yaw, float &pitch, float &roll,
                unsigned int solution_number) 
        btMatrix3x3 scaled(btVector3 &s) 
        float determinant() 
        btMatrix3x3 adjoint() 
        btMatrix3x3 absolute() 
        btMatrix3x3 transpose() 
        btMatrix3x3 inverse() 
        btMatrix3x3 transposeTimes(btMatrix3x3 &m) 
        btMatrix3x3 timesTranspose(btMatrix3x3 &m) 
        float tdotx(btVector3 &v) 
        float tdoty(btVector3 &v) 
        float tdotz(btVector3 &v) 
        void diagonalize(btMatrix3x3 &rot, float threshold, int maxSteps)
        float cofac(int r1, int c1, int r2, int c2) 
        btMatrix3x3& imul "operator*=" (btMatrix3x3&)

    cdef btMatrix3x3& btMatrix3x3_getIdentity "btMatrix3x3::getIdentity" ()


cdef class Matrix3x3:

    cdef btMatrix3x3 *wrapped


cdef from_c_obj(btMatrix3x3 mat)
