from ballistics.linearmath.transform cimport btTransform


cdef extern from "LinearMath/btMotionState.h":

    cdef cppclass btMotionState:
        pass


cdef extern from "LinearMath/btDefaultMotionState.h":

    cdef cppclass btDefaultMotionState:
        btTransform m_graphicsWorldTrans
        btTransform m_centerOfMassOffset
        btTransform m_startWorldTrans
        void* m_userPointer

        btDefaultMotionState()
        btDefaultMotionState(btTransform&)
        btDefaultMotionState(btTransform&, btTransform&)


cdef class MotionState:

    cdef btMotionState *wrapped


cdef class DefaultMotionState(MotionState):
    pass


cdef wrap_default_motion_state(btDefaultMotionState *state)
