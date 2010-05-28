#include "Python.h"
#include "bstx_motion_state.h"
#include "transform_api.h"


BstxMotionState::BstxMotionState(btTransform &initialTrans, 
        PyObject *instance):
    m_instance(instance),
    m_initialTrans(initialTrans)
{ 
    m_updateTransformMethod = PyObject_GetAttrString(instance, "update_transform");
    m_args = PyTuple_New(1);
}    

BstxMotionState::~BstxMotionState() 
{
    Py_DECREF(m_updateTransformMethod);
    Py_DECREF(m_args);
}

void BstxMotionState::getWorldTransform(btTransform &worldTrans) const
{
    worldTrans = m_initialTrans;
}

void BstxMotionState::setWorldTransform(const btTransform &worldTrans)
{
    PyGILState_STATE state;
    PyObject *trans, *ret;

    state = PyGILState_Ensure();

    trans = wrap_transform(worldTrans);
    PyTuple_SET_ITEM(m_args, 0, trans);
    ret = PyObject_CallObject(m_updateTransformMethod, m_args);
    Py_XDECREF(ret);
    Py_XDECREF(trans);
    
    PyGILState_Release(state);    
}

void BstxMotionState::setKinematicTransform(const btTransform &kineTrans)
{
    m_initialTrans = kineTrans;
}

void BstxMotionState::init()
{
    import_ballistics__linearmath__transform();
}
