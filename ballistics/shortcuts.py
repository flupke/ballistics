"""
Shortcuts for common tasks.
"""

import math
from ballistics.linearmath import Vector3, Transform, Quaternion
from ballistics.linearmath.motion_state import DefaultMotionState
from ballistics.collision.broadphase import DbvtBroadphase
from ballistics.collision.dispatch import DefaultCollisionConfiguration, \
        CollisionDispatcher
from ballistics.collision.shapes import StaticPlaneShape, SphereShape, \
        BoxShape, CapsuleShape, CapsuleShapeX, CapsuleShapeZ
from ballistics.dynamics.world import DiscreteDynamicsWorld
from ballistics.dynamics.constraintsolver import SequentialImpulseConstraintSolver
from ballistics.dynamics.rigid_body import RigidBody, RigidBodyConstructionInfo


def discrete_world(gravity=(0, -9.8, 0)):
    """
    Create a :class:`DiscreteDynamicsWorld` instance with default
    configuration.
    """
    if not isinstance(gravity, Vector3):
        gravity = Vector3(*gravity)
    broadphase = DbvtBroadphase()
    collision_config = DefaultCollisionConfiguration()
    dispatcher = CollisionDispatcher(collision_config)
    solver = SequentialImpulseConstraintSolver()
    world = DiscreteDynamicsWorld(dispatcher, broadphase, solver,
            collision_config)
    world.setGravity(gravity)
    return world


def static_plane(normal=(0, 1, 0), dist=0, rotation=Quaternion(0, 0, 0, 1)):
    """
    Create a :class:`StaticPlaneShape` :class:`RigidBody`.
    """
    if not isinstance(normal, Vector3):
        normal = Vector3(*normal)
    shape = StaticPlaneShape(normal, dist)
    motion_state = DefaultMotionState(Transform(rotation, Vector3(0, 0, 0)))
    rigid_body_ci = RigidBodyConstructionInfo(0, motion_state,
            shape, Vector3(0, 0, 0))
    rigid_body = RigidBody(rigid_body_ci)
    return rigid_body


def rigid_sphere(center=(0, 0, 0), radius=1, mass=None, 
        rotation=Quaternion(0, 0, 0, 1), motion_state=None):
    """
    Create a :class:`SphereShape` :class:`RigidBody`.
    """
    if not isinstance(center, Vector3):
        center = Vector3(*center)
    if mass is None:
        mass = 4.0 / 3.0 * math.pi * (radius ** 3)
    shape = SphereShape(radius)
    if motion_state is None:
        motion_state = DefaultMotionState(Transform(rotation, center))
    inertia = shape.calculateLocalInertia(mass)
    rigid_body_ci = RigidBodyConstructionInfo(mass, motion_state, shape,
            inertia)
    rigid_body = RigidBody(rigid_body_ci)
    return rigid_body


def rigid_box(center=(0, 0, 0), radius=1, mass=None, 
        rotation=Quaternion(0, 0, 0, 1), motion_state=None):
    """
    Create a :class:`BoxShape` :class:`RigidBody`.
    """
    if not isinstance(center, Vector3):
        center = Vector3(*center)
    if mass is None:
        mass = radius ** 3
    shape = BoxShape(Vector3(radius, radius, radius))
    if motion_state is None:
        motion_state = DefaultMotionState(Transform(rotation, center))
    inertia = shape.calculateLocalInertia(mass)
    rigid_body_ci = RigidBodyConstructionInfo(mass, motion_state, shape,
            inertia)
    rigid_body = RigidBody(rigid_body_ci)
    return rigid_body


_capsule_orientations = {
    "x": CapsuleShapeX,
    "y": CapsuleShape,
    "z": CapsuleShapeZ,
}

_capsule_axises = {
    "x": Vector3(1, 0, 0),
    "y": Vector3(0, 1, 0),
    "z": Vector3(0, 0, 1),
}

def rigid_capsule(base=(0, 0, 0), radius=1, height=1, orientation="x",
        mass=None, rotation=Quaternion(0, 0, 0, 1), motion_state=None):
    if not isinstance(base, Vector3):
        base = Vector3(*base)
    base_value = radius + height / 2.0
    tmp = _capsule_axises[orientation].copy()
    tmp *= Vector3(base_value, base_value, base_value)
    base += tmp
    if mass is None:
        mass = 4.0 / 3.0 * math.pi * (radius ** 3)
        mass += math.pi * (radius ** 2) * height
    cls = _capsule_orientations[orientation]
    shape = cls(radius, height)
    if motion_state is None:
        motion_state = DefaultMotionState(Transform(rotation, base))
    inertia = shape.calculateLocalInertia(mass)
    rigid_body_ci = RigidBodyConstructionInfo(mass, motion_state, shape,
            inertia)
    rigid_body = RigidBody(rigid_body_ci)
    return rigid_body
