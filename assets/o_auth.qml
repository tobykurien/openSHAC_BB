// Default empty project template
import bb.cascades 1.0

// OAUth URL: https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/userinfo.email&response_type=code&redirect_uri=http://localhost:8080&client_id=231571905235.apps.googleusercontent.com

// creates one page with a label
Page {
    Container {
        layout: DockLayout {
        }

        ScrollView {
            WebView {
                id: webView
                url: "https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/userinfo.email&response_type=code&redirect_uri=http://localhost:8080&client_id=231571905235.apps.googleusercontent.com&access_type=offline"
                //html: "<html><body><form action='https://accounts.google.com/o/oauth2/token' method='POST'>" + "<input type='hidden' name='code' value='4/7FcBHYlLw7pY-d5j2auOA9E6Coia.MuGr09n4bwEROl05ti8ZT3bZn8JNewI'/>" + "<input type='hidden' name='client_id' value='231571905235.apps.googleusercontent.com'/>" + "<input type='hidden' name='client_secret' value='_TQPhcCcw7eAra4PUaY74m_W'/>" + "<input type='hidden' name='grant_type' value='authorization_code'/> " + "<input type='hidden' name='redirect_uri' value='http://localhost:8080'/>" + "</form><script type='text/javascript'>document.forms[0].submit();</script></body></html>"
                onNavigationRequested: {
                    // Mar 26 14:51:14.409    com.example.openSHAC_BB.testDev_openSHAC_BB30e1444d.37376235    default    9000    INFO        
                    // Navigation url: http://localhost:8080/?code=4/SgwFMXJFh7EM2DrJlaozSdGwFEN8.IleKKg9CwdAWOl05ti8ZT3bL5oRNewI
                    console.log("Navigation Requested: " + request.url + " navigationType=" + request.navigationType)
                    if (request.url.indexOf("http://localhost:8080") == 0) {
                        request.ignore();
                        token = request.url.substring("http://localhost:8080/?code=".length)
                        postHtml = "<html><body><form action='https://accounts.google.com/o/oauth2/token' method='POST'>" + "<input type='hidden' name='code' value='{code}'/>" + "<input type='hidden' name='client_id' value='231571905235.apps.googleusercontent.com'/>" + "<input type='hidden' name='client_secret' value='_TQPhcCcw7eAra4PUaY74m_W'/>" + "<input type='hidden' name='grant_type' value='authorization_code'/> " + "<input type='hidden' name='redirect_uri' value='http://localhost'/>" + "</form><script type='text/javascript'>document.forms[0].submit();</script></body></html>"
                        postHtml = postHtml.replace("{code}", token)
                        webView2.html = postHtml
                    }
                }
            }
        }
        
        WebView {
            id: webView2
            visible: false
            onLoadingChanged: {
                if (loadRequest.status == WebLoadStatus.Succeeded) {
                    // done loading, get the JSON
                    console.log("Navigation finished loading auth request, got: " + webView2.html)
                }
            }
        }
    }
}
