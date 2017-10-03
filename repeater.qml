// repeater.qml

import QtQuick 2.6

DarkSquare {
    id: root
    width: 450
    height: 450
    property variant colorArray: ["#00bde3", "#67c111", "#ea7025"]

    Grid {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 4
        Repeater {
            model: 16
            Rectangle {
                width: 100; height: 100
                property int colorIndex: Math.floor(Math.random() * 3)
                color: root.colorArray[colorIndex]
                border.color: Qt.lighter(color)
                Text {
                    anchors.centerIn: parent
                    color: "#f0f0f0"
                    text: "Cell " + index
                }
            }
        }
    }
}
