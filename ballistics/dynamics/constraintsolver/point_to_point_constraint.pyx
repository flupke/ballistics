from ballistics.dynamics.constraintsolver.typed_constraint cimport TypedConstraint
from ballistics.dynamics.rigid_body cimport RigidBody
from ballistics.dynamics.constraintsolver.typed_constraint cimport \
        btTypedConstraint
from ballistics.linearmath.vector3 cimport wrap_vector3, Vector3


cdef class Point2PointConstraint(TypedConstraint):
    """
    btPoint2PointConstraint wrapper.

    Constructors:
        Point2PointConstraint(RigidBody rbA, RigidBody rbB, 
                Vector3 pivotInA, Vector3 pivotInB)
        Point2PointConstraint(RigidBody rbA, Vector3 pivotInA)
    """

    def __init__(self, *args):
        cdef RigidBody rb_a, rb_b
        cdef Vector3 pivot_in_a, pivot_in_b
        self.wrapped = NULL
        if len(args) == 4:
            rb_a, rb_b, pivot_in_a, pivot_in_b = args
            self.wrapped = <btTypedConstraint*>(
                new btPoint2PointConstraint(rb_a.wrapped[0], rb_b.wrapped[0],
                    pivot_in_a.wrapped[0], pivot_in_b.wrapped[0]))
        elif len(args) == 2:
            rb_a, pivot_in_a = args
            self.wrapped = <btTypedConstraint*>(
                    new btPoint2PointConstraint(rb_a.wrapped[0],
                        pivot_in_a.wrapped[0]))
        else:
            raise TypeError("the constructor takes either 2 or 4 "
                    "arguments")

    def updateRHS(self, timeStep):
        (<btPoint2PointConstraint*>self.wrapped).updateRHS(timeStep)

    property pivotA:
        def __get__(self):
            return wrap_vector3(
                    (<btPoint2PointConstraint*>self.wrapped).getPivotInA())

        def __set__(self, Vector3 pivotA):
            (<btPoint2PointConstraint*>self.wrapped).setPivotA(pivotA.wrapped[0])

    property pivotB:
        def __get__(self):
            return wrap_vector3(
                    (<btPoint2PointConstraint*>self.wrapped).getPivotInB())
        
        def __set__(self, Vector3 pivotB):
            (<btPoint2PointConstraint*>self.wrapped).setPivotA(pivotB.wrapped[0])

    def getParam(self, num, axis=-1):
        """
        Return the local value of parameter 
        """
        return (<btPoint2PointConstraint*>self.wrapped).getParam(num, axis)

    def setParam(self, num, value, axis=-1):
        """
        Override the default global value of a parameter (such as ERP or CFM),
        optionally provide the axis (0..5). 
        """
        (<btPoint2PointConstraint*>self.wrapped).setParam(num, value, axis)

