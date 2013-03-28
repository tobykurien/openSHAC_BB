// Main screen
import bb.cascades 1.0
import bb.system 1.0
import shac.config 1.0

NavigationPane {
    id: navigationPane
    // creates one page with a label
    Page {
        titleBar: TitleBar {
            title: "Smart House Access Control"
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
            },
            OrientationHandler {
                id: orientationHandler
                onOrientationAboutToChange: {
                    root.reOrient(orientation);
                }
            },
            ComponentDefinition {
                id: appCover
                source: "AppCover.qml"
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

            ShacButton {
                id: btnGate
                imageName: "gate_small_round"
                action: "gate"
            }
            
            ShacButton {
                id: btnDoor
                imageName: "door_small_round"
                action: "door"
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
            Application.cover = appCover.createObject();
            OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.All;
            root.reOrient(orientationHandler.orientation);

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