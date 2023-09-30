#ifndef FULLFLEX_H
#define FULLFLEX_H

#include <QObject>

class PanClass : public QObject
{
    Q_OBJECT
public:
    explicit PanClass(int pan, QObject *parent = 0);
public slots:
    void msgSlot(const QString &str);

private:
    int m_pan;

};

#endif // FULLFLEX_H
