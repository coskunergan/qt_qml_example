
#include <QDebug>
#include "fullflex.h"

extern int select_pan;

PanClass::PanClass(int pan, QObject *parent) :
    QObject(parent),
    m_pan(pan)
{
}

void PanClass::msgSlot(const QString &str)
{
    qDebug() << " PAN: " << m_pan << " ";

    if(select_pan == m_pan)
    {
        select_pan = 0;
    }
    else
    {
        select_pan = m_pan;        
    }
    qDebug() << str;
}
