from ballistics.linearmath.vector3 cimport Vector3
from ballistics.collision.broadphase.dispatcher cimport Dispatcher
from ballistics.collision.broadphase.interface cimport BroadphaseInterface
from ballistics.collision.dispatch.config cimport CollisionConfiguration
from ballistics.dynamics.constraintsolver.base cimport ConstraintSolver
from ballistics.dynamics.rigid_body cimport RigidBody
from cpython.ref cimport Py_DECREF, Py_INCREF


cdef class DiscreteDynamicsWorld:

    def __init__(self, Dispatcher dispatcher,
            BroadphaseInterface pairCache,
            ConstraintSolver constraintSolver, 
            CollisionConfiguration collisionConfiguration):
        self.dispatcher = dispatcher
        self.pairCache = pairCache
        self.constraintSolver = constraintSolver
        self.collisionConfiguration = collisionConfiguration
        self.wrapped = new btDiscreteDynamicsWorld(dispatcher.wrapped,
                pairCache.wrapped, constraintSolver.wrapped,
                collisionConfiguration.wrapped)

    def __dealloc__(self):
        print "dealloc world"
        del self.wrapped

    def setGravity(self, Vector3 vec):
        self.wrapped.setGravity(vec.wrapped[0])

    def addRigidBody(self, RigidBody body, group=None, mask=None):
        if group is not None and mask is not None:
            self.wrapped.addRigidBody(body.wrapped, group, mask)
        else:
            self.wrapped.addRigidBody(body.wrapped)

    def removeRigidBody(self, RigidBody body):
        self.wrapped.removeRigidBody(body.wrapped)

    def stepSimulation(self, btScalar timeStep, maxSubSteps=None, 
            fixedTimeStep=None):
        if maxSubSteps is not None:
            if fixedTimeStep is not None:
                self.wrapped.stepSimulation(timeStep, maxSubSteps,
                        fixedTimeStep)
            else:
                self.wrapped.stepSimulation(timeStep, maxSubSteps)
        else:
            self.wrapped.stepSimulation(timeStep)

