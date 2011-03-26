#!/usr/bin/env python

import os
import sys
try:
    from Cython.Distutils import build_ext
    # may need to work around setuptools bug by providing a fake Pyrex
    sys.path.insert(0, os.path.join(os.path.dirname(__file__), "fake_pyrex"))
    ext_ext = ".pyx"
except ImportError:
    from setuptools.command.build_ext import build_ext
    ext_ext = ".cpp"

from setuptools import setup, find_packages
from distutils.extension import Extension


wrapper_modules = [
        # linearmath
        ("ballistics.linearmath.vector3", ["BulletDynamics"]),
        ("ballistics.linearmath.quaternion", ["BulletDynamics"]),
        ("ballistics.linearmath.matrix3x3", ["BulletDynamics"]),
        ("ballistics.linearmath.transform", ["BulletDynamics"]),
        ("ballistics.linearmath.motion_state", ["BulletDynamics"], 
            ["ballistics/linearmath/bstx_motion_state.cpp"]),
        # collision
        ("ballistics.collision.broadphase.dbvt", ["BulletCollision"]),
        ("ballistics.collision.broadphase.dispatcher", ["BulletCollision"]),
        ("ballistics.collision.broadphase.interface", ["BulletCollision"]),
        ("ballistics.collision.dispatch.config", ["BulletCollision"]),
        ("ballistics.collision.dispatch.dispatcher", ["BulletCollision"]),
        ("ballistics.collision.shapes.base", ["BulletCollision"]),
        ("ballistics.collision.shapes.static_plane", ["BulletCollision"]),
        ("ballistics.collision.shapes.sphere", ["BulletCollision"]),
        ("ballistics.collision.shapes.box", ["BulletCollision"]),
        ("ballistics.collision.shapes.capsule", ["BulletCollision"]),
        # dynamics
        ("ballistics.dynamics.rigid_body", ["BulletDynamics"]),
        ("ballistics.dynamics.world.discrete", ["BulletDynamics", "GL"],
            ["ballistics/debug/gl_debug_draw.cpp"]),
        ("ballistics.dynamics.constraintsolver.base", ["BulletDynamics"]),
        ("ballistics.dynamics.constraintsolver.sequential_impulse", 
            ["BulletDynamics"]),
        ("ballistics.dynamics.constraintsolver.typed_constraint",
            ["BulletDynamics"]),
    ]

ext_modules = []
for mod_spec in wrapper_modules:
    module, libs = mod_spec[:2]    
    files = [module.replace(".", "/") + ext_ext] 
    if len(mod_spec) == 3:
        files += mod_spec[2]
    ext_modules.append(Extension(module, files, libraries=libs,
        language="c++", include_dirs=[
            "ballistics/linearmath",
            "ballistics/debug",
        ]))


setup(
    name = "ballistics",
    author = "Luper Rouch",
    author_email = "luper.rouch@gmail.com",
    url = "http://github.com/flupke/ballistics",
    description = "Bullet Physics Python bindings",
    long_description = open("README.rst").read(),
    version = "0.1",
    classifiers = [
        "Development Status :: 4 - Beta",
        "Environment :: Console",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: zlib/libpng License",
        "Natural Language :: English",
        "Operating System :: OS Independent",
        "Programming Language :: Cython",
        "Programming Language :: Python",
        "Topic :: Software Development :: Libraries :: Python Modules",
        "Topic :: Multimedia :: Graphics :: Graphics Conversion",
    ],

    packages = find_packages(exclude=["build", "fake_pyrex"]),
    ext_modules = ext_modules,
    
    cmdclass = {"build_ext": build_ext},
)
