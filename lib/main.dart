import 'dart:typed_data';

 import 'package:cgdemoplugin/cgdemoplugin.dart';
import 'package:firebase_core/firebase_core.dart';
 import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:nudgetest/LocalStore.dart';
import 'package:nudgetest/SplashScreen.dart';

import 'WebView.dart';
import 'homeScreen.dart';


class Constant {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const LOGIN =
      "https://api.customerglu.com/user/v1/user/sdk?token=true";
}
String selectedNotificationPayload = "data";
String myurl = "myurl";
//
Future<void> backgroundHandler(RemoteMessage message) async {
  print("handler");
  await Firebase.initializeApp();
  print(message.data.toString());
  // selectedNotificationPayload = message.data['nudge_url'];
  // print("---------selected-----");
  // print(selectedNotificationPayload);
  // await LocalStore().setAppSharePopUp(message.data['nudge_url']);
  // var url = await LocalStore().getAppSharePopUp();
  // print("---------url-----");
  //
  // print(url);
  // flutterLocalNotificationsPlugin.show(
  //     message.data.hashCode,
  //     message.data['type'],
  //     message.data['body'],
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         channel.id,
  //         channel.name,
  //         channel.description,
  //       ),
  //     ));
  // initializelocalNotification();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

// void initializelocalNotification() async {
//   var initialzationSettingsAndroid = AndroidInitializationSettings(
//       '@mipmap/ic_launcher'); // You can put Your App Icon here but less than 100KB
//   final IOSInitializationSettings initializationSettingsIOS =
//       IOSInitializationSettings(
//           requestSoundPermission: false,
//           requestBadgePermission: false,
//           requestAlertPermission: false);
//   var initializationSettings = InitializationSettings(
//       android: initialzationSettingsAndroid, iOS: initializationSettingsIOS);
//
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: (String? payload) async {
//     selectedNotificationPayload = payload!;
//     runApp(MyWebView(url: payload));
//   });
// }
//
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

class MyApp extends StatefulWidget with ChangeNotifier {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
// This widget is the root of your application.

}

class MyAppState extends State<MyApp> {
  var fcmtoken = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        if (message.data["type"] != null &&
            message.data["type"] == "CustomerGlu") print("initial");}
      //   Navigator.of(Constant.navigatorKey.currentState!.overlay!.context).push(
      //       MaterialPageRoute(
      //           builder: (context) =>
      //               MyWebView(url: message.data["nudge_url"])));
      // }
    });

    var messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value) {
      print("fcm token" + value.toString());
      fcmtoken = value!;
      Cgdemoplugin.setApnFcmToken("", fcmtoken);
      LocalStore().setAppSharePopUp(fcmtoken);
      //Firebase Token
    });

    //  initializelocalNotification();

    FirebaseMessaging.onMessage.listen((message) {
      print("FirebaseMessaging.onMessage.listen");
      Cgdemoplugin.displayCustomerGluNotification(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      Cgdemoplugin.displayBackgroundNotification(message.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      navigatorKey: Constant.navigatorKey,
      theme: ThemeData(
        // This is the theme of your application.

        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Replace this with  your Home/Splash Screen
    );
  }

  // Future<Uint8List> _getByteArrayFromUrl(String url) async {
  //   final http.Response response = await http.get(Uri.parse(url));
  //   return response.bodyBytes;
  // }

  // Future<void> _showBigPictureNotificationURL(
  //     {required image, required title, required body}) async {
  //   // final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
  //   //     await _getByteArrayFromUrl('https://via.placeholder.com/48x48'));
  //   final ByteArrayAndroidBitmap bigPicture =
  //       ByteArrayAndroidBitmap(await _getByteArrayFromUrl(image));
  //
  //   final BigPictureStyleInformation bigPictureStyleInformation =
  //       BigPictureStyleInformation(bigPicture,
  //           //    largeIcon: largeIcon,
  //           contentTitle: title,
  //           htmlFormatContentTitle: true,
  //           summaryText: body,
  //           htmlFormatSummaryText: true);
  //   final AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //           channel.id, channel.name, channel.description,
  //           styleInformation: bigPictureStyleInformation);
  //   final NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, title, body, platformChannelSpecifics);
  // }
}
