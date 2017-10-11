import QtQuick 2.6

Rectangle {
    width: 400
    height: 225
    border.color: 'red'
    border.width: 4

    Image {
        anchors.fill: parent
        anchors.margins: 4

        source: "image1.png"

        Image {
            id: overlay

            anchors.fill: parent

            source: "image2.png"

            opacity: 0;
            Behavior on opacity { NumberAnimation { duration: 300 } }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (overlay.opacity === 0)
                    overlay.opacity = 1;
                else
                    overlay.opacity = 0;
            }
        }
    }
}

