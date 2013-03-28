import bb.cascades 1.0

ImageButton {
    property string id
    property string imageName
    property string action
    
    defaultImageSource: "asset:///images/" + imageName + ".png"
    pressedImageSource: "asset:///images/" + imageName + "_pinched.png"
    horizontalAlignment: HorizontalAlignment.Center
    layoutProperties: StackLayoutProperties {
        spaceQuota: 1
    }
    
    onClicked: {
        // make web request
        webRequester.url = "http://enter.house4hack.co.za/init/android/" + action
    }
}