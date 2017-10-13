import QtQuick 2.6
import QtQuick.Window 2.2
import org.example 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")



    ListView {
        id: view
        anchors.fill: parent
        model: DataEntryModel {}
        delegate:  Text {
            // use the defined model role "display"
            text: model.display
        }
    }
}
