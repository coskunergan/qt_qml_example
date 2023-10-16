
import QtQuick 2.15

Item {
    id: root
    Image {
        source: (lock_state == true) ? "lock.png" : "unlock.png";
        scale: lockMouse.pressed ? 0.9 : 1.0
        SequentialAnimation {
               id: anim
               PropertyAnimation {
                   target: root
                   property: "opacity"
                   to: 0.2
                   duration: 1000
                   easing.type: Easing.OutQuart
               }
               PropertyAnimation {
                   target: root
                   property: "opacity"
                   to: 1
                   duration: 1000
                   easing.type: Easing.InOutCubic
               }
           }
        Timer {
            id: fadeTimer
            interval: 3000;
            repeat: true
            onTriggered: { anim.running = lock_state }
        }
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
                fadeTimer.start();
                anim.running = lock_state
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
