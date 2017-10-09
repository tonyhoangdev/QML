import QtQuick 2.6

Rectangle {
    id: relay

    signal messageReceived(string person, string notice)

    Component.onCompleted: {

        relay.messageReceived.connect(sendToPost)
        relay.messageReceived.connect(sendToTelegraph)
        relay.messageReceived.connect(sendToEmail)
        relay.messageReceived("Tom", "Happy Birthday")
        removeTelegraphSignal()
        relay.messageReceived("Thai", "Happy New year")
    }

    function sendToPost(person, notice)
    {
        console.log("Sending to post: " + person + ", " + notice)
    }

    function sendToTelegraph(person, notice)
    {
        console.log ("Sending to telegraph: " + person + ", " + notice)
    }

    function sendToEmail(person, notice)
    {
        console.log("Sending to email: " + person + ", " + notice)
    }

    function removeTelegraphSignal() {
        relay.messageReceived.disconnect(sendToTelegraph)
    }
}
