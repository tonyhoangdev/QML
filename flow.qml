// flow.qml

import QtQuick 2.6

BrightSquare {
    id: root
    width: 400
    height: 400

    Flow {
        id: flow
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10
        RedSquare {
            width: 100
            height: 100
        }
        GreenSquare {
            width: 100
            height: 100
        }
        BlueSquare {
            width: 100
            height: 100
        }
        BlueSquare {
            width: 100
            height: 100
        }
    }
}
