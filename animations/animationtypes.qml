// animationtypes.qml

import QtQuick 2.6

Item {
    id: root
    width: 800; height: 500

    Image {
        anchors.centerIn: parent
        source: "assets/background.png"
    }

    MouseArea {
        id: area
        anchors.fill: parent
        onClicked: {

        }
    }

    ClickableImageV2 {
        id: greenBox
        x: 40; y: root.height-height
        source: "assets/box_green.png"
        text: "Animation on property"

        NumberAnimation on y {
            to: 40; duration: 4000
        }
    }

    ClickableImageV2 {
        id: blueBox
        x: (root.width - width)/2; y: root.height-height
        source: "assets/box_blue.png"
        text: "Behavior on property"
        Behavior on y {
            NumberAnimation {duration: 4000}
        }

        onClicked: y = 40
    }

    ClickableImageV2 {
        id: redBox
        x: root.width - width - 40; y: root.height-height
        source: "assets/box_red.png"
        text: "Standalone animation"
        NumberAnimation {
            id: anim
            target: redBox
            properties: 'y'
            to: 40
            duration: 4000
            running: area.pressed
        }

        onClicked: anim.start()
    }
}

