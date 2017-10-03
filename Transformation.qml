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
            rocket1.x = 84
            rocket2.rotation = 0
            rocket3.rotation = 0
            rocket3.scale = 1.0
        }
    }

    ClickableImage {
        id: rocket1
        x: 63; y: 100
        source: "assets/rocket.png"
        antialiasing: true
        onClicked: {
            x += 25
        }
    }

    ClickableImage {
        id: rocket2
        x: 264; y: 126
        source: "assets/ufo.png"
        antialiasing: true
        onClicked: {
            rotation += 15
        }
    }

    ClickableImage {
        id: rocket3
        x: 550; y: 141
        source: "assets/soccer_ball.png"
        antialiasing: true
        onClicked: {
            rotation += 15
            scale += 0.05
        }
    }

    function testTransformed()
    {
        rocket1.x += 20
        rocket2.rotation = 15
        rocket3.scale = 1.2
        rocket3.rotation = -15
    }

    function testOverlap()
    {
        rocket1.x += 40
        rocket2.rotation = 15
        rocket3.scale = 2.0
        rocket3.rotation = 45
    }


    Button {
        id: btnTestOverlap
        text: "Test Overlap"
        x:10; y: 550
        onClicked: {
            testOverlap()
        }
    }

    Button {
        id: btnTestTransformed
        text: "Test Transformed"
        x:160; y: 550
        onClicked: {
            testTransformed()
        }
    }

}

