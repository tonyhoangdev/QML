// keys.qml

import QtQuick 2.6

DarkSquare {
    width: 600; height: 600

    GreenSquare {
        id: square1
        x: 8; y: 8
    }

    focus: true

    Keys.onLeftPressed: square1.x -= 10
    Keys.onRightPressed: square1.x += 10
    Keys.onUpPressed: square1.y -= 10
    Keys.onDownPressed: square1.y += 10
    Keys.onPressed: {
        switch(event.key) {
            case Qt.Key_Plus:
                square1.scale += 0.2
                break
            case Qt.Key_Minus:
                square1.scale -= 0.2
                break
            default:
                // Do nothing
                break;
        }
    }
}
