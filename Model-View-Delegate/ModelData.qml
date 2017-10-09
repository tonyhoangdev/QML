// ModelData.qml

import QtQuick 2.6
import "./common"

Column {
    spacing: 2

    Repeater {
        model: ['Enterprise', 'Columbia', 'Challenger', 'Discovery', 'Endeavour', 'Atlantis']

        BlueBox {
            width: 120
            height: 32
            radius: 4
            text: modelData + ' (' + index + ')'
        }
    }
}

