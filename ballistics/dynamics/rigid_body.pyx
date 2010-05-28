from ballistics.linearmath.motion_state cimport MotionState, \
        wrap_default_motion_state, btDefaultMotionState
from ballistics.linearmath.vector3 cimport Vector3
from ballistics.collision.shapes.base cimport CollisionShape


cdef class RigidBodyConstructionInfo:

    def __init__(self, btScalar mass, MotionState motionState,
            CollisionShape collisionShape, Vector3 localInertia=None):
        self.motionState = motionState
        self.collisionShape = collisionShape
        self.localInertia = localInertia
        if localInertia is None:
            self.wrapped = new btRigidBodyConstructionInfo(mass,
                    motionState.wrapped, collisionShape.wrapped)
        else:
            self.wrapped = new btRigidBodyConstructionInfo(mass,
                    motionState.wrapped, collisionShape.wrapped,
                    localInertia.wrapped[0])

    def __dealloc__(self):
        del self.wrapped


cdef class RigidBody:

    def __cinit__(self, RigidBodyConstructionInfo ci):
        self.constructionInfo = ci
        self.wrapped = new btRigidBody(ci.wrapped[0])

    def __dealloc__(self):
        del self.wrapped

    def getMotionState(self):
        return wrap_default_motion_state(
                <btDefaultMotionState*>self.wrapped.getMotionState())

    def setMotionState(self, MotionState motionState):
        self.wrapped.setMotionState(motionState.wrapped)

    property motionState:
        def __get__(self):
            return self.getMotionState()
        def __set__(self, value):
            self.setMotionState(value)
