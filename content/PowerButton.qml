
import QtQuick 2.15

Item {
    id: root
    Image {
        source: "power.png"
        scale: powerMouse.pressed ? 0.9 : 1.0
        MouseArea {
            id: powerMouse
            anchors.fill: parent
            anchors.margins: -10
            onClicked:
            {
               // power fonc.
                pause_state=false;
                dial1_value=0;
                dial2_value=0;
                dial3_value=0;
                dial4_value=0;
                dial5_value=0;
            }
        }
    }
}
