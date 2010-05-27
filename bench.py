"""
Test custom Python MotionState.
"""
import sys
from ballistics import shortcuts
from ballistics.linearmath.motion_state import BallisticsMotionState
import time


if len(sys.argv) > 1:
    num_iter = int(sys.argv[1])
else:
    num_iter = 30000


class MyMotionState(BallisticsMotionState):
    
    def update_transform(self, trans):
        self.trans = trans


world = shortcuts.discrete_world((0, -9.8, 0))

ball = shortcuts.rigid_sphere((0, 50, 0), 1, mass=1)
motion_state = MyMotionState()
ball.motionState = motion_state
world.addRigidBody(ball)

ground = shortcuts.static_plane((0, 1, 0), 0)
world.addRigidBody(ground)

print "running %d iterations..." % num_iter
start_time = time.time()
for i in range(num_iter):
    world.stepSimulation(1.0 / 60.0, 10)
end_time = time.time()

total_time = end_time - start_time
print "total time: %s" % total_time
print "it/s: %s" % (num_iter / total_time)
print "it/frame: %s" % (num_iter / total_time / 60.0)
