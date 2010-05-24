from nose.tools import assert_equal, assert_almost_equal
import math
import numpy as np
from ballistics.linearmath import Quaternion, Vector3, Matrix3x3, identity


def test_create():
    mat = Matrix3x3(1, 2, 3, 4, 5, 6, 7, 8, 9)
    mat = Matrix3x3(Quaternion(1, 2, 3, 4))
    mat = Matrix3x3(mat)
    id_mat = identity()
    mat = Matrix3x3()
    mat.setIdentity()
    assert_equal(mat, id_mat)
    

def test_get_set():
    # Basic get/set
    mat = Matrix3x3(1, 2, 3, 4, 5, 6, 7, 8, 9)
    assert_equal([mat.getColumn(i) for i in range(3)], [Vector3(1, 4, 7),
        Vector3(2, 5, 8), Vector3(3, 6, 9)])
    assert_equal([mat.getRow(i) for i in range(3)], [Vector3(1, 2, 3),
        Vector3(4, 5, 6), Vector3(7, 8, 9)])
    assert_equal([mat[i] for i in range(3)], [Vector3(1, 2, 3),
        Vector3(4, 5, 6), Vector3(7, 8, 9)])
    mat2 = Matrix3x3()
    np_mat = np.array((
            1, 4, 7, 0, 
            2, 5, 8, 0,
            3, 6, 9, 0))
    mat2.setFromOpenGLSubMatrix(np_mat)
    assert_equal(mat, mat2)
    assert (mat.getOpenGLSubMatrix() == np_mat).all()
    mat2.setValue(1, 2, 3, 4, 5, 6, 7, 8, 9)
    assert_equal(mat, mat2)
    # Rotations
    # quaternion
    qpi = math.pi / 4
    rot_quat = Quaternion()
    rot_quat.setRotation(Vector3(0.25, 0.75, 0.5), qpi)
    mat.setRotation(rot_quat)
    mat_rot_quat = mat.getRotation()
    assert_almost_equal(rot_quat.x, mat_rot_quat.x)
    assert_almost_equal(rot_quat.y, mat_rot_quat.y)
    assert_almost_equal(rot_quat.z, mat_rot_quat.z)
    assert_almost_equal(rot_quat.w, mat_rot_quat.w)
    # Euler
    angles = (0.1, 0.2, 0.3)
    expected_res = (
            [0.1, 0.2, 0.3],
            [0.3, 0.2, 0.1],
        )
    for suffix, expected in zip(("YPR", "ZYX"), expected_res ):
        getattr(mat, "setEuler" + suffix)(*angles)
        res = getattr(mat, "getEuler" + suffix)()
        for i in range(3):
            assert_almost_equal(res[i], expected[i])


def test_methods():
    # Create some data
    idt = identity()
    mat = identity()
    vec = Vector3(1, 2, 3)
    # Test generic methods
    meths_specs = {
            "scaled": ([vec], Matrix3x3(1, 0, 0,  0, 2, 0,  0, 0, 3)),
            "determinant": ([], 1),
            "adjoint": ([], idt),
            "absolute": ([], idt),
            "transpose": ([], idt),
            "inverse": ([], idt),
            "transposeTimes": ([mat], idt),
            "timesTranspose": ([mat], idt),
            "tdotx": ([vec], 1),
            "tdoty": ([vec], 2),
            "tdotz": ([vec], 3),
            "cofac": ([1, 2, 3, 4], 0),
        }
    for name, (args, expected_ret) in meths_specs.items():
        m = mat.copy()
        ret = getattr(m, name)(*args)
        assert_equal(ret, expected_ret, "%s(): %r != %r" % 
                (name, ret, expected_ret))
    # Test diagonalize
    m = mat.copy()
    m.diagonalize(idt, 0, 10)
    assert_equal(m, idt)
    # Test *=
    m = mat.copy()
    m *= idt
    assert_equal(m, idt)
