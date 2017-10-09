// DynamicViewList.qml

import QtQuick 2.6
import "./common"

Background {
    width: 80
    height: 300

    ListView {
        anchors.fill: parent
        anchors.margins: 20
        clip: true
        model: 100
        delegate: numberDelegate
        spacing: 5
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.NoSnap
        orientation: ListView.Vertical

        focus: true
        highlight: highlightComponent
    }

    Component {
        id: highlightComponent

        Item {
            width: ListView.view.width
            height: ListView.view.currentItem.height
            y: ListView.view.currentItem.y

            Behavior on y {
                SequentialAnimation {
                    PropertyAnimation {
                        target: highlightRectangle
                        property: "opacity"
                        to: 0
                        duration: 200
                    }

                    NumberAnimation {
                        duration: 1
                    }

                    PropertyAnimation {
                        target: highlightRectangle
                        property: "opacity"
                        to: 1
                        duration: 200
                    }
                }
            }

            GreenBox {
                id: highlightRectangle
                anchors.fill: parent
            }
        }
    }

    Component {
        id: numberDelegate

        Item {
            width: ListView.view.width
            height: 40

            Text {
                anchors.centerIn: parent
                font.pixelSize: 10
                text: index
            }
        }
    }
}
