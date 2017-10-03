import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    visible: true
    width: 720
    height: 640
    title: qsTr("Hello World")

    Timer {
        interval: 2000; running: true; repeat: true
        onTriggered: status.text = Date().toString()
    }

    Button {
        id: button1
        x: 50; y: 50
        text: "Start 1"
        onClicked: {
            status.text = "Button clicked!"
        }
    }

    Button {
        id: button2
        x: 190; y: 50
        text: "Start 2"
        onClicked: {
            status.text = "Button 2 clicked!"
        }
    }

    Rectangle {
        id: rect1
        x: 50; y: 100
        width: 90; height: 100
        color:  "lightsteelblue"
        MouseArea {
            id: area
            anchors.fill: parent
            //            onClicked: rect3.visible = !rect3.visible
            onClicked: rect3.rotation += 90
        }
    }

    Rectangle {
        id: rect2
        x: 50; y: 220
        width: 90; height: 100
        color: "#102012"
        border.color: "lightsteelblue"
        border.width: 4
        radius: 8
        MouseArea {
            anchors.fill: parent
            onClicked: rect4.rotation += 90
        }
    }

    Rectangle {
        id: rect22
        x: 50; y: 340
        width: 90; height: 100
        border.color: "slategray"
        gradient: Gradient {
            GradientStop {position:  0.0; color: "lightsteelblue"}
            GradientStop {position:  1.0; color: "slategray"}
        }
    }

    Text {
        id: txt2
        x: 160; y: 100
        width: 150; height: 300
        text: "Text box 2 sdf asdf asdf asd asd sdf asdf asd fasdf asdf sadf f"
        font.pixelSize: 30
        font.family: "Ubuntu"
        color: "#0000FF"
        style: Text.Sunken
        styleColor: '#FF4444'
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        elide: Text.ElideLeft
        wrapMode: Text.WordWrap
    }

    Text {
        // 1) Identifier
        id: status

        // 2) Set x and y position
        x: 10; y:10

        // 3) Bind height to 2 * width
        height: 2*width

        // 4) Custom property
        property int times: 24
        property int spacePresses: 0

        // 5) Property alias
        property alias anotherTimes: status.times

        // 6) Set text appended by value
        text: "Space pressed: " + spacePresses + " times"

        // 7) Font is a grouped property
        font.family: "Ubuntu"
        font.pixelSize: 30

        // 8) KeyNavigation is an attached property
        // KeyNavigation.tab: otherLabel

        // 9) Signal handler for property changes
        onHeightChanged: console.log('height: ', height)
        onTextChanged: console.log('text changed to: ', text)

        // 10) Focus is need to receive key events
        focus: true

        // 11) Change color based on focus value
        color: focus?"red":"black"

        // 12) Handler with some JS
        Keys.onSpacePressed: {
            increment()
        }

        // clear the text on escape
        Keys.onEscapePressed: {
            status.text = ''
        }

        // a JS function
        function increment() {
            spacePresses = spacePresses + 1
            text = "Space pressed: " + spacePresses + " times"
        }

        Keys.onDigit1Pressed: {
            rect3.rotation += 90
        }

        Keys.onDigit2Pressed: {
            rect4.rotation += 90
        }
    }

    Rectangle {
        id: rect3
        x: 320; y: 50
        width: 300; height: 300
        border.color: "lightsteelblue"
        border.width: 4
        radius: 8

        Behavior on rotation {
            NumberAnimation {
                duration: 250
            }
        }

        Image {
            x: 10; y: 10
            width: 50; height: 100
            source: "assets/img1.jpg"
            fillMode: Image.PreserveAspectCrop
            clip: false

        }
    }

    Rectangle {
        id: rect4
        x: 900; y: 50
        width: 300; height: 300
        border.color: "lightsteelblue"
        border.width: 4
        radius: 8

        Behavior on rotation {
            NumberAnimation {
                duration: 200
            }
        }

        Image {
            anchors.fill: parent
            x: 10; y: 10
            source: "assets/img1.jpg"
            fillMode: Image.PreserveAspectCrop
            clip: true

        }
    }


//    Transformation {

//    }

}
