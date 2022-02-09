import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  var url = "";
  NotificationAppLaunchDetails? _notificationAppLaunchDetails;

  bool get didNotificationLaunchApp =>
      _notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
  MyWebView({required this.url});
  @override
  WebState createState() => WebState();
}

class WebState extends State<MyWebView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        //  navigatorKey: Constant.navigatorKey,
        theme: ThemeData(
          // This is the theme of your application.

          primarySwatch: Colors.blue,
        ),
        home: webView(widget.url)
        // textpayload(widget.url), // Replace this with  your Home/Splash Screen
        );
  }

  textpayload(text) {
    return Scaffold(
      body: Center(
        child: Text("Himanshu" + text),
      ),
    );
  }

  webView(url) {
    return Scaffold(
        body: SafeArea(
      top: true,
      child: WebView(
        initialUrl: url, //Need to put Campaign url
        javascriptMode:
            JavascriptMode.unrestricted, //IMPORTANT for enabling javascript
        javascriptChannels: <JavascriptChannel>[
          JavascriptChannel(
              // For Android name is "app" and for IOS it is "callback"
              name: 'app',
              onMessageReceived: (s) {
                // s.message contains event data like  {"eventName":"CLOSE","data":null}
                print(s.message);
              }),
        ].toSet(),
      ),
    ));
  }
}
