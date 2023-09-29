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
import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
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
    property int select: 0
    property real value2 : slider.x * 100 / (container.width - 32)

    Dial {
        objectName: "Dial1"
        id: dial1
        signal sendMessage(string msg)
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: -200
        height: 100
        opacity: 1.0
        value : (msg.author() == 3) ? value2 : value;
    }

    Dial {
        objectName: "Dial2"
        id: dial2
        signal sendMessage(string msg)
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: 200
        height:100
        opacity: 1.0
        value : (select == 2) ? value2 : value;
    }

    Dial {
        objectName: "Dial3"
        id: dial3
        signal sendMessage(string msg)
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: 650
        height: 100
        opacity: 1.0
        value : (select == 3) ? value2 : value;
    }

    Dial {
        objectName: "Dial4"
        id: dial4
        signal sendMessage(string msg)
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: 100
        height: 480
        opacity: 1.0
        value : (select == 4) ? value2 : value;
    }

    Dial {
        objectName: "Dial5"
        id: dial5
        signal sendMessage(string msg)
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: 512
        height: 480
        opacity: 1.0
        value : (select == 5) ? value2 : value;
    }

    Rectangle {
        id: container
        objectName: "FullFlexContainer"
        property int oldWidth: 0
        anchors { bottom: parent.bottom; left: parent.left
            right: parent.right; leftMargin: 20; rightMargin: 20
            bottomMargin: 10
        }
        height: 16
        radius: 8
        opacity: 0.7
        antialiasing: true
        gradient: Gradient {
            GradientStop { position: 0.0; color: "gray" }
            GradientStop { position: 1.0; color: "white" }
        }

        //onWidthChanged: {
            //if (oldWidth === 0) {
            //    oldWidth = width;
               // return
            //}

            //var desiredPercent = slider.x * 100 / (oldWidth - 32)
            //slider.x = desiredPercent * (width - 32) / 100
            //oldWidth = width
        //}

        Rectangle {
            id: slider
            objectName: "FullFlexSlider"
            x: 1; y: 1; width: 30; height: 14
            radius: 6
            antialiasing: true
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#424242" }
                GradientStop { position: 1.0; color: "red" }
            }

            MouseArea {
                anchors.fill: parent
                anchors.margins: -16 // Increase mouse area a lot outside the slider
                drag.target: parent; drag.axis: Drag.XAxis
                drag.minimumX: 2; drag.maximumX: container.width - 32
            }
        }
    }
    QuitButton {
        objectName: "FullFlexButton"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 10
    }
}
//! [0]
