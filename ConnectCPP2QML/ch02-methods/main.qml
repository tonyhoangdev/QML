import QtQuick 2.6
import Charts 1.0

Item {
    width: 300; height: 200

    PieChart {
        id: aPieChart
        anchors.centerIn: parent
        width: 100; height: 100
        name: "A simple pie chart"
        color: "red"

        onChartCleared: console.log("The chart has been cleared")
    }

    MouseArea {
        anchors.fill: parent
        onClicked: aPieChart.clearChart()
    }

    Text {
        anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; bottomMargin: 20 }
        text: "Click anywhere to clear the chart"
    }
}
