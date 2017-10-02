import QtQuick 2.6

Item {
    id: root
    // export button properties
    property alias text: label.text
    signal clicked

    width: 120; height: 26

    Rectangle {
        anchors.fill: parent
        color: "lightsteelblue"
        border.color: "slategray"

        Text {
            id: label
            anchors.centerIn: parent
            text: "Start"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.clicked()
            }
        }
    }
}
