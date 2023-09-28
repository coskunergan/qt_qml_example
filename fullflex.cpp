#include <QPainter>
#include "fullflex.h"

Fullflex::Fullflex(QQuickItem *parent)
    : QQuickPaintedItem(parent),
      m_widthA(512)
{

}

void Fullflex::paint(QPainter *painter)
{
    //QRectF rect = this->boundingRect();
    painter->setRenderHint(QPainter::Antialiasing);
    QPen pen = painter->pen();
    pen.setCapStyle(Qt::FlatCap);

    painter->save();
    m_widthA = 512;
    pen.setWidth(m_widthA);
    painter->restore();
}


void Fullflex::setWidthA(qreal x)
{
    if(m_widthA == x)
    {
        return;
    }

    m_widthA = x;
    emit WidthAChanged();
}
