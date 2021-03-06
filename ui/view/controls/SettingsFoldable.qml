import QtQuick 2.11
import QtQuick.Controls 1.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import Beam.Wallet 1.0
import "."

Control {
    id: control
    Layout.fillWidth: true

    property string title
    property bool   folded: true
    property var    content: null
    property var    headerContent: null
    spacing: 10

    // Status indicator
    property bool   hasStatusIndicatior: false
    property alias  connectionStatus: statusIndicator.status
    property alias  connectionErrorMsg: statusErrorMsg.text
    property bool   connectionError: connectionStatus == "error"

    contentItem: ColumnLayout {
        spacing: 0
        clip:    true

        Item {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            height: header.height

            MouseArea {
                visible: control.folded || !headerContent
                anchors.fill: parent
                cursorShape:  Qt.PointingHandCursor
                onClicked: {
                    control.folded = !control.folded;
                }
            }

            RowLayout {
                id:      header
                width:   parent.width
                spacing: 0

                Item {
                    width:   statusIndicator.radius
                    visible: hasStatusIndicatior

                    MouseArea {
                        anchors.fill: parent
                        cursorShape:  Qt.PointingHandCursor
                        onClicked: {
                            control.folded = !control.folded;
                        }
                    }
                }

                ExternalNodeStatus {
                    id:               statusIndicator
                    Layout.alignment: Qt.AlignVCenter
                    visible:          hasStatusIndicatior

                    MouseArea {
                        anchors.fill: parent
                        cursorShape:  Qt.PointingHandCursor
                        onClicked: {
                            control.folded = !control.folded;
                        }
                    }
                }

                Item {
                    width: control.spacing
                    visible: hasStatusIndicatior

                    MouseArea {
                        anchors.fill: parent
                        cursorShape:  Qt.PointingHandCursor
                        onClicked: {
                            control.folded = !control.folded;
                        }
                    }
                }

                SFText {
                    text:  control.title
                    color: Qt.rgba(Style.content_main.r, Style.content_main.g, Style.content_main.b, 0.5)

                    font {
                        styleName:      "Medium"
                        weight:         Font.Medium
                        pixelSize:      14
                        letterSpacing:  3.11
                        capitalization: Font.AllUppercase
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape:  Qt.PointingHandCursor
                        onClicked: {
                            control.folded = !control.folded;
                        }
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                Control {
                    visible:      !control.folded
                    contentItem:  headerContent
                    rightPadding: 20
                }

                Image {
                    id: originalSizeImage
                    source: control.folded ? "qrc:/assets/icon-grey-arrow-down.svg" : "qrc:/assets/icon-grey-arrow-up.svg"

                    MouseArea {
                        anchors.fill: parent
                        cursorShape:  Qt.PointingHandCursor
                        onClicked: {
                            control.folded = !control.folded;
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillWidth:  true
            visible: connectionError
            height:  errorRow.height

            RowLayout {
                id: errorRow
                width: parent.width
                spacing: 0

                Item {
                    width: statusIndicator.radius + statusIndicator.width + control.spacing
                }

                SFText {
                    Layout.fillWidth:  true
                    id:                statusErrorMsg
                    color:             Style.validator_error
                    font.pixelSize:    12
                    font.italic:       true
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape:  Qt.PointingHandCursor
                onClicked: {
                    control.folded = !control.folded;
                }
            }
        }

        Control {
            visible:           !control.folded
            Layout.fillWidth:  true
            Layout.topMargin:  connectionError ? 25 - errorRow.height : 25
            Layout.alignment:  Qt.AlignTop
            contentItem:       content
        }
    }

    background: Rectangle {
        radius:  10
        color:   Style.background_second
    }

    leftPadding:   20
    rightPadding:  22
    topPadding:    20
    bottomPadding: connectionError && control.folded ? 16 : 20
}
