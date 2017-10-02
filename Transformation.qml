// Transformation.qml

import QtQuick 2.6

Item {
    // Set width based on given background
    width: bg.width
    height: bg.height

    Image {
        id: bg
        source: "assets/background.png"
    }

    MouseArea {
        id: backgroundClicker
        anchors.fill: parent

        onClicked: {

        }
    }

    ClickableImage {
        id: rocket1
        x: 20; y: 100
        source: "assets/rocket.jpg"
        onClicked: {
            x += 5
        }
    }
}

