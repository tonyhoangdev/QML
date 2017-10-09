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
        orientation: ListView.Horizontal
    }

    Component {
        id: numberDelegate

        GreenBox {
            width: 40
            height: 40
            text: index
        }
    }
}
