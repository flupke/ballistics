#ifndef __PYX_HAVE__ballistics__linearmath__transform
#define __PYX_HAVE__ballistics__linearmath__transform
#ifdef __cplusplus
#define __PYX_EXTERN_C extern "C"
#else
#define __PYX_EXTERN_C extern
#endif

/* "/home/flupke/source/ballistics/ballistics/linearmath/transform.pxd":38
 * 
 * 
 * cdef public api class Transform[type BstxTransformType, object BstxTransform]:             # <<<<<<<<<<<<<<
 * 
 *     cdef btTransform *wrapped
 */

struct BstxTransform {
  PyObject_HEAD
  btTransform *wrapped;
};

#ifndef __PYX_HAVE_API__ballistics__linearmath__transform

__PYX_EXTERN_C DL_IMPORT(PyTypeObject) BstxTransformType;

#endif

PyMODINIT_FUNC inittransform(void);

#endif
