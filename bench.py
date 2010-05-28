"""
Test custom Python MotionState.
"""
import sys
from ballistics import shortcuts
from ballistics.linearmath.motion_state import BallisticsMotionState
import time
from cProfile import Profile, run
from pstats import Stats
from pyprof2calltree import visualize


def do(num_iter):
    for i in xrange(num_iter):
        world.stepSimulation(1.0 / 60.0, 10)


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
end_time = time.time()

#do(num_iter)

#run("do(num_iter)", "bench.prof")
#print profiler.getstats()
#visualize(profiler.getstats()[0])
#time.sleep(1)
#visualize("bench.prof")

total_time = end_time - start_time
print "total time: %s" % total_time
print "it/s: %s" % (num_iter / total_time)
print "it/frame: %s" % (num_iter / total_time / 60.0)

