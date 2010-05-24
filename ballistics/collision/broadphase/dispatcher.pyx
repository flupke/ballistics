
cdef class Dispatcher:
    
    def __init__(self):
        raise TypeError("can't instantiate abstract base class "
                "Dispatcher")

    def __dealloc__(self):
        del self.wrapped
