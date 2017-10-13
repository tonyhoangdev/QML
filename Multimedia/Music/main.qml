import QtQuick 2.6
import QtMultimedia 5.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2



    Item {
        id: root
        width: 1024
        height: 600

        MediaPlayer {
            id: player
        }


        property int preIndex: 0
        property int curIndex: 0

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: progressBar.top
            anchors.margins: 100


            border.color: "#333"
            border.width: 2


            ListView {
                onCurrentItemChanged: {
                    root.preIndex = root.curIndex
                    root.curIndex = view.currentIndex
                    console.log(myModel[root.curIndex].title + ' selected')
                    console.log("curr: " + root.curIndex + " -- pre: " + root.preIndex)
                }

                id: view
                anchors.fill: parent

                anchors.margins: 2
                clip: true
                focus: true
                snapMode: ListView.SnapToItem
                boundsBehavior: Flickable.DragAndOvershootBounds


                highlight: Rectangle {
                    color: ListView.isCurrentItem?"#333": "555"
                }

                delegate: numberDelegate
                model: myModel

//                delegate: Rectangle {
//                    height: 25
//                    width: 100
//                    Text {
//                        text: model.modelData.showButton + " - " + model.modelData.title
//                    }
//                }

            }
        }

        Component {
            id: numberDelegate

            SwipeDelegate {
                id: swipeDelegate
                text: title + " - " + time
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
                    source: 'play.png'
                    anchors.left: parent.left
                    anchors.top: parent. top

                    MouseArea {
                        property bool isCurrPlay: false
                        property bool isPrePlay: false

                        anchors.fill: parent
                        onClicked: {
                            console.log("Image clicked: " + index)
                            view.currentIndex = index
                            view.focus = true
                            player.source = myModel[view.currentIndex].fileName

                            isCurrPlay = !isCurrPlay

                            console.log ("image curr " + index + " play: " + isCurrPlay)

                            if (isCurrPlay) {
                                icon.source = 'pause.png';
                                root.state = 'pause';
                                player.play();
                            } else {
                                icon.source = 'play.png';
                                root.state = 'play';
                                player.pause();
                            }

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
                        if (!icon.isCurrPlay) {
                            //view.model.remove(index)
                            myModel[index].deleteRow(index)
                            console.log("Deleted - " + myModel[root.curIndex].title)
                        } else {
                            console.log("Cannot delete - " + myModel[root.curIndex].title)
                        }
                    }

                    background: Rectangle {
                        color: deleteLabel.SwipeDelegate.pressed ? Qt.darker("tomato", 1.1) : "tomato"
                    }
                }
            }

            // Thumbnail {
            //     id: thumbnail
            //     width: view.width
            //     text: title
            //     iconSource: source
            //     color: ListView.isCurrentItem?"#444":"#222"
            //     isShowButton: show_button

            //     onClicked: {
            //         root.preIndex = root.curIndex
            //         root.curIndex = index
            //         view.currentIndex = index
            //         myModel.get(root.preIndex).show_button = false
            //     }

            //     onPressAndHold: {
            //         view.currentIndex = index
            //         root.curIndex = view.currentIndex
            //         myModel.get(root.curIndex).show_button = true
            //     }

            //     onReleased: {

            //     }

            //     onRemoveClicked: {
            //         console.log("Removed.. " + view.currentIndex)
            //         myModel.remove(view.currentIndex)
            //     }

            //     onDeleteClicked: {
            //         console.log("Deleted.. " + view.currentIndex)
            //         myModel.remove(view.currentIndex)
            //     }
            // }

        }

        Component.onCompleted: {
            //player.play()
        }


        // Text {
        //         id: txtStart
        //         text: '0'
        //         color: "#333"
        //         anchors.left: parent.left
        //         anchors.bottom: parent.bottom
        //         width: 20
        //         anchors.margins: 100
        //         font.pixelSize: 20
        //     }


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

        state: 'play'
        states: [
            State {
                name: "play"
                PropertyChanges { target: imagePlay; source: "play.png"}

            },
            State {
                name: "pause"
                PropertyChanges {target: imagePlay; source: "pause.png"}
            }
        ]

        Rectangle {
            id: play
            width: 100
            height: 100

            anchors.top: progressBar.bottom
            anchors.left: parent.left
            anchors.leftMargin: 100

            Image {
                id: imagePlay
                anchors.fill: parent
                source: "play.png"
            }

            MouseArea {
                id: mousePlay
                anchors.fill: parent
                onClicked: {
                    player.source = myModel[view.currentIndex].fileName
                    if (root.state == 'play') {
                        root.state = 'pause';
                        player.play();
                    } else {
                        root.state = 'play';
                        player.pause();
                    }
                    console.log("======================")
                    console.log(view.currentIndex)
                }
            }

        }

        Connections {
            target: player
            onMediaObjectChanged: {
                if (player.mediaObject) {
                    player.mediaObject.notifyInterval = 50;
                }
            }
        }
    }


