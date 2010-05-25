from ballistics.linearmath.common cimport btScalar
from ballistics.linearmath.vector3 cimport btVector3
from ballistics.linearmath.quaternion cimport btQuaternion
from ballistics.linearmath.matrix3x3 cimport btMatrix3x3


cdef extern from "LinearMath/btTransform.h":

    cdef cppclass btTransform:
        btTransform()
        btTransform(btQuaternion q)
        btTransform(btQuaternion q, btVector3 c)
        btTransform(btMatrix3x3 b)
        btTransform(btMatrix3x3 b, btVector3 c)
        btTransform(btTransform &other)
        void getOpenGLMatrix(btScalar *m) 
        void setFromOpenGLMatrix(btScalar *m)
        btVector3& getOrigin()
        void setOrigin(btVector3 &origin)
        btMatrix3x3& getBasis() 
        void setBasis(btMatrix3x3 &basis)
        btQuaternion getRotation() 
        void setRotation(btQuaternion &q)
        void setIdentity()
        void mult(btTransform &t1,  btTransform &t2)
        btTransform inverse() 
        btTransform inverseTimes(btTransform &t) 
        btVector3 invXform(btVector3 &inVec) 
        btVector3 operator()(btVector3 &x) 
        btVector3 operator*(btVector3 &x) 
        btQuaternion operator*(btQuaternion &q) 
        btTransform& imul "operator*=" (btTransform &t)
        btTransform operator*(btTransform &t) 

    cdef btTransform& btTransform_getIdentity "btTransform::getIdentity" ()


cdef class Transform:

    cdef btTransform *wrapped


cdef public wrap_transform(btTransform trans)
