// Copyright (C) 2026 Qt Group.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

pragma Strict
pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

ApplicationWindow {
    id: window
    width: 1280
    height: 800
    visible: true
    title: qsTr("Hello Layouts")

    color: "black"
    palette.windowText: "white"

    property int currentImageIndex: 0

    Component {
        id: thumbnailDelegate

        // A common Image delegate with a Text which will be used in each example below

        Image {
            id: thumbnail

            required property int index

            source: Qt.resolvedUrl(`assets/image${index}.jpg`)
            asynchronous: true

            Layout.preferredWidth: 100
            Layout.preferredHeight: 100

            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border {
                    color: "white"
                    // Note that strictly we should also add pragma ComponentBehavior: Bound
                    // due to this binding from a component to an instance within this QML Context
                    width: window.currentImageIndex === thumbnail.index ? 2 : 0
                }
            }

            Label {
                anchors.centerIn: parent
                font.pixelSize: 30
                style: Text.Outline
                styleColor: "black"
                text: thumbnail.index
            }

            MouseArea {
                anchors.fill: parent
                onClicked: window.currentImageIndex = thumbnail.index
            }
        }
    }

    RowLayout {

        anchors {
            fill: parent
            margins: 5
        }

        Flickable {
            id: flickable

            // auto flick direction based on contentItem size

            contentHeight: gridLayout.height
            contentWidth: gridLayout.width

            Layout.fillHeight: true // ensure the Flickable fills the height of the RowLayout
            Layout.preferredWidth: gridLayout.width // ensure the Flickable width matches the gridLayout's implicit (two column) width

            clip: true

            GridLayout {
                id: gridLayout

                columns: 2

                Repeater {
                    model: 10
                    delegate: thumbnailDelegate
                }
            }
        }

        ColumnLayout {

            Image {
                id: previewImage

                // In all cases, we will fill the width and height of the layout
                Layout.fillWidth: true
                Layout.fillHeight: true

                source: Qt.resolvedUrl(`assets/image${window.currentImageIndex}.jpg`)
                asynchronous: true
            }

            RowLayout {
                id: imageDetails

                // titles and texts horizontally interleaved

                Layout.minimumHeight: 40

                Label {
                    id: sourceTitle
                    text: qsTr("Source")
                    font.bold: true
                }
                Label {
                    id: sourceValue
                    text: previewImage.source
                }

                Label {
                    id: widthTitle
                    text: qsTr("Width")
                    font.bold: true
                }
                Label {
                    id: widthValue
                    text: previewImage.sourceSize.width
                }

                Label {
                    id: heightTitle
                    text: qsTr("Height")
                    font.bold: true
                }
                Label {
                    id: heightValue
                    text: previewImage.sourceSize.height
                }

                Label {
                    id: paintedWidthTitle
                    text: qsTr("Painted Width")
                    font.bold: true
                }
                Label {
                    id: paintedWidthValue
                    text: previewImage.paintedWidth
                }

                Label {
                    id: paintedHeightTitle
                    text: qsTr("Painted Height")
                    font.bold: true
                }
                Label {
                    id: paintedHeightValue
                    text: previewImage.paintedHeight
                }
            }
        }
    }
}
