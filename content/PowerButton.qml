
import QtQuick

Item {
    id: root
    Flipable {
        id: flipable
        width: 64
        height: 64
        property bool flipped: false
        scale: powerMouse.pressed ? 0.9 : 1.0
        front: Image { source: "power.png"; anchors.centerIn: parent }
        back: Image { source: "power.png"; anchors.centerIn: parent }

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
        MouseArea {
            id: powerMouse
            anchors.fill: parent
            anchors.margins: -10
            onClicked:
            {
                if(power_state)
                {
                    power_state=false;
                    flipable.flipped = !flipable.flipped;
                    pause_state=false;
                    dial1_value=0;
                    dial2_value=0;
                    dial3_value=0;
                    dial4_value=0;
                    dial5_value=0;
                    dial1_state=0;
                    dial2_state=0;
                    dial3_state=0;
                    dial4_state=0;
                    dial5_state=0;
                }
                else
                {
                    power_state=true;
                    flipable.flipped = !flipable.flipped;
                }
            }
        }
    }
}
