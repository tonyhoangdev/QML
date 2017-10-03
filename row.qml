// row.qml

import QtQuick 2.6

BrightSquare {
    id: root
    width: 400
    height: 140

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 20
        RedSquare { }
        GreenSquare { width: 96 }
        BlueSquare { }
    }
}
