// animation.qml

import QtQuick 2.6

Image {
    id: root
    source: "assets/background.png"

    property int padding: 40
    property int duration: 360000
    property int rotation: 648000
    property bool running: false

    Keys.onPressed: {
        switch(event.key) {
            case Qt.Key_Plus:
                box.scale += 0.2
                break;
            case Qt.Key_Minus:
                box.scale -= 0.2
                break
        }
    }

    Image {
        id: box
        x: root.padding
        y: (root.height-height)/2
        source: "assets/box_green.png"

        NumberAnimation on x {
            to: root.width - box.width - root.padding
            duration: root.duration
            running: root.running
        }
        RotationAnimation on rotation {
            to: root.rotation
            duration: root.duration
            running: root.running
        }
    }

    Image {
        id: box1
        x: root.padding
        y: (root.height-height)/2 - 50
        source: "assets/box_green.png"

        NumberAnimation on x {
            to: root.width - box1.width - root.padding
            duration: root.duration / 2
            running: root.running
        }
        RotationAnimation on rotation {
            to: root.rotation
            duration: root.duration
            running: root.running
        }
    }

    Image {
        id: box2
        x: root.padding
        y: (root.height-height)/2 + 50
        source: "assets/box_green.png"

        NumberAnimation on x {
            to: root.width - box2.width - root.padding
            duration: root.duration / 4
            running: root.running
        }
        RotationAnimation on rotation {
            to: root.rotation
            duration: root.duration
            running: root.running
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.running = true
    }
}
