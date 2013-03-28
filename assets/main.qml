// Main screen
import bb.cascades 1.0
import bb.system 1.0
import shac.config 1.0

NavigationPane {
    id: navigationPane
    // creates one page with a label
    Page {
        titleBar: TitleBar {
            title: "SHAC"
        }

        actions: [
            ActionItem {
                title: "House4Hack"
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    routeInvoker.endAddress = "4 Burger Ave, Centurion, South Africa"
                    routeInvoker.endDescription = "House4Hack"
                    routeInvoker.go()
                }
            },
            ActionItem {
                title: "Sign In"
                onTriggered: root.signIn()
                ActionBar.placement: ActionBarPlacement.InOverflow
            }
        ]

        attachedObjects: [
            ComponentDefinition {
                id: o_auth
                source: "o_auth.qml"
            },
            Configurator {
                id: config
            },
            SystemDialog {
                id: loginDialog
                modality: SystemUiModality.Application
                title: qsTr("Not authenticated")
                body: qsTr("Would you like to sign in to Google for authentication?")
                onFinished: {
                    if (result == SystemUiResult.ConfirmButtonSelection) {
                        root.signIn();
                    }
                }
            },
            SystemToast {
              id: toast
              body: "Toast message"
            },
            OrientationHandler {
                onOrientationAboutToChange: {
                    root.reOrient(orientation);
                }
            }
        ]

        Container {
            id: root
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill

            layout: StackLayout {
                id: buttonLayout
            }

            function signIn() {
                var page = o_auth.createObject();
                navigationPane.push(page);
            }
            
            function reOrient(orientation) {
                if (orientation == UIOrientation.Landscape) {
                    buttonLayout.orientation = LayoutOrientation.LeftToRight;
                } else {
                    buttonLayout.orientation = LayoutOrientation.TopToBottom;
                }
            }

            ImageButton {
                id: btnDoor
                defaultImageSource: "asset:///images/door_small_round.png"
                pressedImageSource: "asset:///images/door_small_round_pinched.png"
                horizontalAlignment: HorizontalAlignment.Center
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
                onClicked: {
                    // make web request to open door
                    webRequester.url = "http://enter.house4hack.co.za/init/android/door"
                }
            }

            ImageButton {
                id: btnGate
                defaultImageSource: "asset:///images/gate_small_round.png"
                pressedImageSource: "asset:///images/gate_small_round_pinched.png"
                horizontalAlignment: HorizontalAlignment.Center
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
                onClicked: {
                    // make web request to open gate
                    webRequester.url = "http://enter.house4hack.co.za/init/android/gate"
                }
            }

            WebView {
                id: webRequester
                maxHeight: 200
                visible: false
                verticalAlignment: VerticalAlignment.Bottom
                horizontalAlignment: HorizontalAlignment.Center
                onLoadingChanged: {
                    if (loadRequest.status == WebLoadStatus.Succeeded) {
                        // done loading, get the JSON
                        toast.body = webRequester.html
                        toast.show()
                    }
                }
            }
        }

        onCreationCompleted: {
            OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.All;
            root.reOrient(orientation);
            
            config.read();            
            if (! config.accessToken) {
                loginDialog.show()
            } else {
                webRequester.settings.customHttpHeaders = {
                    "Cookie": "token=" + config.accessToken,
                    "X-SHAC-Token": "BlackBerry",
                    "User-Agent": "openSHAC for BlackBerry 10"
                }
            }
        }
    }

    onPopTransitionEnded: {
        page.destroy();
    }
}