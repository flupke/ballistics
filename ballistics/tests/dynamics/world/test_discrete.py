from ballistics.linearmath import Vector3
from ballistics.dynamics.world import DiscreteDynamicsWorld
from ballistics.dynamics.constraintsolver import SequentialImpulseConstraintSolver
from ballistics.collision.broadphase import DbvtBroadphase
from ballistics.collision.dispatch import DefaultCollisionConfiguration, \
        CollisionDispatcher


def test_hello_world():
    """
    Reproduce the hello world example from the tutorial.
    """
    broadphase = DbvtBroadphase()
    collision_config = DefaultCollisionConfiguration()
    dispatcher = CollisionDispatcher(collision_config)
    solver = SequentialImpulseConstraintSolver()
    world = DiscreteDynamicsWorld(dispatcher, broadphase, solver,
            collision_config)
    world.setGravity(Vector3(0, -9.8, 0))
