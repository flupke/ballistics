cdef extern from "LinearMath/btIDebugDraw.h":

    cdef cppclass btIDebugDraw:
        pass


cdef extern from "gl_debug_draw.h":

    cdef cppclass glDebugDraw:
        pass
