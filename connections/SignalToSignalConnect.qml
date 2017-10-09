import QtQuick 2.6

Rectangle {
    id: forwarder
    width: 100; height: 100

    signal send()
    onSend: console.log("Send clicked 2")

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: console.log("MouseArea onClicked")
    }

    Component.onCompleted: {
        mouseArea.clicked.connect(send)
    }

}
