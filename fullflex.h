#ifndef FULLFLEX_H
#define FULLFLEX_H

#include <QObject>

class Fullflex : public QObject
{
    Q_OBJECT
public:
    explicit Fullflex(QObject *parent = 0);
public slots:
    void msgSlot(const QString &str);
};
#endif // FULLFLEX_H
