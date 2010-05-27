#include "Python.h"
#include "bstx_motion_state.h"
#include "transform_api.h"


BstxMotionState::BstxMotionState(btTransform &initialTrans, 
        PyObject *instance):
    m_instance(instance),
    m_initialTrans(initialTrans)
{ }    

void BstxMotionState::getWorldTransform(btTransform &worldTrans) const
{
    worldTrans = m_initialTrans;
}

void BstxMotionState::setWorldTransform(const btTransform &worldTrans)
{
    PyGILState_STATE state;
    PyObject *trans;
    PyObject* ret;

    state = PyGILState_Ensure();

    trans = wrap_transform(worldTrans);
    ret = PyObject_CallMethod(m_instance, "update_transform", "O", trans);
    Py_XDECREF(trans);
    Py_XDECREF(ret);
    
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
