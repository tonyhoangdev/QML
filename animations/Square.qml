// Square.qml

import QtQuick 2.6

Rectangle {
    property alias text: label.text
    width: 96
    height: width
    border.color: Qt.lighter(color)

    Text {
        id: label
        anchors.centerIn: parent
        color: "#f0f0f0"
    }

    MouseArea {
        anchors.fill: parent
        drag.target: parent
    }
}
