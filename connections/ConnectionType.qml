// ConnectionType.qml

import QtQuick 2.6

Rectangle {
    id: rect
    width: 500
    height: 500
    color: "transparent"

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onPressedChanged: {
            console.log("Mouse area is pressed?", pressed)
        }
    }

    Connections {
        target: mouseArea
        property int val: 0
        onClicked: {
            val += 1
            if (val == 1)
                rect.color = 'red'
            else if (val == 2)
                rect.color = 'blue'
            else if (val == 3)
                rect.color = 'green'
            else if (val == 4)
                rect.color = 'yellow'
            else {
                val = 1
                rect.color = 'red'
            }
            console.log("Clicked mouse at", mouse.x, mouse.y)
        }
    }

    Component.onCompleted: {
        console.log("The rectangle's color is ", color)
    }

    SquareButton {
        id: square1
        x: 40; y: 40
        color: "#113344"

        onActivated: console.log("Activated at " + xPosition + ", " + yPosition)
    }

    Rectangle {
        id: relay

    }
}
