/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

//! [imports]
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import "content"
//! [imports]

//! [0]
Rectangle {
    //id: rectangle
    objectName: "Root"
    id: root
    visible: true
    width: 640
    height: 480
    color: "#545454"    
    //visibility:  "FullScreen"
    //value: slider.x * 100 / (container.width - 32)
    property int isUpdate: 0
    property int slider_value: slider.x * 100 / (container.width - 32)
    property real dial1_value : 0
    property real dial1_valuex : 0
    property real dial1_valuey : 0
    property real dial2_value : 0
    property real dial2_valuex : 0
    property real dial2_valuey : 0
    property real dial3_value : 0
    property real dial3_valuex : 0
    property real dial3_valuey : 0
    property real dial4_value : 0
    property real dial4_valuex : 0
    property real dial4_valuey : 0
    property real dial5_value : 0
    property real dial5_valuex : 0
    property real dial5_valuey : 0
    property real backup_dial1_value : 0
    property real backup_dial2_value : 0
    property real backup_dial3_value : 0
    property real backup_dial4_value : 0
    property real backup_dial5_value : 0
    property bool pause_state : false
    property bool lock_state : false
    property bool power_state : false
    Label {
        text: qsTr("  V1.0")
        visible: false
        font.pointSize: 6
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 2
    }

    Dial {
        objectName: "Dial1"
        id: dial1
        visible: false
        signal sendMessage(string msg)
        value : dial1_value
        valuex : dial1_valuex
        valuey : dial1_valuey
    }

    Dial {
        objectName: "Dial2"
        id: dial2
        visible: false
        signal sendMessage(string msg)
        value : dial2_value
        valuex : dial2_valuex
        valuey : dial2_valuey
    }
    Dial {
        objectName: "Dial3"
        id: dial3
        visible: false
        signal sendMessage(string msg)
        value : dial3_value
        valuex : dial3_valuex
        valuey : dial3_valuey
    }
    Dial {
        objectName: "Dial4"
        id: dial4
        visible: false
        signal sendMessage(string msg)
        value : dial4_value
        valuex : dial4_valuex
        valuey : dial4_valuey
    }
    Dial {
        objectName: "Dial5"
        id: dial5
        visible: false
        signal sendMessage(string msg)
        value : dial5_value
        valuex : dial5_valuex
        valuey : dial5_valuey
    }

    Rectangle {
        id: container
        visible: false
        objectName: "Slider"
        property int oldWidth: 0
        anchors { bottom: parent.bottom; left: parent.left
            right: parent.right; leftMargin: 20; rightMargin: 20
            bottomMargin: 30
        }
        height: 40
        radius: 8
        opacity: 0.7
        antialiasing: true
        gradient: Gradient {
            GradientStop { position: 0.0; color: "gray" }
            GradientStop { position: 1.0; color: "white" }
        }

       onWidthChanged: {
            if (oldWidth === 0) {
                oldWidth = width;
                return
            }

            var desiredPercent = slider.x * 100 / (oldWidth - 32)
            slider.x = desiredPercent * (width - 32) / 100
            oldWidth = width
        }
        Rectangle {
            id: slider
            objectName: "FullFlexSlider"
            x: 1; y: 1; width: 30; height: 38
            radius: 12
            antialiasing: true
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#424242" }
                GradientStop { position: 1.0; color: "red" }
            }
            /*MouseArea {
                anchors.fill: parent
                anchors.margins: -16 // Increase mouse area a lot outside the slider
                drag.target: parent; drag.axis: Drag.XAxis
                drag.minimumX: 0; drag.maximumX: container.width - 32
            }*/
        }
        MultiPointTouchArea{
            anchors.fill: container
            touchPoints: [
                TouchPoint {
                    id: point1
                    onPressedChanged: function(){
                    if(pressed)
                        {
                            //console.log("pressed");
                            //console.log(touchslider.testStringReturn());
                            //touchslider.sliderSetValueFromTouch(slider, );
                            if(point1.x < container.width - 32 && point1.x > 0)
                            {
                                slider.x = point1.x;
                            }
                        }
                    }
                }
            ]
            onTouchUpdated: function(){
                //touchslider.sliderSetValueFromTouch(slider, point1.x);
                if(point1.x <= container.width - 32 && point1.x > 0)
                {
                    slider.x = point1.x;
                }
            }
        }
    }    
    Connections {
        target: targetItem
        onIsUpdateChanged: {
           slider.x = slider_value * (container.width - 32) / 100
        }
    } 
    QuitButton {
        objectName: "QuitButton"
        id: quit
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 30
    }
    PowerButton {
        objectName: "PowerButton"
        id: power
        visible: !slider.visible
        anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter;
            bottomMargin: 10;
        }
        width: 120; height: 120
    }
    PauseButton {
        objectName: "PauseButton"
        id: pause
        visible: !slider.visible
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        anchors.left: power.right
        anchors.leftMargin: 10
        width: 64; height: 64
    }
    LockButton {
        objectName: "LockButton"
        id: lock
        visible: !slider.visible
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 38
        anchors.right: power.left
        anchors.rightMargin: 10
        width: 64; height: 64
    }
}
//! [0]
