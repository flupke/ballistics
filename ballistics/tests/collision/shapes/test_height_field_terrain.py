import numpy as np
from ballistics.collision.shapes.height_field_terrain import \
        HeightfieldTerrainShape


def _create(dtype):
    data = np.empty((16, 16), dtype=dtype)
    for j in range(16):
        for i in range(16):
            data[j, i] = i * j
    shape = HeightfieldTerrainShape(data, 1, 0, 256, 1, False)
    return shape


def test_create():
    shape = _create(np.float32)
    _create(np.float64)
