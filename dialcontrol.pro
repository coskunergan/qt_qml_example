TEMPLATE = app
TARGET = dialcontrol

QT += quick qml

SOURCES += main.cpp \
    fullflex.cpp

RESOURCES += dialcontrol.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/quick/customitems/dialcontrol
INSTALLS += target

HEADERS += \
    fullflex.h
