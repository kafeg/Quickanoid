import QtQuick 1.0
import Box2D 1.0

Body {
    id: platform
    width: platformBg.width
    height: platformBg.height
    x: parent.width/2 - width/2
    y: parent.height - platformBg.height - 5

    bodyType: Body.Static
    fixtures: Box {
        id: platformBox
        anchors.fill: parent
        friction: 100
        density: 3000;
    }

    Image {
        id: platformBg
        smooth: true
        source: "images/platform.png"
    }

    MouseArea {
        anchors.fill: parent
        drag.target: platform
        drag.axis: Drag.XAxis
        drag.minimumX: 0
        drag.maximumX: screen.width - platform.width
    }
}
