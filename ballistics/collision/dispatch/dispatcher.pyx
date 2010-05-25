from ballistics.collision.dispatch.config cimport CollisionConfiguration


cdef class CollisionDispatcher(Dispatcher):

    def __init__(self, CollisionConfiguration config):
        self.config = config
        self.wrapped = <btDispatcher*>(new
                btCollisionDispatcher(config.wrapped))
