import QtQuick
import QtQuick.Shapes
import Qt5Compat.GraphicalEffects

Item {
    id: progress
    implicitWidth: 80
    implicitHeight: 80

    // Properties
    // General
    property bool roundCap: true
    property int startAngle: -90
    property real maxValue: 100
    property real value: 50
    property int samples: 12
    // Drop Shadow
    property bool enableDropShadow: false
    property color dropShadowColor: "#ffffff"
    property int dropShadowRadius: 10
    // Bg Circle
    property color bgColor: "transparent"
    property color bgStrokeColor: "#7e7e7e"
    property int strokeBgWidth: 5
    // Progress Circle
    property color progressColor: "#ffffff"
    property int progressWidth: 5
    // Text
    property string text: "%"
    property bool textShowValue: true
    property string textFontFamily: "Segoe UI"
    property int textSize: 12
    property color textColor: "#7c7c7c"

    // Internal Properties/Functions
    QtObject{
        id: internal

        property Component dropShadow: DropShadow{
            color: progress.dropShadowColor
            fast: true
            verticalOffset: 0
            horizontalOffset: 0
            samples: progress.samples
            radius: progress.dropShadowRadius
        }
    }


    Shape{
        id: shape
        anchors.fill: parent
        layer.enabled: true
        layer.samples: progress.samples
        layer.effect: progress.enableDropShadow ? internal.dropShadow : null
        antialiasing: true
        /*ShapePath{
            id: pathBG
            strokeColor: progress.bgStrokeColor
            fillColor: progress.bgColor
            strokeWidth: progress.strokeBgWidth
            capStyle: progress.roundCap ? ShapePath.RoundCap : ShapePath.FlatCap

            PathAngleArc{
                radiusX: (progress.width / 2) - (progress.progressWidth / 2)
                radiusY: (progress.height / 2) - (progress.progressWidth / 2)
                centerX: progress.width / 2
                centerY: progress.height / 2
                startAngle: progress.startAngle
                sweepAngle: 360
            }
        }*/

        ShapePath{
            id: path
            strokeColor: progress.progressColor
            fillColor: "transparent"
            strokeWidth: progress.progressWidth
            capStyle: progress.roundCap ? ShapePath.RoundCap : ShapePath.FlatCap

            PathAngleArc{
                radiusX: (progress.width / 2) - (progress.progressWidth / 2)
                radiusY: (progress.height / 2) - (progress.progressWidth / 2)
                centerX: progress.width / 2
                centerY: progress.height / 2
                startAngle: progress.startAngle
                sweepAngle: (360 / progress.maxValue * progress.value)
            }
        }

        /*Text {
            id: textProgress
            text: progress.textShowValue ? parseInt(progress.value) + progress.text : progress.text
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: progress.textColor
            font.pointSize: progress.textSize
            font.family: progress.textFontFamily
        }*/
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:250;width:250}
}
##^##*/
