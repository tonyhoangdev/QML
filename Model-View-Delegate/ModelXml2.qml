import QtQuick 2.6
import QtQuick.XmlListModel 2.0
import "./common"

Background {
    width: 300
    height: 480

    Component {
        id: imageDelegate

        Box {
            width: listView.width
            height: 220
            color: '#333'

            Column {
                Text {
                    text: title
                    color: '#e0e0e0'
                }
                Text {
                    text: year
                    color: '#F0F0e0'
                }
                Text {
                    text: type
                    color: '#F0F0e0'
                }
                Text {
                    text: first_author
                    color: '#F0F0e0'
                }
                Text {
                    text: wanted
                    color: '#F0F0e0'
                }
            }
        }
    }

    XmlListModel {
        id: imageModel

        source: "a.xml"

        // XmlRole queries will be made on <book> elements
        query: "/catalog/book"

        // query the book title
        XmlRole { name: "title"; query: "title/string()" }

        // query the book's year
        XmlRole { name: "year"; query: "year/number()" }

        // query the book's type (the '@' indicates 'type' is an attribute, not an element)
        XmlRole { name: "type"; query: "@type/string()" }

        // query the book's first listed author (note in XPath the first index is 1, not 0)
        XmlRole { name: "first_author"; query: "author[1]/string()" }

        // query the wanted attribute as a boolean
        XmlRole { name: "wanted"; query: "boolean(@wanted)" }
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: imageModel
        delegate: imageDelegate
    }
}
