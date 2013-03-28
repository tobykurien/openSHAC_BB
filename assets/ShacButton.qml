import bb.cascades 1.0

ImageButton {
    property string id
    property string imageName
    
    defaultImageSource: "asset:///images/" + imageName + ".png"
    pressedImageSource: "asset:///images/" + imageName + "_pinched.png"
    horizontalAlignment: HorizontalAlignment.Center
    layoutProperties: StackLayoutProperties {
        spaceQuota: 1
    }
}