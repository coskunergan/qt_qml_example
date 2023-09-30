#include <QGuiApplication>
#include <QQmlFileSelector>
#include <QQuickView>
#include <QQmlApplicationEngine>
#include <QQuickPaintedItem>
#include "fullflex.h"
#include <unistd.h>
#include <QQmlContext>
#include <QQmlComponent>
#include <QQmlProperty>
#include <QTimer>

int select_pan = 0;

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("Qt_GTM_FullFlex");

    QGuiApplication app(argc, argv);

    QQuickView view;
    view.connect(view.engine(), &QQmlEngine::quit, &app, &QCoreApplication::quit);
    view.setSource(QUrl("qrc:/dialcontrol.qml"));
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
        static int m_select_pan = 0;
        if(select_pan != m_select_pan)
        {
            view.rootObject()->setProperty("slider_update", select_pan);
            view.rootObject()->setProperty("update_slider", 123);
            switch(select_pan)
            {
                case 1:
                    view.rootObject()->setProperty("slider_value", view.rootObject()->property("dial1_value").toInt());
                    break;
                case 2:
                    view.rootObject()->setProperty("slider_value", view.rootObject()->property("dial2_value").toInt());
                    break;
                case 3:
                    view.rootObject()->setProperty("slider_value", view.rootObject()->property("dial3_value").toInt());
                    break;
                case 4:
                    view.rootObject()->setProperty("slider_value", view.rootObject()->property("dial4_value").toInt());
                    break;
                case 5:
                    view.rootObject()->setProperty("slider_value", view.rootObject()->property("dial5_value").toInt());
                    break;
                default:
                    break;

            }
            view.rootObject()->setProperty("isUpdate", !(view.rootObject()->property("isUpdate").toBool()));
            m_select_pan = select_pan;
        }
        switch(select_pan)
        {
            case 1:
                view.rootObject()->setProperty("dial1_value", view.rootObject()->property("slider_value").toInt());
                break;
            case 2:
                view.rootObject()->setProperty("dial2_value", view.rootObject()->property("slider_value").toInt());
                break;
            case 3:
                view.rootObject()->setProperty("dial3_value", view.rootObject()->property("slider_value").toInt());
                break;
            case 4:
                view.rootObject()->setProperty("dial4_value", view.rootObject()->property("slider_value").toInt());
                break;
            case 5:
                view.rootObject()->setProperty("dial5_value", view.rootObject()->property("slider_value").toInt());
                break;
            default:
                break;

        }
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

    //Worker worker;// = new Worker();
    //QObject* obj = view.rootObject();
    //QObject::connect(worker, SIGNAL(update_slider(QVariant)), obj, SLOT(update_slider(QVariant)));

    return app.exec();
}
