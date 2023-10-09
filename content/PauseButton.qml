
import QtQuick 2.15

Item {
    id: root
    Image {
        source: "pause.png"
        scale: pauseMouse.pressed ? 0.9 : 1.0
        MouseArea {
            id: pauseMouse
            anchors.fill: parent
            anchors.margins: -10
            onClicked: {
                if(lock_state == false)
                {
                    if(pause_state == false)
                    {
                        pause_state = true;
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
                    else
                    {
                        pause_state = false;
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
