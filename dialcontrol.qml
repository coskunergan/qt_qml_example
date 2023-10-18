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
    //visibility:  "FullScreen"
    //value: slider.x * 100 / (container.width - 32)
    property int isUpdate: 0
    property bool slider_visib: false
    property int slider_value: slider.x * 11 / (container.width - 32)
    property int dial1_state : 0
    property real dial1_value : 0
    property real dial1_valuex : 0
    property real dial1_valuey : 0
    property int dial2_state : 0
    property real dial2_value : 0
    property real dial2_valuex : 0
    property real dial2_valuey : 0
    property int dial3_state : 0
    property real dial3_value : 0
    property real dial3_valuex : 0
    property real dial3_valuey : 0
    property int dial4_state : 0
    property real dial4_value : 0
    property real dial4_valuex : 0
    property real dial4_valuey : 0
    property int dial5_state : 0
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
    property bool drv_power_state : false
    color: (power_state) ? "#141414" : "#000000"
    Label {
        text: qsTr("  GTM Europe V1.0")
        visible: true
        font.pointSize: 6
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 2
    }
    Logo {
        objectName: "Logo"
        id: logo
        anchors.centerIn: parent
        active: !power_state
    }
    Dial {
        objectName: "Dial1"
        id: dial1
        visible: false
        selected: (isUpdate == 1) ? true : false
        active: (isUpdate == 1 || isUpdate == 0) ? true : false
        signal sendMessage(string msg)
        value : dial1_value
        valuex : dial1_valuex
        valuey : dial1_valuey
        dial_state: dial1_state
        p_state: power_state
    }

    Dial {
        objectName: "Dial2"
        id: dial2
        visible: false
        selected: (isUpdate == 2) ? true : false
        active: (isUpdate == 2 || isUpdate == 0) ? true : false
        signal sendMessage(string msg)
        value : dial2_value
        valuex : dial2_valuex
        valuey : dial2_valuey
        dial_state: dial2_state
        p_state: power_state
    }
    Dial {
        objectName: "Dial3"
        id: dial3
        visible: false
        selected: (isUpdate == 3) ? true : false
        active: (isUpdate == 3 || isUpdate == 0) ? true : false
        signal sendMessage(string msg)
        value : dial3_value
        valuex : dial3_valuex
        valuey : dial3_valuey
        dial_state: dial3_state
        p_state: power_state
    }
    Dial {
        objectName: "Dial4"
        id: dial4
        visible: false
        selected: (isUpdate == 4) ? true : false
        active: (isUpdate == 4 || isUpdate == 0) ? true : false
        signal sendMessage(string msg)
        value : dial4_value
        valuex : dial4_valuex
        valuey : dial4_valuey
        dial_state: dial4_state
        p_state: power_state
    }
    Dial {
        objectName: "Dial5"
        id: dial5
        visible: false
        selected: (isUpdate == 5) ? true : false
        active: (isUpdate == 5 || isUpdate == 0) ? true : false
        signal sendMessage(string msg)
        value : dial5_value
        valuex : dial5_valuex
        valuey : dial5_valuey
        dial_state: dial5_state
        p_state: power_state
    }    
    PowerButton {
        objectName: "PowerButton"
        id: power
        visible: drv_power_state
        opacity : 1 - container.opacity
        anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter;
            bottomMargin: 38;
        }
        width: 64; height: 64
    }
    PauseButton {
        objectName: "PauseButton"
        id: pause
        visible : (power_state) ? true : false
        opacity : 1 - container.opacity
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 38
        anchors.left: power.right
        anchors.leftMargin: 30
        width: 64; height: 64
    }
    LockButton {
        objectName: "LockButton"
        id: lock
        visible : (power_state) ? true : false
        opacity : 1 - container.opacity
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 38
        anchors.right: power.left
        anchors.rightMargin: 30
        width: 64; height: 64
    }
    Rectangle {
        id: container
        visible: false
        objectName: "Slider"
        property int oldWidth: 0
        anchors { bottom: parent.bottom; left: parent.left
            right: parent.right; leftMargin: 20; rightMargin: 20
            bottomMargin: 40
        }
        height: 52
        radius: 8
        opacity: 0.7
        antialiasing: true
        gradient: Gradient {
            GradientStop { position: 0.0; color: "gray" }
            GradientStop { position: 0.2; color: "#141414" }
        }
        Label {
            id:label_0
            x:45
            font.family: "Helvetica"
            font.bold: true
            color: (slider_value == 0) ? "antiquewhite" : "dimgray"
            text: qsTr("0")
            font.pointSize: 45
        }
        Label {
            id:label_1
            anchors.left: label_0.right
            anchors.leftMargin: 55
            font.family: "Helvetica"
            font.bold: true
            color: (slider_value == 1) ? "antiquewhite" : "dimgray"
            text: qsTr("1")
            font.pointSize: 45
        }
        Label {
            id:label_2
            anchors.left: label_1.right
            anchors.leftMargin: 55
            font.family: "Helvetica"
            font.bold: true
            color: (slider_value == 2) ? "antiquewhite" : "dimgray"
            text: qsTr("2")
            font.pointSize: 45
        }
        Label {
            id:label_3
            anchors.left: label_2.right
            anchors.leftMargin: 55
            font.family: "Helvetica"
            font.bold: true
            color: (slider_value == 3) ? "antiquewhite" : "dimgray"
            text: qsTr("3")
            font.pointSize: 45
        }
        Label {
            id:label_4
            anchors.left: label_3.right
            anchors.leftMargin: 55
            font.family: "Helvetica"
            font.bold: true
            color: (slider_value == 4) ? "antiquewhite" : "dimgray"
            text: qsTr("4")
            font.pointSize: 45
        }
        Label {
            id:label_5
            anchors.left: label_4.right
            anchors.leftMargin: 55
            font.family: "Helvetica"
            font.bold: true
            color: (slider_value == 5) ? "antiquewhite" : "dimgray"
            text: qsTr("5")
            font.pointSize: 45
        }
        Label {
            id:label_6
            anchors.left: label_5.right
            anchors.leftMargin: 55
            font.family: "Helvetica"
            font.bold: true
            color: (slider_value == 6) ? "antiquewhite" : "dimgray"
            text: qsTr("6")
            font.pointSize: 45
        }
        Label {
            id:label_7
            anchors.left: label_6.right
            anchors.leftMargin: 55
            font.family: "Helvetica"
            font.bold: true
            color: (slider_value == 7) ? "antiquewhite" : "dimgray"
            text: qsTr("7")
            font.pointSize: 45
        }
        Label {
            id:label_8
            anchors.left: label_7.right
            anchors.leftMargin: 55
            font.family: "Helvetica"
            font.bold: true
            color: (slider_value == 8) ? "antiquewhite" : "dimgray"
            text: qsTr("8")
            font.pointSize: 45
        }
        Label {
            id:label_9
            anchors.left: label_8.right
            anchors.leftMargin: 55
            font.family: "Helvetica"
            font.bold: true
            color: (slider_value == 9) ? "antiquewhite" : "dimgray"
            text: qsTr("9")
            font.pointSize: 45
        }
        Label {
            id:label_B
            anchors.left: label_9.right
            anchors.leftMargin: 55
            font.family: "Helvetica"
            font.bold: true
            color: (slider_value == 10) ? "antiquewhite" : "dimgray"
            text: qsTr("B")
            font.pointSize: 45
        }

        // --------------animation visible start --------------

        state: (slider_visib && !lock_state && !pause_state && power_state) ? "Visible" : "Invisible"

        states: [
            State{
                name: "Visible"
                PropertyChanges{target: container; opacity: 1.0}
                PropertyChanges{target: container; visible: true}
            },
            State{
                name:"Invisible"
                PropertyChanges{target: container; opacity: 0.0}
                PropertyChanges{target: container; visible: false}
            }
        ]
        transitions: [
            Transition {
                from: "Visible"
                to: "Invisible"
                SequentialAnimation{
                    NumberAnimation {
                        target: container
                        property: "opacity"
                        duration: 500
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        target: container
                        property: "visible"
                        duration: 0
                    }
                }
            },

            Transition {
                from: "Invisible"
                to: "Visible"
                SequentialAnimation{
                    NumberAnimation {
                        target: container
                        property: "visible"
                        duration: 0
                    }
                    NumberAnimation {
                        target: container
                        property: "opacity"
                        duration: 500
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        ]
        //---------- animation visible end -----------
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
            visible : false
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
           slider.x = slider_value * (container.width - 32) / 11
        }
    }
    QuitButton {
        objectName: "QuitButton"
        id: quit
        anchors.right: parent.right
        anchors.top: parent.top        
        anchors.topMargin: 20
        anchors.rightMargin: 38
    }
}
//! [0]
