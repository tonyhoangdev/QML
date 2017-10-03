// grid.qml

import QtQuick 2.6

BrightSquare {
    id: root
    width: 400
    height: 400

    Grid {
        id: grid
        rows: 2
        columns: 2
        anchors.centerIn: parent
        spacing: 10
        RedSquare { }
        GreenSquare { }
        BlueSquare { }
        BlueSquare { }
    }
}
