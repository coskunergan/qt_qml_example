#include <QGuiApplication>
#include <QQmlFileSelector>
#include <QQuickView>
#include <QQmlApplicationEngine>
#include <QQuickPaintedItem>
#include "fullflex.h"
#include <unistd.h>
#include <QTimer>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("Qt_GTM_FullFlex");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/dialcontrol.qml")));

    QQuickView view;
    view.connect(view.engine(), &QQmlEngine::quit, &app, &QCoreApplication::quit);
    view.setSource(QUrl("qrc:/dialcontrol.qml"));
    if(view.status() == QQuickView::Error)
    {
        return -1;
    }
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.show();

    QQuickItem *item = view.rootObject()->findChild<QQuickItem *>("FullFlexDial");
    QQuickItem *slider = view.rootObject()->findChild<QQuickItem *>("FullFlexSlider");

    QTimer timer;
    QObject::connect(&timer, &QTimer::timeout, [&]()
    {
        item->setWidth(slider->x());
    }
                    );

    timer.start(10);

    Fullflex myClass;
    QObject::connect(item, SIGNAL(sendMessage(QString)),&myClass, SLOT(msgSlot(QString)));

    myClass.msgSlot("send main !!");

    return app.exec();
}
