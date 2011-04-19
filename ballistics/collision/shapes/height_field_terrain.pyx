from ballistics.collision.shapes.base cimport btCollisionShape
from ballistics.linearmath.vector3 cimport Vector3
from ballistics.linearmath.transform cimport Transform
cimport numpy as np
import numpy as np


cdef class HeightfieldTerrainShape(CollisionShape):

    def __init__(self, heightfieldData, btScalar heightScale,
            btScalar minHeight, btScalar maxHeight, int upAxis, 
            int flipQuadEdges):
        cdef np.ndarray data = heightfieldData
        cdef PHY_ScalarType data_type
        if data.dtype == np.float32:
            data_type = PHY_FLOAT
        elif data.dtype == np.float64:
            data_type = PHY_DOUBLE
        else:
            raise TypeError("only float32 and float64 arrays are supported")
        heightStickWidth = data.shape[1]
        heightStickLength = data.shape[0]
        self.wrapped = <btCollisionShape*>(new btHeightfieldTerrainShape(
            heightStickWidth, heightStickLength, data.data, heightScale,
            minHeight, maxHeight, upAxis, data_type, flipQuadEdges))

    def setUseDiamondSubdivision(self, useDiamondSubdivision=True):
        (<btHeightfieldTerrainShape*>self.wrapped).setUseDiamondSubdivision(
            useDiamondSubdivision)

    def getAabb(self):
        """
        getAabb returns the axis aligned bounding box in the coordinate frame
        of the given transform t. 
        """
        aabbMin = Vector3()
        aabbMax = Vector3()
        t = Transform()
        (<btHeightfieldTerrainShape*>self.wrapped).getAabb(t.wrapped[0],
                aabbMin.wrapped[0], aabbMax.wrapped[0])
        return t, aabbMin, aabbMax

    def setLocalScaling(self, Vector3 scaling):
        (<btHeightfieldTerrainShape*>self.wrapped).setLocalScaling(
                scaling.wrapped[0])

    def getLocalScaling(self):
        ret = Vector3()
        ret.wrapped[0] = (<btHeightfieldTerrainShape*>self.wrapped).getLocalScaling()
        return ret
