
import QtQuick 2.6
import QtQuick.XmlListModel 2.0
import "create-object.js" as CreateObject

Item {
    id: root
    width: 1024
    height: 600

    ListModel {
        id: objectsModel
    }

    function addUfo() {
        CreateObject.create("ufo.qml", root, itemAdded);
    }

    function addRocket() {
        CreateObject.create("rocket.qml", root, itemAdded);
    }

    function itemAdded(obj, source) {
        objectsModel.append({"obj": obj, "source": source})
    }

    function clearItems() {
        while(objectsModel.count > 0) {
            objectsModel.get(0).obj.destroy();
            objectsModel.remove(0);
        }
    }

    function serialize() {
        var res = '<?xml version="1.0" encoding="utf-8"?>\n';
        res += '<scene>\n';

        for (var ii = 0; ii < objectsModel.count; ++ii) {
            var i = objectsModel.get(ii);

            res += "  <item>\n";
            res += "    <source>" + i.source + "</source>\n";
            res += "    <x>" + i.obj.x + "</x>\n";
            res += "    <y>" + i.obj.y + "</y>\n";
            res += "  </item>\n";
        }

        res += "</scene>";

        return res;
    }

    XmlListModel {
        id: xmlModel
        query: "/scene/item"
        XmlRole { name: "source"; query: "source/string()" }
        XmlRole { name: "x"; query: "x/string()" }
        XmlRole { name: "y"; query: "y/string()" }
    }

    function deserialize() {
        dsIndex = 0;
        CreateObject.create(xmlModel.get(dsIndex).source, root, dsItemAdded);
    }

    function dsItemAdded(obj, source) {
        itemAdded(obj, source);
        obj.x = xmlModel.get(dsIndex).x;
        obj.y = xmlModel.get(dsIndex).y;

        dsIndex ++;

        if (dsIndex < xmlModel.count)
            CreateObject.create(xmlModel.get(dsIndex).source, root, dsItemAdded);
    }

    property int dsIndex: 0

    Column {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 10

        spacing: 10

        width: 100

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: "ufo.png"

            MouseArea {
                anchors.fill: parent
                onClicked: addUfo();
            }
        }

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: "rocket.png"

            MouseArea {
                anchors.fill: parent
                onClicked: addRocket();
            }
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter

            width: 100
            height: 40

            color: "green"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    xmlModel.xml = serialize();
                    clearItems();
                }
            }
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter

            width: 100
            height: 40

            color: "yellow"

            MouseArea {
                anchors.fill: parent
                onClicked: deserialize();
            }
        }
    }
}
