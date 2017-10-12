import QtQuick 2.6
import QtMultimedia 5.6
import QtQuick.Window 2.2

Window {
    visible: true
    width: 1024
    height: 640
    title: qsTr("Music")



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
                    console.log(theModel.get(root.curIndex).title + ' selected')
                    console.log("curr: " + root.curIndex + " -- pre: " + root.preIndex)
                    theModel.get(root.preIndex).show_button = false
                    theModel.sync()
                }

                id: view
                anchors.fill: parent

                anchors.margins: 2
                clip: true
                focus: true
                snapMode: ListView.SnapToItem
                boundsBehavior: Flickable.DragAndOvershootBounds

                model: theModel
                delegate: numberDelegate
            }
        }

        ListModel {
            id: theModel

            ListElement {show_button: false; title: "Anh Tin Mình Đã Cho Nhau Một Kỷ Niệm (Prod.by Pharreal Phương, DSmall)";  isPlay: false; source: "play.png"; time: "01:24"; fileName: "http://10.218.141.171:8081/Anh-Tin-Minh-Da-Cho-Nhau-Mot-Ky-Niem-Prod-by-Pharreal-Phuong-DSmall-Yanbi-Yen-Le.mp3"}
            ListElement {show_button: true; title: "Là Con Gái Phải Xinh";  isPlay: true;  source: "play.png"; time: "02:50"; fileName: "http://10.218.141.171:8081/La-Con-Gai-Phai-Xinh-Bao-Thy-Kimmese.mp3"}
            ListElement {show_button: false; title: "Xin Anh Đừng";  isPlay: false; source: "play.png"; time: "01:24"; fileName: "http://10.218.141.171:8081/Xin-Anh-Dung-Dong-Nhi.mp3"}
            ListElement {show_button: true; title: "On Top (Remix)";  isPlay: false; source: "play.png"; time: "01:24"; fileName: "http://10.218.141.171:8081/On-Top-Remix-Dong-Nhi-Lip-B.mp3"}
            ListElement {show_button: false; title: "Make Yourself";  isPlay: false; source: "play.png"; time: "01:24"; fileName: "http://10.218.141.171:8081/Make-Yourself-Duong-Tran-Nghia.mp3"}
            ListElement {show_button: false; title: "Cuối Cùng Anh Cũng Đến";  isPlay: false; source: "play.png"; time: "01:24"; fileName: "http://10.218.141.171:8081/Cuoi-Cung-Anh-Cung-Den-Hari-Won.mp3"}
            ListElement {show_button: false; title: "Quăng Tao Cái Boongt (Masew Remix)";  isPlay: false; source: "play.png"; time: "01:24"; fileName: "http://10.218.141.171:8081/Quang-Tao-Cai-Boong-Masew-Remix-Huynh-James-Pjnboys.mp3"}
            ListElement {show_button: false; title: "Anh Sẽ Luôn Thật Gần";  isPlay: false; source: "play.png"; time: "01:24"; fileName: "http://10.218.141.171:8081/Anh-Se-Luon-That-Gan-Khac-Hung.mp3"}
            ListElement {show_button: false; title: "Love You Want You (Remix)";  isPlay: false; source: "play.png"; time: "01:24"; fileName: "http://10.218.141.171:8081/Love-You-Want-You-Remix-Lip-B.mp3"}
            ListElement {show_button: false; title: "Mình Là Gì Của Nhau (Future Bass Remix)";  isPlay: false; source: "play.png"; time: "01:24"; fileName: "http://10.218.141.171:8081/Minh-La-Gi-Cua-Nhau-Future-Bass-Remix-Lou-Hoang.mp3"}
            ListElement {show_button: false; title: "Lạc Trôi (Masew Trap Remix)"; isPlay: false; source: "play.png"; time: "01:24"; fileName: "http://10.218.141.171:8081/Lac-Troi-Masew-Trap-Remix-Son-Tung-M-TP.mp3"}
        }



        Component {
            id: numberDelegate

            Thumbnail {
                id: thumbnail
                width: view.width
                text: title
                iconSource: source
                color: ListView.isCurrentItem?"#444":"#222"
                isShowButton: show_button




                onClicked: {
                    root.preIndex = root.curIndex
                    root.curIndex = index
                    view.currentIndex = index
                    theModel.get(root.preIndex).show_button = false
                }

                onPressAndHold: {
                    view.currentIndex = index
                    root.curIndex = view.currentIndex
                    theModel.get(root.curIndex).show_button = true
                }

                onReleased: {

                }

                onRemoveClicked: {
                    console.log("Removed.. " + view.currentIndex)
                    theModel.remove(view.currentIndex)
                }

                onDeleteClicked: {
                    console.log("Deleted.. " + view.currentIndex)
                    theModel.remove(view.currentIndex)
                }
            }

        }

        Component.onCompleted: {
            //player.play()
        }

        Rectangle {
            id: progressBar

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 100

            height: 30
            color: "lightGray"

            Rectangle {
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
                    player.source = theModel.get(view.currentIndex).fileName
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

}
