import QtQuick 2.6
import QtQuick.Window 2.2
import org.example 1.0
import QtQuick.Controls 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ListView {
        id: view
        anchors.fill: parent
        focus: true
        model: RoleEntryModel {}
        delegate:  Rectangle  {
            // use the defined model role "display"
            width: parent.width
            height: 32
            color: model.name
            Text {
                anchors.fill: parent
                text: 'hsv(' + Number(model.hue).toFixed(2) + ',' + Number(model.saturation).toFixed() + ',' + Number(model.brightness).toFixed() +")"
            }

        }


        highlight: Rectangle {
            color: ListView.isCurrentItem?"#333": "555"
        }
    }
}
