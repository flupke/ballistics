cdef class CollisionDispatcher(Dispatcher):

    def __init__(self, CollisionConfiguration config):
        self.wrapped = <btDispatcher*>(new
                btCollisionDispatcher(config.wrapped))
