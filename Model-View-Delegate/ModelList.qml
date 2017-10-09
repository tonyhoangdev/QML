// ModelList.qml

import QtQuick 2.6
import "./common"

Column {
    spacing: 2

    Repeater {
        model: ListModel {
            ListElement {name: 'Minh'; surfaceColor: 'gray'}
            ListElement {name: 'Minh'; surfaceColor: 'yellow'}
            ListElement {name: 'Minh'; surfaceColor: 'blue'}
            ListElement {name: 'Minh'; surfaceColor: 'orange'}
            ListElement {name: 'Minh'; surfaceColor: 'lightBlue'}
            ListElement {name: 'Minh'; surfaceColor: 'blue'}
            ListElement {name: 'Minh'; surfaceColor: 'orange'}
            ListElement {name: 'Minh'; surfaceColor: 'gray'}
        }

        BlueBox {
            width: 120
            height: 32
            radius: 4
            text: name

            Box {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 4

                width: 16
                height: 16
                radius: 8
                color: surfaceColor

            }
        }
    }
}

