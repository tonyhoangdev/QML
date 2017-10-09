// ModelIndex.qml

import QtQuick 2.6
import "./common"

Column {
    spacing: 2

    Repeater {
        model: 10
        BlueBox {
            width: 120
            height: 32
            text: index
        }
    }
}

