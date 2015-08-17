import QtQuick 1.0
import Box2D 1.0

Body {
    id: wall
    property alias image: image.source

    signal beginContact(variant other)

    bodyType: Body.Static
    fixtures: Box {
        anchors.fill: parent
        friction: 1.0

        onBeginContact: {
            wall.beginContact(other)
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "brown"
    }

    Image {
        id: image

        anchors.fill: parent
        source: "images/wall.jpg"

        fillMode: Image.Tile
    }
}
