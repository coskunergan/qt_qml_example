#include <QGuiApplication>
#include <QQmlFileSelector>
#include <QQuickView>
#include <QQmlApplicationEngine>
#include <QQuickPaintedItem>
#include "fullflex.h"
#include <unistd.h>
#include <QQmlContext>
#include <QQmlComponent>
#include <QTimer>

int select_pan = 0;

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("Qt_GTM_FullFlex");

    QGuiApplication app(argc, argv);

    //qmlRegisterType<Fullflex>("coskunergan.dev.fullflex", 1, 0, "Fullflex");

    //QQmlApplicationEngine engine;
    //engine.load(QUrl(QStringLiteral("qrc:/dialcontrol.qml")));

    QQuickView view;
    Message msg;
    msg.setAuthor(3);
    view.rootContext()->setContextProperty("msg", &msg);
    view.connect(view.engine(), &QQmlEngine::quit, &app, &QCoreApplication::quit);
    view.setSource(QUrl("qrc:/dialcontrol.qml"));
    if(view.status() == QQuickView::Error)
    {
        return -1;
    }
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.show();

    QQuickItem *root = view.rootObject()->findChild<QQuickItem *>("Root");
    QQuickItem *item1 = view.rootObject()->findChild<QQuickItem *>("Dial1");
    QQuickItem *item2 = view.rootObject()->findChild<QQuickItem *>("Dial2");
    QQuickItem *item3 = view.rootObject()->findChild<QQuickItem *>("Dial3");
    QQuickItem *item4 = view.rootObject()->findChild<QQuickItem *>("Dial4");
    QQuickItem *item5 = view.rootObject()->findChild<QQuickItem *>("Dial5");

    QQuickItem *slider = view.rootObject()->findChild<QQuickItem *>("FullFlexSlider");

    QTimer timer;
    QObject::connect(&timer, &QTimer::timeout, [&]()
    {
        if(select_pan != 0)
        {

        }
        //item1->setWidth(select_pan * 10);
        //MyFullflex.setsel_pan(3);
        msg.setAuthor(3);
    }
                    );

    timer.start(100);

    PanClass PanA(1);
    QObject::connect(item1, SIGNAL(sendMessage(QString)), &PanA, SLOT(msgSlot(QString)));
    PanClass PanB(2);
    QObject::connect(item2, SIGNAL(sendMessage(QString)), &PanB, SLOT(msgSlot(QString)));
    PanClass PanC(3);
    QObject::connect(item3, SIGNAL(sendMessage(QString)), &PanC, SLOT(msgSlot(QString)));
    PanClass PanD(4);
    QObject::connect(item4, SIGNAL(sendMessage(QString)), &PanD, SLOT(msgSlot(QString)));
    PanClass PanE(5);
    QObject::connect(item5, SIGNAL(sendMessage(QString)), &PanE, SLOT(msgSlot(QString)));

    PanA.msgSlot("Pan 1 Ready !!");
    PanB.msgSlot("Pan 2 Ready !!");
    PanC.msgSlot("Pan 3 Ready !!");
    PanD.msgSlot("Pan 4 Ready !!");
    PanE.msgSlot("Pan 5 Ready !!");

    return app.exec();
}
