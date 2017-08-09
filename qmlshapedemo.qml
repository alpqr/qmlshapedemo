import QtQuick 2.9
import QtQuick.Shapes 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Rectangle {
    id: root
    property color col: "lightsteelblue"
    gradient: Gradient {
        GradientStop { position: 0.0; color: Qt.tint(root.col, "#20FFFFFF") }
        GradientStop { position: 0.1; color: Qt.tint(root.col, "#20AAAAAA") }
        GradientStop { position: 0.9; color: Qt.tint(root.col, "#20666666") }
        GradientStop { position: 1.0; color: Qt.tint(root.col, "#20000000") }
    }
    property int cw: 200
    property int ch: 200

    TabBar {
        id: bar
        width: parent.width
        TabButton {
            text: "Stroke/fill"
        }
        TabButton {
            text: "Dash"
        }
        TabButton {
            text: "Lin. grad."
        }
        TabButton {
            text: "Circle"
        }
        TabButton {
            text: "Arc"
        }
        TabButton {
            text: "Quad curve"
        }
        TabButton {
            text: "Join/Cap && Cubic"
        }
        TabButton {
            text: "Radial grad."
        }
        TabButton {
            text: "Conical grad."
        }
    }

    StackLayout {
        anchors.fill: parent
        currentIndex: bar.currentIndex
        Item {
            Rectangle {
                anchors.centerIn: parent
                width: root.cw
                height: root.ch

                Shape {
                    id: tri1
                    anchors.fill: parent

                    ShapePath {
                        id: tri1sp
                        strokeColor: "red"
                        strokeWidth: 4
                        SequentialAnimation on strokeWidth {
                            running: tri1.visible
                            NumberAnimation { from: 1; to: 20; duration: 2000 }
                            NumberAnimation { from: 20; to: 1; duration: 2000 }
                        }
                        fillColor: "blue"
                        ColorAnimation on fillColor {
                            from: "blue"; to: "cyan"; duration: 2000; running: tri1.visible
                        }

                        startX: 10; startY: 10
                        PathLine { x: tri1.width - 10; y: tri1.height - 10 }
                        PathLine { x: 10; y: tri1.height - 10 }
                        PathLine { x: 10; y: 10 }
                    }

                    Text {
                        text: "Stroke width: " + Math.round(tri1sp.strokeWidth)
                        anchors.centerIn: parent
                    }
                }
            }
        }
        Item {
            Rectangle {
                anchors.centerIn: parent
                width: root.cw
                height: root.ch

                Shape {
                    id: tri2
                    anchors.fill: parent

                    ShapePath {
                        strokeColor: "red"
                        strokeWidth: 4
                        strokeStyle: ShapePath.DashLine
                        dashPattern: [ 1, 4 ]
                        fillColor: "transparent"

                        startX: 10; startY: 10
                        PathLine { x: tri2.width - 10; y: tri2.height - 10 }
                        PathLine { x: 10; y: tri2.height - 10 }
                        PathLine { x: 10; y: 10 }
                    }

                    SequentialAnimation on scale {
                        running: tri2.visible
                        NumberAnimation { from: 1; to: 4; duration: 2000; easing.type: Easing.InOutBounce }
                        NumberAnimation { from: 4; to: 1; duration: 2000; easing.type: Easing.OutBack }
                    }
                }

                Text {
                    text: "Transforms are cheap"
                    anchors.centerIn: parent
                }
            }
        }
        Item {
            Rectangle {
                anchors.centerIn: parent
                width: root.cw
                height: root.ch

                Shape {
                    id: tri3
                    anchors.fill: parent

                    ShapePath {
                        strokeColor: "transparent"

                        fillGradient: LinearGradient {
                            x1: 20; y1: 20
                            x2: 180; y2: 130
                            GradientStop { position: 0; color: "blue" }
                            GradientStop { position: 0.2; color: "green" }
                            GradientStop { position: 0.4; color: "red" }
                            GradientStop { position: 0.6; color: "yellow" }
                            GradientStop { position: 1; color: "cyan" }
                        }

                        startX: 10; startY: 10
                        PathLine { x: tri3.width - 10; y: tri3.height - 10 }
                        PathLine { x: 10; y: tri3.height - 10 }
                        PathLine { x: 10; y: 10 }
                    }

                    NumberAnimation on rotation {
                        from: 0; to: 360; duration: 2000
                        running: tri3.visible
                    }
                }

                Text {
                    text: "Linear gradient,\nthis time for real"
                    anchors.centerIn: parent
                }
            }
        }
        Item {
            Rectangle {
                anchors.centerIn: parent
                width: root.cw
                height: root.ch

                Shape {
                    id: circle
                    anchors.fill: parent
                    property real r: 60

                    ShapePath {
                        strokeColor: "transparent"
                        fillColor: "green"

                        startX: circle.width / 2 - circle.r
                        startY: circle.height / 2 - circle.r
                        PathArc {
                            x: circle.width / 2 + circle.r
                            y: circle.height / 2 + circle.r
                            radiusX: circle.r; radiusY: circle.r
                            useLargeArc: true
                        }
                    }
                    ShapePath {
                        strokeColor: "transparent"
                        fillColor: "red"

                        startX: circle.width / 2 + circle.r
                        startY: circle.height / 2 + circle.r
                        PathArc {
                            x: circle.width / 2 - circle.r
                            y: circle.height / 2 - circle.r
                            radiusX: circle.r; radiusY: circle.r
                            useLargeArc: true
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "Two arcs"
                    }
                }
            }
        }
        Item {
            Rectangle {
                anchors.centerIn: parent
                width: root.cw
                height: root.ch

                Repeater {
                    model: 2
                    Shape {
                        anchors.fill: parent

                        ShapePath {
                            fillColor: "transparent"
                            strokeColor: model.index === 0 ? "red" : "blue"
                            strokeStyle: ShapePath.DashLine
                            strokeWidth: 4

                            startX: 50; startY: 100
                            PathArc {
                                x: 150; y: 100
                                radiusX: 50; radiusY: 20
                                xAxisRotation: model.index === 0 ? 0 : 45
                            }
                        }
                    }
                }

                Repeater {
                    model: 2
                    Shape {
                        anchors.fill: parent

                        ShapePath {
                            fillColor: "transparent"
                            strokeColor: model.index === 0 ? "red" : "blue"

                            startX: 50; startY: 100
                            PathArc {
                                x: 150; y: 100
                                radiusX: 50; radiusY: 20
                                xAxisRotation: model.index === 0 ? 0 : 45
                                direction: PathArc.Counterclockwise
                            }
                        }
                    }
                }
            }
        }
        Item {
            Rectangle {
                anchors.centerIn: parent
                width: root.cw
                height: root.ch

                Shape {
                    id: quadCurve
                    anchors.fill: parent

                    ShapePath {
                        strokeWidth: 4
                        strokeColor: "black"
                        fillGradient: LinearGradient {
                            x1: 0; y1: 0; x2: 200; y2: 200
                            GradientStop { position: 0; color: "blue" }
                            GradientStop { position: 1; color: "green" }
                        }

                        startX: 50
                        startY: 150
                        PathQuad {
                            x: 150; y: 150
                            controlX: quadCurveControlPoint.x; controlY: quadCurveControlPoint.y
                        }
                    }
                }

                Rectangle {
                    id: quadCurveControlPoint
                    color: "red"
                    width: 10
                    height: 10
                    y: 20
                    SequentialAnimation on x {
                        loops: Animation.Infinite
                        NumberAnimation {
                            from: 0
                            to: quadCurve.width - quadCurveControlPoint.width
                            duration: 5000
                        }
                        NumberAnimation {
                            from: quadCurve.width - quadCurveControlPoint.width
                            to: 0
                            duration: 5000
                        }
                    }
                }
            }
        }
        Item {
            Rectangle {
                anchors.centerIn: parent
                width: root.cw
                height: root.ch

                Shape {
                    anchors.fill: parent

                    ShapePath {
                        strokeColor: "red"
                        strokeWidth: 20
                        fillColor: "transparent"
                        joinStyle: ShapePath.RoundJoin

                        startX: 20; startY: 20
                        PathLine { x: 100; y: 100 }
                        PathLine { x: 20; y: 150 }
                        PathLine { x: 20; y: 20 }
                    }

                    ShapePath {
                        strokeColor: "black"
                        strokeWidth: 10
                        capStyle: ShapePath.RoundCap
                        fillColor: "transparent"

                        startX: 150; startY: 20
                        PathCubic { x: 150; y: 150; control1X: 120; control1Y: 50; control2X: 0
                            SequentialAnimation on control2Y {
                                loops: Animation.Infinite
                                NumberAnimation { from: 0; to: 200; duration: 5000 }
                                NumberAnimation { from: 200; to: 0; duration: 5000 }
                            }
                        }
                    }
                }
            }
        }
        Item {
            Rectangle {
                anchors.centerIn: parent
                width: root.cw
                height: root.ch

                Shape {
                    id: radGradCirc
                    anchors.fill: parent
                    property real r: 60

                    ShapePath {
                        strokeWidth: 4
                        strokeColor: "red"
                        fillGradient: RadialGradient {
                            centerX: 100; centerY: 100; centerRadius: 100
                            SequentialAnimation on focalRadius {
                                loops: Animation.Infinite
                                NumberAnimation { from: 1; to: 20; duration: 2000 }
                                NumberAnimation { from: 20; to: 1; duration: 2000 }
                            }
                            SequentialAnimation on focalX {
                                loops: Animation.Infinite
                                NumberAnimation { from: 50; to: 150; duration: 3000 }
                                NumberAnimation { from: 150; to: 50; duration: 3000 }
                            }
                            SequentialAnimation on focalY {
                                loops: Animation.Infinite
                                NumberAnimation { from: 50; to: 150; duration: 1000 }
                                NumberAnimation { from: 150; to: 50; duration: 1000 }
                            }
                            GradientStop { position: 0; color: "#ffffff" }
                            GradientStop { position: 0.11; color: "#f9ffa0" }
                            GradientStop { position: 0.13; color: "#f9ff99" }
                            GradientStop { position: 0.14; color: "#f3ff86" }
                            GradientStop { position: 0.49; color: "#93b353" }
                            GradientStop { position: 0.87; color: "#264619" }
                            GradientStop { position: 0.96; color: "#0c1306" }
                            GradientStop { position: 1; color: "#000000" }
                        }
                        strokeStyle: ShapePath.DashLine
                        dashPattern: [ 1, 4 ]

                        startX: radGradCirc.width / 2 - radGradCirc.r
                        startY: radGradCirc.height / 2 - radGradCirc.r
                        PathArc {
                            x: radGradCirc.width / 2 + radGradCirc.r
                            y: radGradCirc.height / 2 + radGradCirc.r
                            radiusX: radGradCirc.r; radiusY: radGradCirc.r
                            useLargeArc: true
                        }
                        PathArc {
                            x: radGradCirc.width / 2 - radGradCirc.r
                            y: radGradCirc.height / 2 - radGradCirc.r
                            radiusX: radGradCirc.r; radiusY: radGradCirc.r
                            useLargeArc: true
                        }
                    }
                }
            }
        }
        Item {
            Rectangle {
                anchors.centerIn: parent
                width: root.cw
                height: root.ch

                Shape {
                    id: conGradCirc
                    anchors.fill: parent
                    property real r: 60

                    ShapePath {
                        strokeWidth: 4
                        strokeColor: "black"
                        fillGradient: ConicalGradient {
                            centerX: 100; centerY: 100
                            NumberAnimation on angle { from: 0; to: 360; duration: 10000; loops: Animation.Infinite }
                            GradientStop { position: 0; color: "#00000000" }
                            GradientStop { position: 0.10; color: "#ffe0cc73" }
                            GradientStop { position: 0.17; color: "#ffc6a006" }
                            GradientStop { position: 0.46; color: "#ff600659" }
                            GradientStop { position: 0.72; color: "#ff0680ac" }
                            GradientStop { position: 0.92; color: "#ffb9d9e6" }
                            GradientStop { position: 1.00; color: "#00000000" }
                        }

                        startX: conGradCirc.width / 2 - conGradCirc.r
                        startY: conGradCirc.height / 2 - conGradCirc.r
                        PathArc {
                            x: conGradCirc.width / 2 + conGradCirc.r
                            y: conGradCirc.height / 2 + conGradCirc.r
                            radiusX: conGradCirc.r; radiusY: conGradCirc.r
                            useLargeArc: true
                        }
                        PathArc {
                            x: conGradCirc.width / 2 - conGradCirc.r
                            y: conGradCirc.height / 2 - conGradCirc.r
                            radiusX: conGradCirc.r; radiusY: conGradCirc.r
                            useLargeArc: true
                        }
                    }
                }
            }
        }
    }
}
