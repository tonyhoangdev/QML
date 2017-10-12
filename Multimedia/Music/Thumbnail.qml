import QtQuick 2.0

Rectangle {
    id: root
    width: 480
    height: 64
    color: '#333'
    border.color: '#666'

    property alias text: label.text
    property alias iconSource: icon.source

    property alias btnRemoveVisible: rect1.visible
    property alias btnRemoveWidth: rect1.width

    property alias btnDeleteVisible: rect2.visible
    property alias btnDeleteWidth: rect2.width

    property bool isShowButton: false

    signal clicked()
    signal pressAndHold()
    signal released()

    signal imageClicked()
    signal removeClicked()
    signal deleteClicked()


    Row {
        id: row
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 2

        Image {
            id: icon
            width: height; height: parent.height
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            source: 'play.png'

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    icon.imageClicked
                    console.log("Image clicked")
                }
            }
        }

        Rectangle {
            id: rectText
            height: parent.height
            anchors.right: rect1.left
            anchors.left: icon.right
            color: root.color
            anchors.margins: 8

            Text {
                id: label
                anchors.verticalCenter: parent.verticalCenter
                color: '#fff'
                font.pixelSize: 18
                elide: Text.ElideRight

            }


            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log ("clicked")
                    root.clicked()
                    isShowButton = false
                }

                onPressAndHold: {
                    root.pressAndHold()
                    duration: 500
                    isShowButton = true
                }

                onReleased: {
                    root.released();
                }
            }
        }


        Rectangle {
            id: rect1
            visible: false
            width: 0
            height: root.height

            color: "green"
            anchors.right: rect2.left

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.centerIn: parent
                text: "Remove"
                color: "#fff"
                font.pixelSize: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.removeClicked()
                    console.log("Remove clicked")
                }

            }
        }

        Rectangle {
            id: rect2
            visible: false
            width: 0
            height: root.height

            color: "blue"
            anchors.right: parent.right

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.centerIn: parent
                text: "Delete"
                color: "#fff"
                font.pixelSize: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.deleteClicked()
                    console.log("Delete clicked")
                }
            }
        }
    }

    state: "show-button"
    states: [
        State {
            name: "show-button"; when: isShowButton==true
            PropertyChanges {target: rect1; width: 100; visible: true}
            PropertyChanges {target: rect2; width: 100; visible: true}
        },
        State {
            name: 'hidden-button'; when: isShowButton==false
            PropertyChanges {target: rect1; width: 0; visible: false}
            PropertyChanges {target: rect2; width: 0; visible: false}
        }
    ]

    transitions: [
        Transition {
            //from: "show-button"; to: "hidden-button"
            //PropertyAction {target: rect1; properties: "visible";}
            //NumberAnimation {target: rect1; property: "visible"; from: true; to: false; duration: 250; easing.type: Easing.InOutQuad}
            //PropertyAction {target: rect2; to: false; properties: "visible"; duration: 2000}
        }
    ]
}
