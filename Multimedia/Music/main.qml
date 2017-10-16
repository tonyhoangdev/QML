import QtQuick 2.6
import QtMultimedia 5.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import my.lib 1.0

Item {
    id: root
    width: 1024
    height: 600

    MediaPlayer {
        id: player
    }

    property int preIndex: 0
    property int curIndex: 0
    property int indexPlay: 0

    Rectangle {
        anchors.rightMargin: 500
        anchors.topMargin: 100
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: progressBar.top
        anchors.margins: 100

        border.color: "#333"
        border.width: 2

        GroupBox {
            id: groupBox
            padding: 10
            font.pointSize: 13
            anchors.fill: parent
            title: qsTr("List")

            ListView {
                onCurrentItemChanged: {
                    root.preIndex = root.curIndex
                    root.curIndex = view.currentIndex
                    console.log(myModel.get(root.curIndex).title + ' selected')
                    console.log("curr: " + root.curIndex + " -- pre: " + root.preIndex)
                    console.log("Index is playing: " +  root.indexPlay);
                }

                id: view
                anchors.fill: parent
                clip: true
                focus: true
                snapMode: ListView.SnapToItem
                boundsBehavior: Flickable.DragAndOvershootBounds

                highlight: Rectangle {
                    color: ListView.isCurrentItem?"#333": "555"
                }

                delegate: numberDelegate
                model: myModel
            }
        }
    }

    Component {
        id: numberDelegate

        SwipeDelegate {
            id: swipeDelegate
            text: model.title
            width: parent.width
            leftPadding: icon.height + 2
            hoverEnabled: true

            onClicked: {
                console.log("Swipe clicked")
                view.currentIndex = index
            }

            Image {
                id: icon
                width: height; height: parent.height
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                source: model.source;
                anchors.left: parent.left
                anchors.top: parent. top

                MouseArea {
                    property bool isCurrPlay: false

                    anchors.fill: parent
                    onClicked: {
                        console.log("Image clicked: " + index)
                        view.currentIndex = index
                        view.focus = true
                        isCurrPlay = !myModel.get(index).isPlay

                        player.source = myModel.get(index).fileName
                        myModel.get(index).setIsPlay(isCurrPlay)
                        myModel.refreshRow(index);

                        if (myModel.get(index).isPlay && (index != root.indexPlay)) {
                            myModel.get(root.indexPlay).setIsPlay(false);
                            myModel.refreshRow(root.indexPlay);
                            root.indexPlay = index;
                        } else {
                            root.indexPlay = index;
                        }

                        if (myModel.get(index).isPlay) {
                            player.play();
                        } else {
                            player.pause();
                        }

                        console.log ("image curr " + index + " play: " + isCurrPlay)

                    }
                }
            }

            ListView.onRemove: SequentialAnimation {
                PropertyAction {
                    target: swipeDelegate
                    property: "ListView.delayRemove"
                    value: true
                }
                NumberAnimation {
                    target: swipeDelegate
                    property: "height"
                    to: 0
                    easing.type: Easing.InOutQuad
                }
                PropertyAction {
                    target: swipeDelegate;
                    property: "ListView.delayRemove";
                    value: false
                }
            }

            swipe.transition: Transition {
                SmoothedAnimation { velocity: 3; easing.type: Easing.InOutCubic }
            }

            swipe.right: Label {
                id: deleteLabel
                text: "Delete"
                color: "white"
                verticalAlignment: Label.AlignVCenter
                padding: 12
                height: parent.height
                anchors.right: parent.right

                SwipeDelegate.onClicked: {
                    if (!myModel.get(index).isPlay) {
                        console.log("Deleted - " + myModel.get(index).title)
                        if (index < root.indexPlay) {
                            root.indexPlay = root.indexPlay - 1
                        }
                        myModel.deleteRow(index)
                    } else {
                        console.log("Cannot delete - " + myModel.get(index).title)
                    }
                }

                background: Rectangle {
                    color: deleteLabel.SwipeDelegate.pressed ? Qt.darker("tomato", 1.1) : "tomato"
                }
            }
        }
    }

    Component.onCompleted: {
        //player.play()
    }

    Rectangle {
        id: progressBar

        anchors.top: view.bottom
        anchors.left: root.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 100

        height: 30
        color: "lightGray"

        Rectangle {
            id: rectMid
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            width: player.duration>0?parent.width*player.position/player.duration:0

            color: "darkGray"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (player.seekable) {
                    player.position = player.duration * mouse.x/width;
                }
            }
        }
    }


//    Rectangle {
//        id: play
//        width: 100
//        height: 100

//        anchors.top: progressBar.bottom
//        anchors.left: parent.left
//        anchors.leftMargin: 100

//        Image {
//            id: imagePlay
//            anchors.fill: parent
//            source: myModel.get(root.indexPlay).source
//        }

//        MouseArea {
//            id: mousePlay
//            anchors.fill: parent
//            onClicked: {
//                player.source = myModel.get(root.indexPlay).fileName
//                imagePlay.source = myModel.get(root.indexPlay).source
//                myModel.get(root.indexPlay).setIsPlay(!myModel.get(root.indexPlay).isPlay)
//                myModel.refreshRow(root.indexPlay);
//                if (myModel.get(root.indexPlay).isPlay) {
//                    player.play();
//                } else {
//                    player.pause();
//                }
//                console.log("======================")
//                console.log(root.indexPlay)
//            }
//        }

//    }

    Connections {
        target: player
        onMediaObjectChanged: {
            if (player.mediaObject) {
                player.mediaObject.notifyInterval = 50;
            }
        }
    }

//    Rectangle {
//        x: -4
//        y: 2
//        anchors.bottomMargin: 100
//        anchors.leftMargin: 549
//        anchors.bottom: progressBar.top
//        ListView {
//            id: view1
//            highlight: Rectangle {
//                color: ListView.isCurrentItem?"#333": "555"
//            }
//            boundsBehavior: Flickable.DragAndOvershootBounds
//            snapMode: ListView.SnapToItem
//            anchors.fill: parent
//            anchors.margins: 2
//            clip: true
//            delegate: numberDelegate
//            model: myModel
//            focus: true
//        }
//        anchors.right: parent.right
//        anchors.rightMargin: 51
//        border.color: "#333333"
//        anchors.margins: 100
//        anchors.topMargin: 62
//        border.width: 2
//        anchors.top: parent.top
//        anchors.left: parent.left
//    }

    Text {
        id: txtTime
        x: 100
        y: 436
        width: 77
        height: 28
        text: qsTr("Playing: " + (myModel.get(root.indexPlay).isPlay ? myModel.get(root.indexPlay).title : "None"))
        anchors.bottom: progressBar.top
        anchors.bottomMargin: 0
        topPadding: -2
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        elide: Text.ElideNone
        font.pixelSize: 12
    }

    Label {
        id: lblPath
        x: 8
        y: 8
        width: 50
        height: 26
        text: qsTr("Path:")
        font.pointSize: 14
    }

    Rectangle {
        id: rectangle
        x: 64
        y: 11
        width: 500
        height: 26
        border.width: 1

        TextInput {
            anchors.fill: parent
            anchors.margins: 1
            id: txtPath
            objectName : "txtPath"
            text: qsTr("")

            font.pixelSize: 13
            font.family: "Verdana"
        }
    }

    signal send(string msg)

    Button {
        id: button
        x: 8
        y: 40
        text: qsTr("Scan")

        onClicked: {
            send(txtPath.text)
        }

    }
}


