from ballistics.linearmath.transform cimport Transform, wrap_transform
from ballistics.linearmath.transform import identity


cdef class MotionState:

    def __init__(self, *args):
        raise TypeError("can't instantiate abstract base class MotionState")

    def __dealloc__(self):
        del self.wrapped   


cdef class DefaultMotionState(MotionState):

    def __init__(self, *args):
        nargs = len(args)
        if nargs == 0:
            self.wrapped = <btMotionState*>(new btDefaultMotionState())
        elif nargs == 1:
            startTrans = args[0]
            self.wrapped = <btMotionState*>(new btDefaultMotionState(
                    (<Transform>startTrans).wrapped[0]))
        elif nargs == 2:
            startTrans, centerOfMassOffset = args
            self.wrapped = <btMotionState*>(new btDefaultMotionState(
                    (<Transform>startTrans).wrapped[0],
                    (<Transform>centerOfMassOffset).wrapped[0]))
        else:
            raise ValueError("incorrect number of arguments for "
                    "constructor: %r" % args)

    property worldTransform:
        """
        This property returns the :class:`Transform` that must be
        applied to the simulated object to match the physical simulation
        position.

        Setting it changes the position of kinematic objects.
        """
        def __get__(self):
            return wrap_transform(
                    (<btDefaultMotionState*>self.wrapped).m_graphicsWorldTrans)
        def __set__(self, Transform value):
            (<btDefaultMotionState*>self.wrapped).m_graphicsWorldTrans = \
                    value.wrapped[0]


cdef class BallisticsMotionState(MotionState):
    pass


cdef wrap_default_motion_state(btDefaultMotionState *state):
    """
    Create a DefaultMotionState instance from its C++ counterpart.
    """
    return DefaultMotionState(wrap_transform(state.m_graphicsWorldTrans),
            wrap_transform(state.m_centerOfMassOffset))
