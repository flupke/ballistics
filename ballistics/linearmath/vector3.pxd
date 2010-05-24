from ballistics.linearmath.common cimport btScalar


cdef extern from "LinearMath/btVector3.h":
    
    cdef cppclass btVector3:
        btScalar m_btScalars[4]

        btVector3()
        btVector3(btScalar, btScalar, btScalar)
        btScalar dot(btVector3&)
        btScalar length()
        btScalar length2()
        btScalar distance(btVector3&)
        btScalar distance2(btVector3&)
        btVector3& normalize()
        btVector3 normalized()
        btVector3 rotate(btVector3&, btScalar)
        btScalar angle(btVector3&)
        btVector3 absolute()
        btVector3 cross(btVector3&)
        btScalar triple(btVector3&, btVector3&)
        int minAxis()
        int maxAxis()
        int furthestAxis()
        int closestAxis()
        void setInterpolate3(btVector3&, btVector3&, btScalar)
        btVector3 lerp(btVector3&, btScalar&)
        btScalar x()
        void setX(btScalar)
        btScalar y()
        void setY(btScalar)
        btScalar z()
        void setZ(btScalar)
        void setMax(btVector3&)
        void setMin(btVector3&)
        void setValue(btScalar&, btScalar&, btScalar&)
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
