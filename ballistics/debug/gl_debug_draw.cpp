#include <LinearMath/btIDebugDraw.h>
#include <GL/gl.h>
#include <stdio.h>
#include "gl_debug_draw.h"

glDebugDraw::glDebugDraw() 
{
    setDebugMode(btIDebugDraw::DBG_DrawWireframe);
}

void glDebugDraw::drawLine(const btVector3 &from, const btVector3 &to, 
            const btVector3 &color)
{
    glColor3f(color.x(), color.y(), color.z());
    glBegin(GL_LINES);
    glVertex3f(from.x(), from.y(), from.z());
    glVertex3f(to.x(), to.y(), to.z());
    glEnd();
}

void glDebugDraw::drawContactPoint(const btVector3 &PointOnB, 
        const btVector3 &normalOnB, btScalar distance, int lifeTime, 
        const btVector3 &color)
{

}

void glDebugDraw::reportErrorWarning(const char *warningString)
{
    printf("Warning: %s", warningString);
}

void glDebugDraw::draw3dText(const btVector3 &location, const char *textString)
{
    printf("%s", textString);
}

void glDebugDraw::setDebugMode(int debugMode)
{
    m_debugMode = debugMode;
}

int glDebugDraw::getDebugMode() const
{
    return m_debugMode;
}
