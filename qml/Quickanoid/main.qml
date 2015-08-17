import QtQuick 1.0
import Box2D 1.0

Image {
    id: screen;

    source: "images/bg.jpeg"
    width: 640
    height: 360
    property int bricksCount: 5

    World {
        id: world
        width: screen.width
        height: screen.height
        visible: false

        gravity.x: 0
        gravity.y: 0

        Wall {
            id: wallLeft

            width: 10
            anchors {
                bottom: parent.bottom
                left: parent.left
                leftMargin: -width
                top: parent.top
            }
        }

        Wall {
            id: wallRight

            width: 10
            anchors {
                bottom: parent.bottom
                right: parent.right
                rightMargin: -width
                top: parent.top
            }
        }

        Wall {
            id: wallTop

            height: 10
            anchors {
                left: parent.left
                right: parent.right
                topMargin: -height
                top: parent.top
            }
        }

        Wall {
            id: wallBottom

            height: 10
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                bottomMargin: -height
            }
            onBeginContact: {
                console.log(other)
                finishGame()
            }
        }

        Ball {
            id: ball
            x: parent.width/2
            y: parent.height/2
        }

        Platform {
            id: platform
        }

        Brick {
            id: brick1
            x: 3;
            onDisappear: bricksCount--
        }
        Brick {
            id: brick2
            anchors {
                left:brick1.right
                leftMargin: 5
            }
            onDisappear: bricksCount--
        }
        Brick {
            id: brick3
            anchors {
                left:brick2.right
                leftMargin: 5
            }
            onDisappear: bricksCount--
        }
        Brick {
            id: brick4
            anchors {
                left:brick3.right
                leftMargin: 5
            }
            onDisappear: bricksCount--
        }
        Brick {
            id: brick5
            anchors {
                left:brick4.right
                leftMargin: 5
            }
            onDisappear: bricksCount--
        }

        Text {
            id: secondsPerGame
            anchors {
                bottom: parent.bottom
                left: parent.left
            }
            color: "white"
            font.pixelSize: 36
            text: "0"
            Timer {
                id: scoreTimer
                interval: 1000; running: true; repeat: true
                onTriggered: secondsPerGame.text = parseInt(secondsPerGame.text) + 1
            }
        }
    }

    Item {
        id:screenStart
        anchors.fill: parent
        visible: false
        Text {
            id: startGame
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 36
            text: "Start Game!"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    screen.startGame()
                }
            }
        }
    }

    Item {
        id:screenFinish
        anchors.fill: parent
        visible: false
        Text {
            id: score
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 36
            text: "Game over! Your score is: " + secondsPerGame.text
        }
        Text {
            id: restartGame
            anchors {
                top: score.bottom
                horizontalCenter: parent.horizontalCenter
            }
            color: "white"
            font.pixelSize: 36
            text: "Restart Game!"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    screen.startGame()
                }
            }
        }
    }

    function startGame() {
        screen.state = "InGame";
        bricksCount = 5
        brick1.show()
        brick2.show()
        brick3.show()
        brick4.show()
        brick5.show()
        secondsPerGame.text = "0"
        platform.x = screen.width/2 - platform.width/2
        ball.linearVelocity.x = 0
        ball.linearVelocity.y = 0
        ball.active = true;
        ball.x = platform.x + platform.width/2
        ball.y = platform.y - ball.height
        ball.x = screen.width/2
        ball.y = screen.height/2
        ball.applyLinearImpulse(Qt.point(50, 300), Qt.point(ball.x, ball.y))
        scoreTimer.running = true
    }

    function finishGame(){
        screen.state = "FinishScreen";
        brick1.hide()
        brick2.hide()
        brick3.hide()
        brick4.hide()
        brick5.hide()
        ball.active = false;
        ball.applyLinearImpulse(Qt.point(0,0), Qt.point(ball.x, ball.y))
        scoreTimer.running = false
    }

    onBricksCountChanged: {
        console.log(bricksCount)
        if (bricksCount <=2){
            finishGame()
        }
    }

    Component.onCompleted: {
        startGame()
    }

    states: [
        State {
            name: "StartScreen"
            PropertyChanges {
                target: screenStart
                visible: true
            }
        },
        State {
            name: "InGame"
            PropertyChanges {
                target: world
                visible: true
            }
        },
        State {
            name: "FinishScreen"
            PropertyChanges {
                target: screenFinish
                visible: true
            }
        }
    ]
    state: "StartScreen"
}
