from ballistics.dynamics.constraintsolver.typed_constraint cimport TypedConstraint
from ballistics.dynamics.rigid_body cimport RigidBody
from ballistics.dynamics.constraintsolver.typed_constraint cimport \
        btTypedConstraint
from ballistics.linearmath.transform cimport Transform, wrap_transform
from ballistics.linearmath.vector3 cimport wrap_vector3, Vector3


cdef class Generic6DofConstraint(TypedConstraint):
    """
    btGeneric6DofConstraint wrapper.

    Constructors:
        Generic6DofConstraint(RigidBody rbA, RigidBody rbB,
            Transform frameInA, Transform frameInB, 
            bool useLinearReferenceFrameA)
        Generic6DofConstraint(RigidBody bB, Transform frameInB,
            bool useLinearReferenceFrameB)
    """

    def __init__(self, *args):
        cdef RigidBody rbA, rbB
        cdef Transform frameInA, frameInB
        self.wrapped = NULL
        if len(args) == 5:
            rbA, rbB, frameInA, frameInB, useLinearReferenceFrameA = args
            self.wrapped = <btTypedConstraint*> new btGeneric6DofConstraint(
                    rbA.wrapped[0], rbB.wrapped[0], frameInA.wrapped[0],
                    frameInB.wrapped[0], useLinearReferenceFrameA)
        elif len(args) == 3:
            rbB, frameInB, useLinearReferenceFrameB = args
            self.wrapped = <btTypedConstraint*> new btGeneric6DofConstraint(
                    rbB.wrapped[0], frameInB.wrapped[0], 
                    useLinearReferenceFrameB)
        else:
            raise TypeError("the constructor takes either 3 or 5 arguments")

    def calculateTransforms(self, *args):
        """
        Calcs global transform of the offsets. 
        """
        cdef Transform transA, transB
        if len(args) == 2:
            transA, transB = args
            (<btGeneric6DofConstraint*>self.wrapped).calculateTransforms(
                    transA.wrapped[0], transB.wrapped[0])
        elif len(args) == 0:
            (<btGeneric6DofConstraint*>self.wrapped).calculateTransforms()
        else:
            raise TypeError("this method takes either 2 or 0 arguments")

    def getCalculatedTransformA(self):
        """
        Gets the global transform of the offset for body A. 
        """
        return wrap_transform((<btGeneric6DofConstraint*>self.wrapped)
                .getCalculatedTransformA())

    def getCalculatedTransformB(self):
        """
        Gets the global transform of the offset for body B. 
        """
        return wrap_transform((<btGeneric6DofConstraint*>self.wrapped)
                .getCalculatedTransformB())

    def getFrameOffsetA(self):
        return wrap_transform((<btGeneric6DofConstraint*>self.wrapped)
                .getFrameOffsetA())

    def getFrameOffsetB(self):
        return wrap_transform((<btGeneric6DofConstraint*>self.wrapped)
                .getFrameOffsetB())

    def buildJacobian(self):
        """
        performs Jacobian calculation, and also calculates angle differences and axis 
        """
        (<btGeneric6DofConstraint*>self.wrapped).buildJacobian()

    def updateRHS(self, timeStep):
        (<btGeneric6DofConstraint*>self.wrapped).updateRHS(timeStep)

    def getAxis(self, axis_index):
        """
        Get the rotation axis in global coordinates. 
        """
        return wrap_vector3((<btGeneric6DofConstraint*>self.wrapped)
                .getAxis(axis_index))

    def getAngle(self, axis_index):
        """
        Get the relative Euler angle. 
        """
        return (<btGeneric6DofConstraint*>self.wrapped).getAngle(axis_index)

    def getRelativePivotPosition(self, axis_index):
        """
        Get the relative position of theraint pivot. 
        """
        return (<btGeneric6DofConstraint*>self.wrapped) \
                .getRelativePivotPosition(axis_index)

    def testAngularLimitMotor(self, axis_index):
        """
        Test angular limit. 
        """
        return (<btGeneric6DofConstraint*>self.wrapped) \
                .testAngularLimitMotor(axis_index)

    def setLinearLowerLimit(self, Vector3 linearLower):
        (<btGeneric6DofConstraint*>self.wrapped) \
                .setLinearLowerLimit(linearLower.wrapped[0])

    def setLinearUpperLimit(self, Vector3 linearUpper):
        (<btGeneric6DofConstraint*>self.wrapped) \
                .setLinearUpperLimit(linearUpper.wrapped[0])

    def setAngularLowerLimit(self, Vector3 angularLower):
        (<btGeneric6DofConstraint*>self.wrapped) \
                .setLinearLowerLimit(angularLower.wrapped[0])

    def setAngularUpperLimit(self, Vector3 angularUpper):
        (<btGeneric6DofConstraint*>self.wrapped) \
                .setAngularUpperLimit(angularUpper.wrapped[0])

    #def getRotationalLimitMotor(self, index):
    #   """
    #   Retrieves the angular limit informacion. 
    #   """

    #def getTranslationalLimitMotor(self):
    #   """
    #   Retrieves the limit informacion. 
    #   """

    def setLimit(self, axis, lo, hi):
        (<btGeneric6DofConstraint*>self.wrapped).setLimit(axis, lo, hi)

    def isLimited(self, limitIndex):
        """
        Test limit. 
        """
        return (<btGeneric6DofConstraint*>self.wrapped).isLimited(limitIndex)

    def calcAnchorPos(self):
        (<btGeneric6DofConstraint*>self.wrapped).calcAnchorPos()

    def getUseFrameOffset(self):
        return (<btGeneric6DofConstraint*>self.wrapped).getUseFrameOffset()

    def setUseFrameOffset(self, frameOffsetOnOff):
        (<btGeneric6DofConstraint*>self.wrapped).setUseFrameOffset(
                frameOffsetOnOff)

    def setParam(self, num, value, axis=-1):
        """
        Override the default global value of a parameter(such as ERP or CFM),
        optionally provide the axis(0..5). 
        """
        (<btGeneric6DofConstraint*>self.wrapped).setParam(num, value, axis)

    def getParam(self, num, axis=-1):
        """
        Return the local value of parameter.
        """
        return (<btGeneric6DofConstraint*>self.wrapped).getParam(num, axis)
