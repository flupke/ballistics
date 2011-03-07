from ballistics.dynamics.constraintsolver.typed_constraint cimport TypedConstraint
from ballistics.linearmath.vector3 cimport wrap_vector3


cdef class Point2PointConstraint(TypedConstraint):

    def __init__(self, *args):
        if len(args) == 4:
            rb_a, rb_b, pivot_in_a, pivot_in_b = args
            self.wrapped = <btPoint2PointConstraint*>(
                new btPoint2PointConstraint(rb_a, rb_b, pivot_in_a, pivot_in_b))
        elif len(args) == 2:
            rb_a, rb_b = args
            self.wrapped = <btPoint2PointConstraint*>(
                    new btPoint2PointConstraint(rb_a, rb_b))
        else:
            raise TypeError("the constructor takes either 2 or 4 "
                    "Vector3 objects")

    def updateRHS(self, timeStep):
        self.wrapped.updateRHS(timeStep)

    property pivotA:
        def __get__(self):
            return wrap_vector3(self.wrapped.getPivotInA())

        def __set__(self, Vector3 pivotA):
            self.wrapped.setPivotA(pivotA.wrapped[0])

    property pivotB:
        def __get__(self):
            return wrap_vector3(self.wrapped.getPivotInB())
        
        def __set__(self, Vector3 pivotB):
            self.wrapped.setPivotA(pivotB.wrapped[0])

    def getParam(self, num, axis=-1):
        """
        Return the local value of parameter 
        """
        return self.wrapped.getParam(num, axis)

    def setParam(self, num, value, axis=-1):
        """
        Override the default global value of a parameter (such as ERP or CFM),
        optionally provide the axis (0..5). 
        """
        self.wrapped.setParam(num, value, axis)

