
import QtQuick 2.15

Item {
    id: root
    Image {
        source: (lock_state == true) ? "lock.png" : "unlock.png";
        scale: lockMouse.pressed ? 0.9 : 1.0
        MouseArea {
            id: lockMouse
            anchors.fill: parent
            anchors.margins: -10

            property int pressAndHoldDuration: 2000
            signal myPressAndHold()

            onPressed: {
                pressAndHoldTimer.start();
            }
            onReleased: {
                pressAndHoldTimer.stop();
            }
            onMyPressAndHold: {
                lock_state=!lock_state
            }

            Timer {
                id:  pressAndHoldTimer
                interval: parent.pressAndHoldDuration
                running: false
                repeat: false
                onTriggered: {
                    parent.myPressAndHold();
                }
            }
        }
    }
}
