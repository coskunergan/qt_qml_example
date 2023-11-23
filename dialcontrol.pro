QT += serialbus widgets
requires(qtConfig(combobox))

qtConfig(modbus-serialport): QT += serialport

TEMPLATE = app
TARGET = GTM_Control

QT += quick qml
QT += gui
CONFIG += c++11

SOURCES += main.cpp \
    fullflex.cpp

RESOURCES += dialcontrol.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/quick/customitems/dialcontrol
INSTALLS += target

HEADERS += \
    fullflex.h

contains(ANDROID_TARGET_ARCH,arm64-v8a) {
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
}
