// main.qml

import QtQuick 2.6

Rectangle {
    id: root

    width: 600
    height: 400

    property int speed: 0

    SequentialAnimation {
        running: true
        loops: Animation.Infinite

        NumberAnimation { target: root; property: 'speed'; to: 250; easing.type: Easing.InOutQuad; duration: 4000 }
        NumberAnimation { target: root; property: 'speed'; to: 20; easing.type: Easing.InOutQuad; duration: 2000 }
    }

    Loader {
        id: dialLoader
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: analogButton.top

        onLoaded: {
            binder.target = dialLoader.item
        }
    }

    Binding {
        id: binder
        property: "speed"
        value: speed
    }

    Rectangle {
        id: analogButton
        width: parent.width/2
        height: 100
        color: "gray"

        anchors.left: parent.left
        anchors.bottom: parent.bottom

        Text {
            anchors.centerIn: parent
            text: "Analog"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: root.state = "analog"
        }
    }

    Rectangle {
        id: digitalButton
        width: parent.width/2
        height: 100
        color: "gray"

        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Text {
            anchors.centerIn: parent
            text: "Digital"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: root.state = "digital"
        }
    }

    state: "analog"
    states: [
        State {
            name: "analog"
            PropertyChanges { target: analogButton; color: 'green' }
            PropertyChanges { target: dialLoader; source: "Analog.qml" }
        },
        State {
            name: "digital"
            PropertyChanges { target: digitalButton; color: 'green' }
            PropertyChanges { target: dialLoader; source: "Digital.qml"}

        }
    ]
}
