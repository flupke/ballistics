from ballistics.linearmath.transform cimport btTransform
from cpython.ref cimport PyObject


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


cdef extern from "bstx_motion_state.h":

    cdef cppclass BstxMotionState:
        BstxMotionState(btTransform &initialTrans, object instance)
        void getWorldTransform(btTransform &worldTrans)
        void setWorldTransform(btTransform &worldTrans)
        void setKinematicTransform(btTransform &kineTrans)

    void BstxMotionState_init "BstxMotionState::init"()


cdef class MotionState:

    cdef btMotionState *wrapped


cdef class DefaultMotionState(MotionState):
    pass


cdef class BallisticsMotionState(MotionState):
    pass


cdef wrap_default_motion_state(btDefaultMotionState *state)
