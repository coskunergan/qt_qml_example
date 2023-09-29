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


class Message : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int author READ author WRITE setAuthor NOTIFY authorChanged)
public:
    void setAuthor(const int &a) {
        if (a != m_author) {
            m_author = a;
            emit authorChanged();
        }
    }
    int author() {
        return m_author;
    }
signals:
    void authorChanged();
private:
    int m_author;
};

#endif // FULLFLEX_H
