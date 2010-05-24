from ballistics.linearmath.vector3 cimport Vector3
from ballistics.collision.broadphase.dispatcher cimport Dispatcher
from ballistics.collision.broadphase.interface cimport BroadphaseInterface
from ballistics.collision.dispatch.config cimport CollisionConfiguration
from ballistics.dynamics.constraintsolver.base cimport ConstraintSolver


cdef class DiscreteDynamicsWorld:

    def __cinit__(self, Dispatcher dispatcher,
            BroadphaseInterface pairCache,
            ConstraintSolver constraintSolver, 
            CollisionConfiguration collisionConfiguration):
        self.wrapped = new btDiscreteDynamicsWorld(dispatcher.wrapped,
                pairCache.wrapped, constraintSolver.wrapped,
                collisionConfiguration.wrapped)

    def __dealloc__(self):
        del self.wrapped

    def setGravity(self, Vector3 vec):
        self.wrapped.setGravity(vec.wrapped[0])
