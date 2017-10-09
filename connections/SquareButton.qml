import QtQuick 2.6

Rectangle {
    id: rect2
    signal activated(real xPosition, real yPosition)

    property int side: 100
    width: side; height: side

    MouseArea {
        anchors.fill: parent
        onPressed: rect2.activated(mouse.x, mouse.y)
    }
}
