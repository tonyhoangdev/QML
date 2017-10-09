// DynamicViewGrid.qml

import QtQuick 2.6
import "./common"

Background {
    width: 220
    height: 300

    GridView {
        id: view
        anchors.fill: parent
        anchors.margins: 20

        clip: true
        model: 100
        cellWidth: 60
        cellHeight: 60
        delegate: numberDelegate

        flow: GridView.TopToBottom
    }

    Component {
        id: numberDelegate

        GreenBox {
            width: 55
            height: 55
            text: index
        }
    }
}
