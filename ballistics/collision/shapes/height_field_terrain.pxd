from ballistics.linearmath.common cimport btScalar
from ballistics.linearmath.transform cimport btTransform
from ballistics.linearmath.vector3 cimport btVector3
from ballistics.collision.shapes.base cimport CollisionShape


cdef extern from "BulletCollision/CollisionShapes/btHeightfieldTerrainShape.h":

    ctypedef enum PHY_ScalarType:
        PHY_FLOAT
        PHY_DOUBLE
        PHY_INTEGER
        PHY_SHORT
        PHY_FIXEDPOINT88
        PHY_UCHAR

    cdef cppclass btHeightfieldTerrainShape:
        btHeightfieldTerrainShape(int heightStickWidth, int heightStickLength,
                void *heightfieldData, btScalar heightScale, btScalar minHeight,
                btScalar maxHeight, int upAxis, PHY_ScalarType heightDataType, 
                int flipQuadEdges)
        void setUseDiamondSubdivision(int useDiamondSubdivision)
        void getAabb(btTransform &t, btVector3 &aabbMin, btVector3 &aabbMax)
        void calculateLocalInertia(btScalar mass, btVector3 &inertia)
        void setLocalScaling(btVector3 &scaling)
        btVector3& getLocalScaling()
        #void processAllTriangles(btTriangleCallback *callback, btVector3 &aabbMin, btVector3 &aabbMax)
        #"""
        #process all triangles within the provided axis-aligned bounding box 
        #"""


cdef class HeightfieldTerrainShape(CollisionShape):

    pass
