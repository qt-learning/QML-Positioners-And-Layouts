// Copyright (C) 2026 Qt Group.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick

Window {
    width: 1280
    height: 800
    visible: true
    title: qsTr("Hello Anchors")

    contentItem {
        // make our window content scaled down so we can see what's going on
        scale: 0.1
        transformOrigin: Item.TopLeft
    }

    Image {
        id: image0
        source: Qt.resolvedUrl("assets/image0.jpg")
    }

    Image {
        id: image1
        anchors.left: image0.right
        source: Qt.resolvedUrl("assets/image1.jpg")
    }

    Image {
        id: image2
        anchors.left: image1.right
        source: Qt.resolvedUrl("assets/image2.jpg")
    }

    Image {
        id: image3
        anchors.left: image2.right
        source: Qt.resolvedUrl("assets/image3.jpg")
    }

    Image {
        id: image4
        anchors.left: image3.right
        source: Qt.resolvedUrl("assets/image4.jpg")
    }

    Image {
        id: image5
        anchors.left: image4.right
        source: Qt.resolvedUrl("assets/image5.jpg")
    }

    Image {
        id: image6
        anchors.left: image5.right
        source: Qt.resolvedUrl("assets/image6.jpg")
    }

    Image {
        id: image7
        anchors.left: image6.right
        source: Qt.resolvedUrl("assets/image7.jpg")
    }

    Image {
        id: image8
        anchors.left: image7.right
        source: Qt.resolvedUrl("assets/image8.jpg")
    }

    Image {
        id: image9
        anchors.left: image8.right
        source: Qt.resolvedUrl("assets/image9.jpg")
    }
}
