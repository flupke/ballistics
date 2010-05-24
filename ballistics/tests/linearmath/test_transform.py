from nose.tools import assert_equal, assert_almost_equal
import math
import numpy as np
from ballistics.linearmath import Vector3, Quaternion, Matrix3x3, Transform
from ballistics.linearmath.transform import identity as transform_identity
from ballistics.linearmath.matrix3x3 import identity as matrix3x3_identity


def test_create():
    vec = Vector3(1, 2, 3)
    quat = Quaternion(0, 0, 0, 1)
    mat = matrix3x3_identity()
    trans = Transform()
    trans = Transform(quat)
    assert_equal(trans.rotation, quat)
    trans = Transform(mat)
    assert_equal(trans.basis, mat)
    trans = Transform(quat, vec)
    assert_equal(trans.rotation, quat)
    assert_equal(trans.origin, vec)
    trans = Transform(mat, vec)
    assert_equal(trans.basis, mat)
    assert_equal(trans.origin, vec)    
    trans_copy = Transform(trans)
    assert_equal(trans, trans_copy)


def test_get_set():
    trans_idt = transform_identity()
    # openGLMatrix property
    ref_basis = Matrix3x3(
                1, 2, 3,
                4, 5, 6, 
                7, 8, 9)
    ref_origin = Vector3(1, 2, 3)
    ref_trans = Transform(ref_basis, ref_origin)
    np_mat = np.array((
            1, 4, 7, 0, 
            2, 5, 8, 0,
            3, 6, 9, 0,
            0, 0, 0, 1))
    trans = Transform()
    trans.openGLMatrix = np_mat
    assert (trans.getOpenGLMatrix() == np_mat).all()
    assert (ref_trans.openGLMatrix == np.array((
            1, 4, 7, 0,
            2, 5, 8, 0,
            3, 6, 9, 0, 
            1, 2, 3, 1))).all()
    # origin/basis properties
    trans = Transform()
    trans.origin = ref_origin
    trans.basis = ref_basis
    assert_equal(trans, ref_trans)
    trans = Transform()
    trans.setOrigin(ref_origin)
    trans.setBasis(ref_basis)
    assert_equal(trans.getOrigin(), ref_origin)
    assert_equal(trans.getBasis(), ref_basis)
    # rotation property
    trans = Transform()
    rot = Quaternion()
    rot.setRotation(Vector3(0, 1, 0), math.pi / 2)
    trans.rotation = rot
    trans.origin = ref_origin
    ref_rot_trans = Transform(Matrix3x3(
            0, 0, 1,
            0, 1, 0,
            -1, 0, 0), ref_origin)
    assert_equal(trans, ref_rot_trans)
    # setIdentity()
    trans = Transform()
    trans.setIdentity()
    assert_equal(trans.basis, matrix3x3_identity())
    assert_equal(trans.origin, Vector3(0, 0, 0))
    # mult()
    trans = Transform()
    trans.mult(trans_idt, trans_idt)
    assert_equal(trans, trans_idt)



def test_methods():
    trans_idt = transform_identity()
    base = transform_identity()
    vec = Vector3(1, 2, 3)
    meths_specs = {
            "inverse": ([], trans_idt),
            "inverseTimes": ([trans_idt], trans_idt),
            "invXform": ([vec], vec),
        }
    for name, (args, expected_ret) in meths_specs.items():
        v = base.copy()
        ret = getattr(v, name)(*args)
        assert_equal(ret, expected_ret, "%s(): %r != %r" % 
                (name, ret, expected_ret))
    # Operators
    trans1 = transform_identity()
    half_pi = math.pi / 2
    rot = Quaternion()
    rot.setRotation(Vector3(0, 1, 0), math.pi / 2)
    trans2 = Transform()
    trans2.rotation = rot
    trans2.origin = Vector3(1, 0, 0)
    vec = Vector3(1, 0, 0)
    assert_equal(trans2(vec), Vector3(1, 0, -1))
    assert_equal(trans2 * vec, Vector3(1, 0, -1))
    rot2 = trans2 * rot
    assert_almost_equal(rot2.getAngle(), math.pi, places=5)
    comp_trans_ref = Transform(Matrix3x3(-1, 0, 0,  0, 1, 0,  0, 0, -1),
            Vector3(1, 0, -1))
    assert_equal(trans2 * trans2, comp_trans_ref)
    trans2 *= trans2
    assert_equal(trans2, comp_trans_ref)
