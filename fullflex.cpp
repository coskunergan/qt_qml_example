
#include <QDebug>
#include "fullflex.h"

Fullflex::Fullflex(QObject *parent) :
    QObject(parent)
{
}

void Fullflex::msgSlot(const QString &str)
{
    qDebug() << " test string msg = " << str;
}
