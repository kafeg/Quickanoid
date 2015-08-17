import QtQuick 1.0
import Box2D 1.0

Body {
    id: brick
    width: parent.width/5 - 5
    height: 15
    anchors {
        top: parent.top
        topMargin: -height/2
    }

    signal disappear()

    property bool contacted : false

    bodyType: Body.Static
    fixtures: Box {
        anchors.fill: parent
        friction: 1.0

        onBeginContact: {
            contacted = true
        }
        onEndContact: {
            contacted = false
        }
    }

    Timer {
        id: timer
        interval: 20000; running: true; repeat: false
        onTriggered: { brick.visible = false; brick.active = false; disappear(); }
    }

    Rectangle {
        id: brickRect
        anchors.fill: parent
        radius: 6
        state: "green"

        states: [
            State {
                name: "green"
                when: brick.contacted
                PropertyChanges {
                    target: brickRect
                    color: "#7FFF00"
                }
                PropertyChanges {
                    target: timer
                    running: false
                }
            },
            State {
                name: "red"
                when: !brick.contacted
                PropertyChanges {
                    target: brickRect
                    color: "red"
                }
                PropertyChanges {
                    target: timer
                    running: true
                }
            }
        ]
        transitions: [
            Transition {
                from: "green"
                to: "red"
                ColorAnimation { id: animation; from: "#7FFF00"; to: "red"; duration: 20000; }
            }
        ]
    }

    function show() {
        timer.restart()
        brick.visible = true;
        brick.active = true;
        brick.contacted = true
        brick.contacted = false
    }
    function hide() {
        brick.contacted = true
        brick.visible = false;
        brick.active = false;
        timer.stop()
    }
}
