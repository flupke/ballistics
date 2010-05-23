#!/usr/bin/env python

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext


ext_modules = [
        Extension(
            "ballistics.linearmath.vector3",
            ["ballistics/linearmath/vector3.pyx"], 
            libraries=["BulletDynamics"], 
            language="c++"),
    ]


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

    packages = ["potrace", "potrace.agg"],
    ext_modules = ext_modules,
    
    cmdclass = {"build_ext": build_ext},
)
