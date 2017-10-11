import QtQuick 2.6
import "create-component.js" as ImageCreator

Item {
    id: root
    width: 1024
    height: 600

    Component.onCompleted: ImageCreator.createImageObject();
}
