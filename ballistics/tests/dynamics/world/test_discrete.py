from nose.tools import assert_almost_equal
from ballistics.linearmath import Vector3, Transform, Quaternion
from ballistics.linearmath.motion_state import DefaultMotionState, \
        BallisticsMotionState 
from ballistics.collision.broadphase import DbvtBroadphase
from ballistics.collision.dispatch import DefaultCollisionConfiguration, \
        CollisionDispatcher
from ballistics.collision.shapes import StaticPlaneShape, SphereShape, BoxShape
from ballistics.dynamics.world import DiscreteDynamicsWorld
from ballistics.dynamics.constraintsolver import SequentialImpulseConstraintSolver
from ballistics.dynamics.rigid_body import RigidBody, RigidBodyConstructionInfo
from ballistics import shortcuts


def test_hello_world():
    """
    Port of the hello world example from the tutorial.
    """
    # Setup world
    broadphase = DbvtBroadphase()
    collision_config = DefaultCollisionConfiguration()
    dispatcher = CollisionDispatcher(collision_config)
    solver = SequentialImpulseConstraintSolver()
    world = DiscreteDynamicsWorld(dispatcher, broadphase, solver,
            collision_config)
    world.setGravity(Vector3(0, -9.8, 0))
    # Create collision shapes
    ground_shape = StaticPlaneShape(Vector3(0, 1, 0), 1)
    ball_shape = SphereShape(1)
    # Create ground rigid body
    ground_motion_state = DefaultMotionState(
            Transform(Quaternion(0, 0, 0, 1), Vector3(0, -1, 0)))
    ground_rigid_body_ci = RigidBodyConstructionInfo(0, ground_motion_state,
            ground_shape, Vector3(0, 0, 0))
    ground_rigid_body = RigidBody(ground_rigid_body_ci)
    world.addRigidBody(ground_rigid_body)
    # Create ball rigid body
    ball_motion_state = DefaultMotionState(
            Transform(Quaternion(0, 0, 0, 1), Vector3(0, 50, 0)))
    mass = 1
    ball_inertia = ball_shape.calculateLocalInertia(mass)
    ball_rigid_body_ci = RigidBodyConstructionInfo(mass, ball_motion_state,
            ball_shape, ball_inertia)
    ball_rigid_body = RigidBody(ball_rigid_body_ci)
    world.addRigidBody(ball_rigid_body)
    # Simulate 300 frames, should be enough for the sphere to reach rest state
    for i in range(300):
        world.stepSimulation(1.0 / 60.0, 10)
        #trans = ball_rigid_body.motionState.worldTransform
        #print trans.origin.y
    # Verify ball position
    trans = ball_motion_state.worldTransform
    assert_almost_equal(trans.origin.y, 1.0, places=5)
    trans = ball_rigid_body.motionState.worldTransform
    assert_almost_equal(trans.origin.y, 1.0, places=5)


def default_scene():
    # Setup world
    world = shortcuts.discrete_world((0, -9.8, 0))
    # Create rigid bodies
    ball_rigid_body = shortcuts.rigid_sphere((0, 50, 0), 1, mass=1)
    world.addRigidBody(ball_rigid_body)
    ground_rigid_body = shortcuts.static_plane((0, 1, 0), 0)
    world.addRigidBody(ground_rigid_body)
    return world, ball_rigid_body


def test_shortcuts_hello_world():
    """
    Same as test_hello_world(), using Python shortcuts.
    """
    # Setup world
    world, ball_rigid_body = default_scene()
    # Simulate 300 frames, should be enough for the sphere to reach rest state
    for i in range(300):
        world.stepSimulation(1.0 / 60.0, 10)
    # Verify ball position
    trans = ball_rigid_body.motionState.worldTransform
    assert_almost_equal(trans.origin.y, 1.0, places=5)  


def test_all_shapes():
    world = shortcuts.discrete_world()
    ground = shortcuts.static_plane()
    shapes = [
            SphereShape(1),
            BoxShape(Vector3(1, 1, 1)),
        ]
    for i, shape in enumerate(shapes):
        motion_state = DefaultMotionState(Transform(Quaternion(0, 0, 0, 1),
            Vector3(i * 10, 50, 0)))
        mass = 1
        inertia = shape.calculateLocalInertia(mass)
        body_ci = RigidBodyConstructionInfo(mass, motion_state, shape, inertia)
        body = RigidBody(body_ci)
        world.addRigidBody(body)
    for i in range(300):
        world.stepSimulation(1.0 / 60.0, 10)


def test_custom_motion_state():
    """
    Test custom Python MotionState.
    """
    class MyMotionState(BallisticsMotionState):
        
        def update_transform(self, trans):
            self.trans = trans

    world, ball = default_scene()
    motion_state = MyMotionState()
    ball.motionState = motion_state
    for i in range(300):
        world.stepSimulation(1.0 / 60.0, 10)
    assert_almost_equal(motion_state.trans.origin.y, 1.0, places=5)
