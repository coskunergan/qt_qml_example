#include <QGuiApplication>
#include <QQmlFileSelector>
#include <QQuickView>
#include <QQmlApplicationEngine>
#include "fullflex.h"
#include <unistd.h>
#include <QTimer>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("Qt_GTM_FullFlex");

    QGuiApplication app(argc, argv);

    qmlRegisterType<Fullflex>("coskunergan.dev.fullflex", 1, 0, "Fullflex");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/dialcontrol.qml")));

    //QObject *object = engine.rootObjects()[0];
    //QObject *fullflex = object->findChild<QObject*>("FullFlexDial");

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
    //if (item)
    item->setProperty("color", QColor(Qt::yellow));

    QQuickItem *slider = view.rootObject()->findChild<QQuickItem *>("FullFlexSlider");

    QTimer timer;

    QObject::connect(&timer, &QTimer::timeout, [&]()
    {
        //ptrFullflex->setWidthA(512);
        //ptrFullflex->setWidthA(512);
        if(item->width() != 512)
        {
            item->setWidth(512);
        }
        else
        {
            item->setHeight(412);
        }

        item->setWidth(slider->x());
    }
                    );

    timer.start(10);

    return app.exec();
}
