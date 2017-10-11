import QtQuick 2.6

Item {
    id: root
    width: 1024
    height: 600

    function createItem() {
        var item1 = Qt.createQmlObject("import QtQuick 2.5; Rectangle {x: 100; y: 100; width: 100; height: 100; color: 'green'}", root, "dynamicItem")
        item1.destroy();
    }

    Component.onCompleted: root.createItem();
}
