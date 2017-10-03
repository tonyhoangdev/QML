// layout.qml

import QtQuick 2.6

DarkSquare {
    id: root
    width: 400
    height: 400

    Flow {
        id: flow
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        // Fills a parent element
        GreenSquare {
            BlueSquare {
                width: 12
                anchors.fill: parent
                anchors.margins: 8
                text: '(1)'
            }
        }

        // Left aligned
        GreenSquare {
            BlueSquare {
                width: 48
                y: 10
                anchors.left: parent.left
                anchors.leftMargin: 8
                text: '(2)'
            }
        }

        // left side is aligned to the parents right side
        GreenSquare {
            BlueSquare {
                width: 48
                anchors.left: parent.right
                text: '(3)'
            }
        }

        // Center aligned elements.
        GreenSquare {
            BlueSquare {
                id: blue1
                width: 48; height:24
                y: 8
            }

            BlueSquare {
                id: blue2
                width: 72; height: 24
                anchors.top: blue1.bottom
                anchors.topMargin: 4
                anchors.horizontalCenter: blue1.horizontalCenter
                text: '(4)'
            }
        }

        // Center
        GreenSquare {
            BlueSquare {
                width: 48
                anchors.centerIn: parent
                text: '(5)'
            }
        }

        // Center
        GreenSquare {
            BlueSquare {
                width: 48
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -12
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 12
                text: '(6)'
            }
        }
    }
}
