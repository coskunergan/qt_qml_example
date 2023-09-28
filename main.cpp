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

     qmlRegisterType<Fullflex>("dev.coskunergan.fullflex",1,0,"Fullflex");

     QQmlApplicationEngine engine;
     engine.load(QUrl(QStringLiteral("qrc:/dialcontrol.qml")));

     QObject *object = engine.rootObjects()[0];
     QObject *fullflex = object->findChild<QObject*>("FullFlexDial");

     Fullflex *ptrFullflex = qobject_cast<Fullflex*>(fullflex);

     QTimer timer;

      //ptrFullflex->setWidthA(512);
     QObject::connect(&timer, &QTimer::timeout, [&]()
       {
         //ptrFullflex->setWidthA(512);
       }
       );

      timer.start(100);

     QQuickView view;
     view.connect(view.engine(), &QQmlEngine::quit, &app, &QCoreApplication::quit);
     view.setSource(QUrl("qrc:/dialcontrol.qml"));
     if (view.status() == QQuickView::Error)
         return -1;
     view.setResizeMode(QQuickView::SizeRootObjectToView);
     view.show();
     return app.exec();
}
