#ifndef __BALLISTICS_MOTION_STATE__
#define __BALLISTICS_MOTION_STATE__

#include "LinearMath/btMotionState.h"
#include "Python.h"

/**
 * A custom motion state used to notify its Python counterpart when Bullet
 * updates it.
 */
class BstxMotionState : public btMotionState
{
    PyObject *m_instance;
    PyObject *m_updateTransformMethod;
    PyObject *m_args;
    btTransform m_initialTrans;

public:
    BstxMotionState(btTransform &initialTrans, PyObject *instance);
    ~BstxMotionState();
    virtual void getWorldTransform(btTransform &worldTrans) const;
    virtual void setWorldTransform(const btTransform &worldTrans);
    void setKinematicTransform(const btTransform &kineTrans);

    // This must be called once before using any BstxMotionState object
    static void init();
};

#endif
