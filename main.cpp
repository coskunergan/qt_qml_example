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
#include <QModbusServer>
//#include <QModbusRtuSerialSlave>
#if QT_CONFIG(modbus_serialport)
#    include <QModbusRtuSerialServer>
#    include <QSerialPortInfo>
#endif
#include <QSerialPort>
#include <QModbusTcpServer>
#include <QUrl>

int select_pan = 0;
quint16 config_bits = 0;
quint16 temp_config_bits = 0;
quint16 dial1_x;
quint16 dial1_y;
quint16 dial2_x;
quint16 dial2_y;
quint16 dial3_x;
quint16 dial3_y;
quint16 dial4_x;
quint16 dial4_y;
quint16 dial5_x;
quint16 dial5_y;
quint16 dial1_state;
quint16 dial2_state;
quint16 dial3_state;
quint16 dial4_state;
quint16 dial5_state;
QModbusServer *modbusDevice = nullptr;

#define SLIDER_TIMEOUT 30 // ~3sn

enum ModbusConnection
{
    Serial,
    Tcp
};

ModbusConnection type = Tcp;

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("Qt_GTM_FullFlex");

    QGuiApplication app(argc, argv);

    QQuickView view;
    view.connect(view.engine(), &QQmlEngine::quit, &app, &QCoreApplication::quit);
    view.setSource(QUrl("qrc:/dialcontrol.qml"));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.showFullScreen();

    QQuickItem *item1 = view.rootObject()->findChild<QQuickItem *>("Dial1");
    QQuickItem *item2 = view.rootObject()->findChild<QQuickItem *>("Dial2");
    QQuickItem *item3 = view.rootObject()->findChild<QQuickItem *>("Dial3");
    QQuickItem *item4 = view.rootObject()->findChild<QQuickItem *>("Dial4");
    QQuickItem *item5 = view.rootObject()->findChild<QQuickItem *>("Dial5");
    QQuickItem *slider = view.rootObject()->findChild<QQuickItem *>("Slider");

    int timeout_count = 0;
    QTimer timer;
    QObject::connect(&timer, &QTimer::timeout, [&]()
    {
        static int m_select_pan = 1;
        static int m_slider = 0;
        if(timeout_count)
        {
            if(--timeout_count == 0)
            {
                select_pan = 0;
            }
        }
        if(m_slider != view.rootObject()->property("slider_value").toInt())
        {
            m_slider = view.rootObject()->property("slider_value").toInt();
            timeout_count = SLIDER_TIMEOUT;
        }
        if(select_pan != m_select_pan)
        {
            timeout_count = SLIDER_TIMEOUT;
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
            view.rootObject()->setProperty("isUpdate", select_pan);
            m_select_pan = select_pan;
            if(select_pan)
            {
                view.rootObject()->setProperty("slider_visib", dial1_state | dial2_state | dial3_state | dial4_state | dial5_state);
            }
            else
            {
                view.rootObject()->setProperty("slider_visib", false);
            }
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
        //----------- MODBUS --------------
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(1), &dial1_x);
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(2), &dial1_y);
        view.rootObject()->setProperty("dial1_valuex", dial1_x * 55 / 10 + 100);
        view.rootObject()->setProperty("dial1_valuey", dial1_y * 28 / 10 + 10);
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(3), &dial1_state);
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(4), &dial2_x);
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(5), &dial2_y);
        view.rootObject()->setProperty("dial2_valuex", dial2_x * 55 / 10 + 100);
        view.rootObject()->setProperty("dial2_valuey", dial2_y * 28 / 10 + 10);
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(6), &dial2_state);
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(7), &dial3_x);
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(8), &dial3_y);
        view.rootObject()->setProperty("dial3_valuex", dial3_x * 55 / 10 + 100);
        view.rootObject()->setProperty("dial3_valuey", dial3_y * 28 / 10 + 10);
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(9), &dial3_state);
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(10), &dial4_x);
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(11), &dial4_y);
        view.rootObject()->setProperty("dial4_valuex", dial4_x * 55 / 10 + 100);
        view.rootObject()->setProperty("dial4_valuey", dial4_y * 28 / 10 + 10);
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(12), &dial4_state);
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(13), &dial5_x);
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(14), &dial5_y);
        view.rootObject()->setProperty("dial5_valuex", dial5_x * 55 / 10 + 100);
        view.rootObject()->setProperty("dial5_valuey", dial5_y * 28 / 10 + 10);
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(15), &dial5_state);

        modbusDevice->setData(QModbusDataUnit::HoldingRegisters, quint16(25), view.rootObject()->property("dial1_value").toInt());
        modbusDevice->setData(QModbusDataUnit::HoldingRegisters, quint16(26), view.rootObject()->property("dial2_value").toInt());
        modbusDevice->setData(QModbusDataUnit::HoldingRegisters, quint16(27), view.rootObject()->property("dial3_value").toInt());
        modbusDevice->setData(QModbusDataUnit::HoldingRegisters, quint16(28), view.rootObject()->property("dial4_value").toInt());
        modbusDevice->setData(QModbusDataUnit::HoldingRegisters, quint16(29), view.rootObject()->property("dial5_value").toInt());
        //dial1_state = true; // test
        modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(0), &config_bits);
        {
            if(config_bits & 0x1)
            {
                view.rootObject()->setProperty("drv_power_state", true);
            }
            else
            {
                view.rootObject()->setProperty("drv_power_state", false);
                view.rootObject()->setProperty("power_state", false);
                dial1_state = 0;
                dial2_state = 0;
                dial3_state = 0;
                dial4_state = 0;
                dial5_state = 0;
                select_pan = 0;
                view.rootObject()->setProperty("dial1_value", 0);
                view.rootObject()->setProperty("dial2_value", 0);
                view.rootObject()->setProperty("dial3_value", 0);
                view.rootObject()->setProperty("dial4_value", 0);
                view.rootObject()->setProperty("dial5_value", 0);
            }
        }
        view.rootObject()->setProperty("dial1_state", dial1_state);
        view.rootObject()->setProperty("dial2_state", dial2_state);
        view.rootObject()->setProperty("dial3_state", dial3_state);
        view.rootObject()->setProperty("dial4_state", dial4_state);
        view.rootObject()->setProperty("dial5_state", dial5_state);
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

    if(type == Serial)
    {
        modbusDevice = new QModbusRtuSerialServer();
        modbusDevice->setConnectionParameter(QModbusDevice::SerialPortNameParameter, "COM2");
        modbusDevice->setConnectionParameter(QModbusDevice::SerialParityParameter, QSerialPort::NoParity);
        modbusDevice->setConnectionParameter(QModbusDevice::SerialBaudRateParameter, QSerialPort::Baud19200);
        modbusDevice->setConnectionParameter(QModbusDevice::SerialDataBitsParameter, QSerialPort::Data8);
        modbusDevice->setConnectionParameter(QModbusDevice::SerialStopBitsParameter, QSerialPort::OneStop);
    }
    else if(type == Tcp)
    {
        modbusDevice = new QModbusTcpServer();

        const QUrl url = QUrl::fromUserInput(QLatin1String("192.168.4.2:50200"));
        modbusDevice->setConnectionParameter(QModbusDevice::NetworkPortParameter, url.port());
        modbusDevice->setConnectionParameter(QModbusDevice::NetworkAddressParameter, url.host());
    }


    QModbusDataUnitMap reg;
    //reg.insert(QModbusDataUnit::Coils, { QModbusDataUnit::Coils, 0, 10 });
    //reg.insert(QModbusDataUnit::DiscreteInputs, { QModbusDataUnit::DiscreteInputs, 0, 10 });
    reg.insert(QModbusDataUnit::HoldingRegisters, { QModbusDataUnit::HoldingRegisters, 0, 33 });
    //reg.insert(QModbusDataUnit::InputRegisters, { QModbusDataUnit::InputRegisters, 0, 10 });

    modbusDevice->setMap(reg);

    modbusDevice->setServerAddress(1);
    modbusDevice->connectDevice();

    return app.exec();
}


