from nose.tools import assert_equal, assert_almost_equal
import math
from ballistics.linearmath import Vector3 #, Quaternion, Matrix3x3, Transform


def test_basic():
    # Basic creation and attributes tests
    vec = Vector3()
    vec = Vector3(1, 2, 3)
    assert_equal(vec.x, 1)
    assert_equal(vec.y, 2)
    assert_equal(vec.z, 3)
    vec.x = 4
    vec.y = 5
    vec.z = 6
    assert_equal(vec.x, 4)
    assert_equal(vec.y, 5)
    assert_equal(vec.z, 6)


def test_methods():
    # Create some vectors
    base = Vector3(0, 0, 2)
    other = Vector3(0, 2, 0)
    other2 = Vector3(2, 0, 0)
    other3 = Vector3(1, 1, 0)
    # Generic methods tests
    meths_specs = {
            "dot": ([other], 0),
            "length": ([], 2),
            "length2": ([], 4),
            "distance": ([other], 2.8284271247461903),
            "distance2": ([other], 8),
            "normalized": ([], Vector3(0, 0, 1)),
            "absolute": ([], base),
            "cross": ([other], Vector3(-4, 0, 0)),
            "triple": ([other, other2], -8.0),
            "minAxis": ([], 1),
            "maxAxis": ([], 2),
            "furthestAxis": ([], 1),
            "closestAxis": ([], 2),
            "lerp": ([other, 0.5], Vector3(0, 1, 1)),
            "isZero": ([], False),
            "fuzzyZero": ([], False),
            "normalize": ([], Vector3(0, 0, 1)),
        }
    for name, (args, expected_ret) in meths_specs.items():
        v = base.copy()
        ret = getattr(v, name)(*args)
        assert_equal(ret, expected_ret, "%s(): %r != %r" % 
                (name, ret, expected_ret))
    # Assignment methods
    assign_meth_specs = {
            "setMax": ([other], Vector3(0, 2, 2)),
            "setMin": ([other], Vector3(0, 0, 0)),
            "setValue": ([1, 2, 3], Vector3(1, 2, 3)),
            "setInterpolate3": ([other, other2, 0.5], Vector3(1, 1, 0)),
            "setZero": ([], Vector3(0, 0, 0)),
        }
    for name, (args, expected) in assign_meth_specs.items():
        v = base.copy()
        getattr(v, name)(*args)
        assert_equal(v, expected, "%s(): %r != %r" % 
                (name, v, expected))
    # Methods that need a special treatment
    # rotate
    v = base.copy()
    ret = v.rotate(Vector3(1, 0, 0), -math.pi / 2.0)
    ret -= other
    assert_equal(ret.fuzzyZero(), True)
    # angle
    assert_almost_equal(base.angle(other), math.pi / 2.0)
    # getSkewSymmetricMatrix
    v1 = Vector3()
    v2 = Vector3()
    v3 = Vector3()
    base.getSkewSymmetricMatrix(v1, v2, v3)
    assert_equal((v1, v2, v3), (Vector3(0, -2, 0), Vector3(2, 0, 0), 
        Vector3(0, 0, 0)))
