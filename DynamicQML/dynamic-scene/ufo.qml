
import QtQuick 2.6

Image {
    source: "ufo.png"

    MouseArea {
        anchors.fill: parent

        drag.target: parent
        drag.axis: Drag.XandYAxis
    }
}
