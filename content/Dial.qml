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

import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import Qt5Compat.GraphicalEffects

Item {
    id: root
    property int dial_state : 0
    property real value : 0
    property int level: root.value
    property real valuex : 0
    property real valuey : 0
    property bool active: false
    property bool p_state: false
    property bool selected: false
    width: 210; height: 210
    scale: clickMouse.pressed ? ((dial_state & 0x10) ? 0.98 : 0.60) : ((dial_state & 0x10) ? 1.0 : 0.68)
    antialiasing: true
    x: valuex
    y: valuey

    // --------------animation first visible start --------------

    /*state: dial_state ? "Visible_First" : "Invisible_First"

    states: [
        State{
            name: "Visible_First"
            PropertyChanges{target: root; opacity: 1.0}
            PropertyChanges{target: root; visible: true}
        },
        State{
            name:"Invisible_First"
            PropertyChanges{target: root; opacity: 0.0}
            PropertyChanges{target: root; visible: false}
        }
    ]
    transitions: [
        Transition {
            from: "Visible_First"
            to: "Invisible_First"
            SequentialAnimation{
                NumberAnimation {
                    target: root
                    property: "opacity"
                    duration: 500
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: root
                    property: "visible"
                    duration: 0
                }
            }
        },

        Transition {
            from: "Invisible_First"
            to: "Visible_First"
            SequentialAnimation{
                NumberAnimation {
                    target: root
                    property: "visible"
                    duration: 0
                }
                NumberAnimation {
                    target: root
                    property: "opacity"
                    duration: 500
                    easing.type: Easing.InOutQuad
                }
            }
        }
    ]*/
    //---------- animation first visible end -----------
    state: (dial_state == 0 || power_state == false) ? "Invisible" : active ? "Visible" : "HalfInvisible"

    states: [
        State{
            name: "Visible"
            PropertyChanges{target: root; opacity: 1.0}
            PropertyChanges{target: root; visible: true}
        },
        State{
            name:"HalfInvisible"
            PropertyChanges{target: root; opacity: 0.2}
            PropertyChanges{target: root; visible: true}        
        },
        State{
            name:"Invisible"
            PropertyChanges{target: root; opacity: 0}
            PropertyChanges{target: root; visible: false}
        }
    ]
    transitions: [
        Transition {
            from: "Visible"
            to: "HalfInvisible"

            SequentialAnimation{
                NumberAnimation {
                    target: root
                    property: "opacity"
                    duration: 500
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: root
                    property: "visible"
                    duration: 0
                }
            }
        },

        Transition {
            from: "HalfInvisible"
            to: "Visible"
            SequentialAnimation{
                NumberAnimation {
                    target: root
                    property: "visible"
                    duration: 0
                }
                NumberAnimation {
                    target: root
                    property: "opacity"
                    duration: 500
                    easing.type: Easing.InOutQuad
                }
            }
        },

        Transition {
            from: "Invisible"
            to: "Visible"
            SequentialAnimation{
                NumberAnimation {
                    target: root
                    property: "visible"
                    duration: 0
                }
                NumberAnimation {
                    target: root
                    property: "opacity"
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
            }
        },
        Transition {
            from: "Visible"
            to: "Invisible"

            SequentialAnimation{
                NumberAnimation {
                    target: root
                    property: "opacity"
                    duration: 20
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: root
                    property: "visible"
                    duration: 0
                }
            }
        }
    ]
    //----------------------------
    Behavior on x {
       NumberAnimation {
                    duration: (dial_state == 0) ? 0 : 2000
                    easing.type: Easing.InOutQuad;
                    easing.amplitude: 1.1;
                    easing.period: 1.5
        }
    }
    Behavior on y {
       NumberAnimation {
                    duration: (dial_state == 0) ? 0 : 1500
                    easing.type: Easing.InOutQuad;
                    easing.amplitude: 1.1;
                    easing.period: 1.5
        }
    }
    Rectangle{
        id : select_circle
        visible: selected
        width: 215
        height: 215
        radius:180
        color: "antiquewhite"
        }
    Rectangle{        
        visible : select_circle.visible
        width:  213
        height: 213
        radius: 180
        x:1
        y:1        
        color: "#141414"
        }
    Image {
        source: "background.png"        
        x:3
        y:3
            RadialGradient {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position:  (level == 0) ? 0.3 : (0.45 - root.value / 50) ; color: "#00000000" }
                    GradientStop { position: 0.49 ; color: ((dial_state & 1) == 0 || ((dial_state & 2) == 0)) ? "#00000000" : (level == 0) ? "#4169e1" : Qt.rgba(root.value / 20, 0 , 0.25 - (root.value / 40), 1) }
                    GradientStop { position: 0.5; color: "#00000000" }
                }
            }
            Label {
                x: 90
                y: 70
                text:(level == 10) ? "P" : (level).toFixed(0)
                font.family: "Helvetica"
                font.bold: true
                font.pointSize: 55
                color : "antiquewhite"
            }
            /*DropShadow {
                    anchors.fill: rect
                    horizontalOffset: 3
                    verticalOffset: 3
                    radius: 8.0
                    color: "#80000000"
                    source: rect
                }*/
        MouseArea {
            id: clickMouse
            anchors.fill: parent
            anchors.margins: 10
            onClicked:{
                if(lock_state == false && pause_state == false)
                {
                    root.sendMessage("click pan")
                }
            }
        }
    }
}
