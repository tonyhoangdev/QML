
import QtQuick 2.6

Item {
    property int speed: 45

    Text {
        id: text
        anchors.centerIn: parent
        font.pixelSize: parent.height*0.4
        text: speed + " kph"
    }
}
