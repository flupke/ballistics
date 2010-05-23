cdef extern from "LinearMath/btVector3.h":
    
    cdef cppclass btVector3:
        float m_floats[4]

        btVector3()
        btVector3(float, float, float)
        float dot(btVector3&)
        float length()
        float length2()
        float distance(btVector3&)
        float distance2(btVector3&)
        btVector3& normalize()
        btVector3 normalized()
        btVector3 rotate(btVector3&, float)
        float angle(btVector3&)
        btVector3 absolute()
        btVector3 cross(btVector3&)
        float triple(btVector3&, btVector3&)
        int minAxis()
        int maxAxis()
        int furthestAxis()
        int closestAxis()
        void setInterpolate3(btVector3&, btVector3&, float)
        btVector3 lerp(btVector3&, float&)
        float x()
        void setX(float)
        float y()
        void setY(float)
        float z()
        void setZ(float)
        void setMax(btVector3&)
        void setMin(btVector3&)
        void setValue(float&, float&, float&)
        void getSkewSymmetricMatrix(btVector3*, btVector3*, btVector3*)
        void setZero()
        bint isZero()
        bint fuzzyZero()


cdef class Vector3:
    """
    Python wrapper for the btVector3 class.
    """

    cdef btVector3 *wrapped


cdef from_c_obj(btVector3 vec)
