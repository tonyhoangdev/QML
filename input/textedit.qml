// textedit.qml

import QtQuick 2.6

Rectangle {
    width: 400
    height: 120
    color: "linen"

    TTextEdit {
        id: input1
        x: 8; y: 8
        width: 120; height: 104
        focus: true
        text: "Text Edit 1"
        KeyNavigation.tab: input2
    }

    TTextEdit {
        id: input2
        x: 148; y: 8
        width: 120; height: 104
        focus: true
        text: "Text Edit 2"
        KeyNavigation.tab: input1
    }
}
