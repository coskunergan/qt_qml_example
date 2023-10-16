
import QtQuick

Item {
    id: root
    Flipable {
        id: flipable
        width: 64
        height: 64
        property bool flipped: false
        scale: pauseMouse.pressed ? 0.9 : 1.0
        front: Image { source: "pause.png"; anchors.centerIn: parent }
        back: Image { source: "play.png"; anchors.centerIn: parent }

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
        onVisibleChanged: {
            flipable.flipped = !flipable.flipped;
        }
        MouseArea {
            id: pauseMouse
            anchors.fill: parent
            anchors.margins: -10
            onClicked: {
                if(lock_state == false)
                {                    
                        if(pause_state == false)
                        {
                            if(dial1_value || dial2_value || dial3_value|| dial4_value|| dial5_value)
                            {
                                pause_state = true;
                                flipable.flipped = (pause_state) ? !flipable.flipped : false;
                                backup_dial1_value = dial1_value;
                                backup_dial2_value = dial2_value;
                                backup_dial3_value = dial3_value;
                                backup_dial4_value = dial4_value;
                                backup_dial5_value = dial5_value;
                                dial1_value=0;
                                dial2_value=0;
                                dial3_value=0;
                                dial4_value=0;
                                dial5_value=0;
                            }
                        }
                        else
                        {
                            pause_state = false;
                            flipable.flipped = (pause_state) ? !flipable.flipped : false;
                            dial1_value = backup_dial1_value;
                            dial2_value = backup_dial2_value;
                            dial3_value = backup_dial3_value;
                            dial4_value = backup_dial4_value;
                            dial5_value = backup_dial5_value;
                        }
                }
            }
        }
    }
}
