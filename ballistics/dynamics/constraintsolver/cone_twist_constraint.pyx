from ballistics.dynamics.constraintsolver.typed_constraint cimport TypedConstraint
from ballistics.dynamics.rigid_body cimport RigidBody
from ballistics.dynamics.constraintsolver.typed_constraint cimport \
        btTypedConstraint
from ballistics.linearmath.transform cimport Transform, wrap_transform
from ballistics.linearmath.vector3 cimport wrap_vector3, Vector3
from ballistics.linearmath.quaternion cimport Quaternion


cdef class ConeTwistConstraint(TypedConstraint):
    """
    btConeTwistConstraint wrapper.

    Constructors:
        ConeTwistConstraint(RigidBody rbA, RigidBody rbB, 
                Transform rbAFrame, Transform rbBFrame)
        ConeTwistConstraint(RigidBody rbA, Transform rbAFrame)
    """

    def __init__(self, *args):
        cdef RigidBody rbA, rbB
        cdef Transform rbAFrame, rbBFrame
        self.wrapped = NULL
        if len(args) == 4:
            rbA, rbB, rbAFrame, rbBFrame = args
            self.wrapped = <btTypedConstraint*> new btConeTwistConstraint(
                    rbA.wrapped[0], rbB.wrapped[0], 
                    rbAFrame.wrapped[0], rbBFrame.wrapped[0])
        elif len(args) == 2:
            rbA, rbAFrame = args
            self.wrapped = <btTypedConstraint*> new btConeTwistConstraint(
                    rbA.wrapped[0], rbAFrame.wrapped[0])
        else:
            raise TypeError("constructor takes either 2 or 4 arguments")

    def updateRHS(self, timeStep):
        (<btConeTwistConstraint*>self.wrapped).updateRHS(timeStep)

    # Need to figure out a sane way to implement wrap_rigid_body

    #def getRigidBodyA(self):
    #    return wrap_rigid_body(
    #            (<btConeTwistConstraint*>self.wrapped).getRigidBodyA())

    #def getRigidBodyB(self):
    #    return wrap_rigid_body(
    #            (<btConeTwistConstraint*>self.wrapped).getRigidBodyB())

    def setAngularOnly(self, angularOnly):
        (<btConeTwistConstraint*>self.wrapped).setAngularOnly(angularOnly)

    def setLimit(self, *args, softness=1.0, biasFactor=0.3,
            relaxationFactor=1.0):
        """
        setLimit(self, limitIndex, limitValue):
        setLimit(self, swingSpan1, swingSpan2, twistSpan, softness=1.0,
                biasFactor=0.3, relaxationFactor=1.0)
        """
        if len(args) == 2:
            limitIndex, limitValue = args
            (<btConeTwistConstraint*>self.wrapped).setLimit(limitIndex, limitValue)
        elif len(args) == 3:
            swingSpan1, swingSpan2, twistSpan = args
            (<btConeTwistConstraint*>self.wrapped).setLimit(swingSpan1,
                    swingSpan2, twistSpan, softness, biasFactor,
                    relaxationFactor)

    def getAFrame(self):
        return wrap_transform(
                (<btConeTwistConstraint*>self.wrapped).getAFrame())

    def getBFrame(self):
        return wrap_transform(
                (<btConeTwistConstraint*>self.wrapped).getBFrame())

    def getSolveTwistLimit(self):
        return (<btConeTwistConstraint*>self.wrapped).getSolveTwistLimit()

    def getSolveSwingLimit(self):
        return (<btConeTwistConstraint*>self.wrapped).getSolveSwingLimit()

    def getTwistLimitSign(self):
        return (<btConeTwistConstraint*>self.wrapped).getTwistLimitSign()

    def getSwingSpan1(self):
        return (<btConeTwistConstraint*>self.wrapped).getSwingSpan1()

    def getSwingSpan2(self):
        return (<btConeTwistConstraint*>self.wrapped).getSwingSpan2()

    def getTwistSpan(self):
        return (<btConeTwistConstraint*>self.wrapped).getTwistSpan()

    def getTwistAngle(self):
        return (<btConeTwistConstraint*>self.wrapped).getTwistAngle()

    def isPastSwingLimit(self):
        return (<btConeTwistConstraint*>self.wrapped).isPastSwingLimit()

    def setDamping(self, damping):
        (<btConeTwistConstraint*>self.wrapped).setDamping(damping)

    def enableMotor(self, b):
        (<btConeTwistConstraint*>self.wrapped).enableMotor(b)

    def setMaxMotorImpulse(self, maxMotorImpulse):
        (<btConeTwistConstraint*>self.wrapped).setMaxMotorImpulse(
                maxMotorImpulse)

    def setMaxMotorImpulseNormalized(self, maxMotorImpulse):
        (<btConeTwistConstraint*>self.wrapped).setMaxMotorImpulseNormalized(
                maxMotorImpulse)

    def getFixThresh(self):
        return (<btConeTwistConstraint*>self.wrapped).getFixThresh()

    def setFixThresh(self, fixThresh):
        (<btConeTwistConstraint*>self.wrapped).setFixThresh(fixThresh)

    def setMotorTarget(self, Quaternion q):
        (<btConeTwistConstraint*>self.wrapped).setMotorTarget(q.wrapped[0])

    def setMotorTargetInConstraintSpace(self, Quaternion q):
        (<btConeTwistConstraint*>self.wrapped) \
                .setMotorTargetInConstraintSpace(q.wrapped[0])

    def GetPointForAngle(self, fAngleInRadians, fLength):
        return wrap_vector3((<btConeTwistConstraint*>self.wrapped)
                .GetPointForAngle(fAngleInRadians, fLength))

    def setParam(self, num, value, axis=-1):
        """
        override the default global value of a parameter(such as ERP or CFM):,
        optionally provide the axis(0..5):. 
        """
        (<btConeTwistConstraint*>self.wrapped).setParam(num, value, axis)

    def getParam(self, num, axis=-1):
        """
        return the local value of parameter 
        """
        return (<btConeTwistConstraint*>self.wrapped).getParam(num, axis)
