// parallelanimation.qml

import QtQuick 2.6

BrightSquare {
    id: root
    width: 600
    height: 400

    property int duration: 3000
    property Item ufo: ufo

    Image {
        anchors.fill: parent
        source: "assets/ufo_background.png"
    }

    ClickableImageV3 {
        id: ufo
        x: 20; y: root.height-height
        text: 'ufo'
        source: 'assets/ufo.png'
        onClicked: anim.restart()
    }

    SequentialAnimation {
        id: anim
        NumberAnimation {
            target: ufo
            properties: 'y'
            to: 20
            duration: root.duration
        }
        NumberAnimation {
            target: ufo
            properties: 'x'
            to: 400
            duration: root.duration
        }
    }

}
