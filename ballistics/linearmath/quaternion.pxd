from ballistics.linearmath.vector3 cimport btVector3
from ballistics.linearmath.common cimport btScalar


cdef extern from "LinearMath/btQuaternion.h":

    cdef cppclass btQuaternion:
        btQuaternion()
        btQuaternion(btScalar, btScalar, btScalar, btScalar)
        btQuaternion(btVector3&, btScalar)
        btQuaternion(btScalar, btScalar, btScalar)
        void setRotation(btVector3&, btScalar&)
        void setEuler(btScalar&, btScalar&, btScalar&)
        btScalar dot(btQuaternion&)
        btScalar length2()
        btScalar length()
        btQuaternion& normalize()
        btQuaternion normalized() 
        btScalar angle(btQuaternion&) 
        btScalar getAngle() 
        btVector3 getAxis() 
        btQuaternion inverse() 
        btQuaternion farthest(btQuaternion&) 
        btQuaternion nearest(btQuaternion&) 
        btQuaternion slerp(btQuaternion&, btScalar&) 
        btScalar x()
        void setX(btScalar)
        btScalar y()
        void setY(btScalar)
        btScalar z()
        void setZ(btScalar)
        btScalar w()
        btScalar setW(btScalar) 
        btQuaternion operator*(btScalar&) 
        btQuaternion operator/(btScalar&) 
        btQuaternion operator+(btQuaternion&) 
        btQuaternion operator-(btQuaternion&) 
        btQuaternion operator-() 


cdef class Quaternion:

    cdef btQuaternion *wrapped


cdef from_c_obj(btQuaternion quat)
