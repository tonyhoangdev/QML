//create-component.js

var component;

function createImageObject() {
    component = Qt.createComponent('dynamic-image.qml');
    if (component.status === Component.Ready || component.status === Component.Error) {
        finishCreation();
    } else {
        component.statusChanges.connect(finishCreation)
    }
}

function finishCreation() {
    if (component.status === Component.Ready) {
        var image = component.createObject(root, {"x": 100, "y": 100, "border.color": "red", "border.width": 2});
        if (image === null) {
            console.log("Error creating image");
        }
    } else if (component.status === Component.Error) {
        console.log("Error loading component: ", component.errorString());
    }
}
