// Copyright (C) 2026 Qt Group.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick

Window {
    width: 1280
    height: 800
    visible: true
    title: qsTr("Hello Positioners")

    Component {
        id: imageDelegate

        // A common Image delegate with a Text which will be used in each example below

        Image {
            id: image

            required property int index

            source: Qt.resolvedUrl(`assets/image${index}.jpg`)
            asynchronous: true

            width: 100
            height: 100

            Text {
                anchors.centerIn: parent
                //text: image.index
                text: image.Positioner.index // is also possible here but could be -1
                font.pixelSize: 30
                color: "white"
                style: Text.Outline
                styleColor: "black"
            }

            Rectangle {
                // demonstrate how to use the Positioner attached property
                anchors.fill: parent
                color: "transparent"
                border {
                    width: 5
                    color: image.Positioner.isFirstItem ? "green" : image.Positioner.isLastItem ? "red" : "transparent"
                }
            }
        }
    }

    /* Row Example */

    Rectangle {
        color: "grey"
        anchors.fill: row
        visible: row.visible
    }

    Row {
        id: row

        visible: false // set to true to try out Row

        spacing: 10
        padding: 10

        Repeater {
            model: 10
            delegate: imageDelegate
        }
    }

    /* Column Example */

    Rectangle {
        color: "grey"
        anchors.fill: column
        visible: column.visible
    }

    Column {
        id: column

        visible: false // set to true to try out Column

        spacing: 10
        padding: 10

        Repeater {
            model: 10
            delegate: imageDelegate
        }
    }

    /* Grid Example */

    Rectangle {
        color: "grey"
        anchors.fill: grid
        visible: grid.visible
    }

    Grid {
        id: grid

        visible: false // set to true to try out Grid

        spacing: 10
        padding: 10
        columns: 4

        columnSpacing: 20
        rowSpacing: 25

        layoutDirection: Qt.RightToLeft
        //LayoutMirroring.enabled: true // reverses the effectiveLayoutDirection

        flow: Grid.TopToBottom

        Repeater {
            model: 10
            delegate: imageDelegate
        }
    }

    /* Flow Example */

    Rectangle {
        color: "grey"
        anchors.fill: flow
        visible: flow.visible
    }

    Flow {
        id: flow

        anchors.fill: parent // size the window to see the effect

        spacing: 10
        padding: 10

        layoutDirection: Qt.RightToLeft
        flow: Flow.TopToBottom

        Repeater {
            model: 10
            delegate: imageDelegate
        }
    }
}
