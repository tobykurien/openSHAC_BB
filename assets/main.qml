// Default empty project template
import bb.cascades 1.0
import bb.system 1.0
import shac.config 1.0

// OAUth URL: https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/userinfo.email&response_type=code&redirect_uri=http://localhost:8080&client_id=231571905235.apps.googleusercontent.com
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
            },
            ActionItem {
                title: "Sign In"
                onTriggered: signIn()
                ActionBar.placement: ActionBarPlacement.InOverflow
            },
            ActionItem {
                title: "Settings"
                ActionBar.placement: ActionBarPlacement.InOverflow
            }
        ]

        function signIn() {
            var page = o_auth.createObject();
            navigationPane.push(page);
        }

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
                //inputField.inputMode: SystemUiInputMode.Password
                onFinished: {
                    if (result == SystemUiResult.ConfirmButtonSelection) {
                        console.log("confirm");
                    } else if (result == SystemUiResult.CancelButtonSelection) {
                        console.log("cancel");
                    }
                }
            }
        ]

        Container {
            layout: StackLayout {
                orientation: TopToBottom
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
                    //webRequester.url = "http://enter.house4hack.co.za/init/android/door"
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
                    // make web request to open door
                    //webRequester.url = "http://enter.house4hack.co.za/init/android/door"
                }
            }

            WebView {
                id: webRequester
                maxHeight: 200
                verticalAlignment: VerticalAlignment.Bottom
                horizontalAlignment: HorizontalAlignment.Center
            }
        }

        onCreationCompleted: {
            config.read();
            if (!config.accessToken) {
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