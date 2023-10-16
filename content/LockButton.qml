
import QtQuick

Item {
    id: root
    Flipable {
        id: flipable
        width: 64
        height: 64
        property bool flipped: false
        scale: lockMouse.pressed ? 0.9 : 1.0
        front: Image { source: "unlock.png"; anchors.centerIn: parent }
        back: Image { source: "unlock.png"; anchors.centerIn: parent }

        transform: Rotation {
            id: rotation
            origin.x: flipable.width/2
            origin.y: flipable.height/2
            axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
            angle: 0    // the default angle
        }

        states: State {
            name: "back"
            PropertyChanges { target: rotation; angle: 180 }
            when: flipable.flipped
        }

        transitions: Transition {
            NumberAnimation { target: rotation; property: "angle"; duration: 500 }
        }
        Timer {
            id: flipTimer
            interval: 1000;
            repeat: true
            onTriggered: { flipable.flipped = (lock_state) ? !flipable.flipped : false}
        }
        onVisibleChanged: {
            flipable.flipped = !flipable.flipped;
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
                if(lock_state)
                flipTimer.start();
                else
                flipTimer.stop();

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
