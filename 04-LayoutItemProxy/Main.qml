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
    title: qsTr("Hello LayoutItemProxy")

    color: "black"
    palette.windowText: "white"

    property int currentImageIndex: 0

    // breakpoints
    readonly property int tabletBreakpoint: 1000
    readonly property int mobileBreakPoint: 600
    readonly property bool isDesktopLayout: window.width >  tabletBreakpoint
    readonly property bool isTabletLayout:  window.width <= tabletBreakpoint && window.width > mobileBreakPoint
    readonly property bool isMobileLayout:  window.width <= mobileBreakPoint

    // copied here from Section 3 verbatim
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

    // copied here from Section 3 with a modification to the columns/rows binding
    Flickable {
        id: flickable

        // visibility and size is going to be managed by LayoutItemProxies
        // auto flick direction based on contentItem size

        contentHeight: gridLayout.height
        contentWidth: gridLayout.width

        clip: true

        GridLayout {
            id: gridLayout

            // We change the number of rows and columns based on the layout
            columns: window.isDesktopLayout ? 2 : window.isTabletLayout ? 1 : -1
            rows: window.isMobileLayout ? 1 : -1

            Repeater {
                model: 10
                delegate: thumbnailDelegate
            }
        }
    }

    // copied here from Section 3 verbatim
    Image {
        id: previewImage

        // visibility and size is going to be managed by LayoutItemProxies

        // In all cases, we will fill the width and height of the layout
        Layout.fillWidth: true
        Layout.fillHeight: true

        source: Qt.resolvedUrl(`assets/image${window.currentImageIndex}.jpg`)
        asynchronous: true
    }

    // copied here from Section 3 verbatim - the declaration order here doesn't matter.
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

    RowLayout {
        // Desktop Layout

        visible: window.isDesktopLayout

        anchors {
            fill: parent
            margins: 5
        }

        LayoutItemProxy {
            target: flickable

            Layout.fillHeight: true // ensure the Flickable fills the height of the RowLayout
            Layout.preferredWidth: gridLayout.width // ensure the Flickable width matches the gridLayout's implicit (two column) width
        }

        ColumnLayout {

            LayoutItemProxy {
                target: previewImage
            }

            RowLayout {
                // titles and texts horizontally interleaved

                Layout.minimumHeight: 40

                LayoutItemProxy {
                    target: sourceTitle
                }
                LayoutItemProxy {
                    target: sourceValue
                }
                LayoutItemProxy {
                    target: widthTitle
                }
                LayoutItemProxy {
                    target: widthValue
                }
                LayoutItemProxy {
                    target: heightTitle
                }
                LayoutItemProxy {
                    target: heightValue
                }
                LayoutItemProxy {
                    target: paintedWidthTitle
                }
                LayoutItemProxy {
                    target: paintedWidthValue
                }
                LayoutItemProxy {
                    target: paintedHeightTitle
                }
                LayoutItemProxy {
                    target: paintedHeightValue
                }
            }
        }
    }

    RowLayout {
        // Tablet Layout

        visible: window.isTabletLayout

        anchors {
            fill: parent
            margins: 5
        }

        LayoutItemProxy {
            target: flickable

            Layout.fillHeight: true // ensure the Flickable fills the height of the RowLayout
            Layout.preferredWidth: gridLayout.width // ensure the Flickable width matches the gridLayout's implicit (one column) width
        }

        LayoutItemProxy {
            target: previewImage
        }

        ColumnLayout {
            // titles and texts vertically interleaved

            Layout.alignment: Qt.AlignTop

            LayoutItemProxy {
                target: sourceTitle
            }
            LayoutItemProxy {
                target: sourceValue
                Layout.leftMargin: 5
            }

            LayoutItemProxy {
                target: widthTitle
            }
            LayoutItemProxy {
                target: widthValue
                Layout.leftMargin: 5
            }

            LayoutItemProxy {
                target: heightTitle
            }
            LayoutItemProxy {
                target: heightValue
                Layout.leftMargin: 5
            }

            LayoutItemProxy {
                target: paintedWidthTitle
            }
            LayoutItemProxy {
                target: paintedWidthValue
                Layout.leftMargin: 5
            }

            LayoutItemProxy {
                target: paintedHeightTitle
            }
            LayoutItemProxy {
                target: paintedHeightValue
                Layout.leftMargin: 5
            }
        }
    }

    ColumnLayout {
        // Mobile Layout

        visible: window.isMobileLayout

        anchors {
            fill: parent
            margins: 5
        }

        LayoutItemProxy {
            target: previewImage
        }

        GridLayout {

            columns: 4

            // titles and texts vertically interleaved

            LayoutItemProxy {
                target: sourceTitle
            }
            LayoutItemProxy {
                target: sourceValue
                Layout.columnSpan: 3
            }

            LayoutItemProxy {
                target: widthTitle
            }
            LayoutItemProxy {
                target: widthValue
            }

            LayoutItemProxy {
                target: heightTitle
            }
            LayoutItemProxy {
                target: heightValue
            }

            LayoutItemProxy {
                target: paintedWidthTitle
            }
            LayoutItemProxy {
                target: paintedWidthValue
            }

            LayoutItemProxy {
                target: paintedHeightTitle
            }
            LayoutItemProxy {
                target: paintedHeightValue
            }
        }

        LayoutItemProxy {
            target: flickable

            Layout.fillWidth: true // ensure the Flickable fills the width of the ColumnLayout
            Layout.preferredHeight: gridLayout.height // ensure the Flickable width matches the gridLayout's implicit (one row) height
        }
    }
}
