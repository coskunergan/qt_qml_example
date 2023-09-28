#ifndef FULLFLEX_H
#define FULLFLEX_H

#include <QObject>
#include <QQuickPaintedItem>

class Fullflex : public QQuickPaintedItem
{
    Q_OBJECT

    Q_PROPERTY(qreal widthFullflex WRITE setWidthA NOTIFY WidthAChanged)

public:
    Fullflex(QQuickItem *parent = 0);
    virtual void paint(QPainter *painter);

    void setWidthA(qreal x);

signals:
    void WidthAChanged();

private:
    qreal m_widthA;

};

#endif // FULLFLEX_H
