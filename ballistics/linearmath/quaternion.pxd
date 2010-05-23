from ballistics.linearmath.vector3 cimport btVector3


cdef extern from "LinearMath/btQuaternion.h":

    cdef cppclass btQuaternion:
        btQuaternion()
        btQuaternion(float, float, float, float)
        btQuaternion(btVector3&, float)
        btQuaternion(float, float, float)
        void setRotation(btVector3&, float&)
        void setEuler(float&, float&, float&)
        float dot(btQuaternion&)
        float length2()
        float length()
        btQuaternion& normalize()
        btQuaternion normalized() 
        float angle(btQuaternion&) 
        float getAngle() 
        btVector3 getAxis() 
        btQuaternion inverse() 
        btQuaternion farthest(btQuaternion&) 
        btQuaternion nearest(btQuaternion&) 
        btQuaternion slerp(btQuaternion&, float&) 
        float x()
        void setX(float)
        float y()
        void setY(float)
        float z()
        void setZ(float)
        float w()
        float setW(float) 
        btQuaternion operator*(float&) 
        btQuaternion operator/(float&) 
        btQuaternion operator+(btQuaternion&) 
        btQuaternion operator-(btQuaternion&) 
        btQuaternion operator-() 


cdef class Quaternion:

    cdef btQuaternion *wrapped
