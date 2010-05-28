from nose.tools import assert_equal, assert_almost_equal, assert_raises
import math
from ballistics.linearmath import Quaternion, Vector3


def test_basic():
    # Basic creation and attributes tests
    quat = Quaternion()
    quat = Quaternion(1, 2, 3, 4)
    assert_equal(quat.x, 1)
    assert_equal(quat.y, 2)
    assert_equal(quat.z, 3)
    assert_equal(quat.w, 4)
    quat.x = 4
    quat.y = 5
    quat.z = 6
    quat.w = 7
    assert_equal(quat.x, 4)
    assert_equal(quat.y, 5)
    assert_equal(quat.z, 6)
    assert_equal(quat.w, 7)
    # Fancy constructors
    quat = Quaternion(0, 0, 0)
    assert_equal((quat.x, quat.y, quat.z, quat.w), (0, 0, 0, 1))
    quat = Quaternion(Vector3(0, 1, 0), 0)
    assert_equal((quat.x, quat.y, quat.z, quat.w), (0, 0, 0, 1))
    

def test_methods():
    # Create some vectors
    base = Quaternion(0, 0, 2, 1)
    other = Quaternion(0, 2, 0, 1)
    other2 = Quaternion(2, 0, 0)
    other3 = Quaternion(1, 1, 0)
    # Generic methods tests
    meths_specs = {
            "dot": ([other], 1),
            "length": ([], 2.2360679774997898),
            "length2": ([], 5),
            "normalized": ([], 
                Quaternion(0.0, 0.0, 0.89442718029, 0.447213590145)),
            "normalize": ([], 
                Quaternion(0.0, 0.0, 0.89442718029, 0.447213590145)),
            "getAngle": ([], 0),
            "getAxis": ([], Vector3(1, 0, 0)),
            "inverse": ([], Quaternion(0, 0, -2, 1)),
            "farthest": ([other], Quaternion(0, -2, 0, -1)),
            "nearest": ([other], Quaternion(0, 2, 0, 1)),
            "slerp": ([other, 0.5], 
                Quaternion(0.0, 1.29099440575, 1.29099440575, 1.29099440575)),
            "angle": ([other], 1.3694384098052979),
        }

    for name, (args, expected_ret) in meths_specs.items():
        v = base.copy()
        ret = getattr(v, name)(*args)
        assert_equal(ret, expected_ret, "%s(): %r != %r" % 
                (name, ret, expected_ret))
    # Assignment methods
    assign_meth_specs = {
            "setRotation": ([Vector3(0, 1, 0), 0], Quaternion(0, 0, 0, 1)),
            "setEuler": ([0, 0, 0], Quaternion(0, 0, 0, 1)),
        }
    for name, (args, expected) in assign_meth_specs.items():
        v = base.copy()
        getattr(v, name)(*args)
        assert_equal(v, expected, "%s(): %r != %r" % 
                (name, v, expected))
    # Overloaded operators
    assert_equal(base * 10, Quaternion(0, 0, 20, 10))
    assert_equal(base / 10, Quaternion(0, 0, 0.2, 0.1))
    assert_raises(TypeError, lambda: 10 / base)
    assert_equal(base + other, Quaternion(0, 2, 2, 2))
    assert_equal(base - other, Quaternion(0, -2, 2, 0))
    
