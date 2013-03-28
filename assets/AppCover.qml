import bb.cascades 1.0

SceneCover {
    // The content property must be explicitly specified
    content: Container {
        Container {
            layout: DockLayout {
            }
            background: Color.Black
            ImageView {
                imageSource: "asset:///images/gate_small_round.png"
            }

            // A container for the label text
            Container {
                bottomPadding: 31
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Bottom

                // A background for the label
                Container {
                    preferredWidth: 84
                    preferredHeight: 42
                    background: Color.create("#121212")
                    layout: DockLayout {
                    }

                    // A title for the cover indicating that it's
                    // the QML version
                    Label {
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        text: qsTr("SHAC")
                        textStyle.color: Color.create("#ebebeb")
                        textStyle.fontSize: FontSize.Small
                    }
                }
            }
        }
    }
}