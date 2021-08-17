import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:nudgetest/LocalStore.dart';

import 'WebView.dart';
import 'demoview.dart';

class Constant {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const LOGIN =
      "https://api.customerglu.com/user/v1/user/sdk?token=true";
}

String selectedNotificationPayload = "data";
String myurl = "myurl";

Future<void> backgroundHandler(RemoteMessage message) async {
  print("handler");
  await Firebase.initializeApp();
  print(message.data.toString());
  selectedNotificationPayload = message.data['nudge_url'];
  print("---------selected-----");
  print(selectedNotificationPayload);
  await LocalStore().setAppSharePopUp(message.data['nudge_url']);
  var url = await LocalStore().getAppSharePopUp();
  print("---------url-----");

  print(url);
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['type'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
        ),
      ));
  // initializelocalNotification();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    //  runApp(MyApp());
    // selectedNotificationPayload =
    //     notificationAppLaunchDetails!.payload.toString();
    selectedNotificationPayload = await LocalStore().getAppSharePopUp();
    myurl = selectedNotificationPayload;
    print(myurl);

    runApp(MyWebView(url: myurl));
  } else {
    runApp(MyApp());
  }
}

void initializelocalNotification() async {
  var initialzationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher'); // You can put Your App Icon here but less than 100KB
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false);
  var initializationSettings = InitializationSettings(
      android: initialzationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    selectedNotificationPayload = payload!;
    runApp(MyWebView(url: payload));
  });
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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
            message.data["type"] == "CustomerGlu") print("initial");
        Navigator.of(Constant.navigatorKey.currentState!.overlay!.context).push(
            MaterialPageRoute(
                builder: (context) =>
                    MyWebView(url: message.data["nudge_url"])));
      }
    });

    var messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value) {
      print(value);
      fcmtoken = value!;
      //Firebase Token
    });

    //  initializelocalNotification();

    FirebaseMessaging.onMessage.listen((message) {
      print(message.data["nudge_url"]);
      var fromCustomerGlu = message.data["type"];
      var inapp = message.data["glu_message_type"];
      if (fromCustomerGlu == "CustomerGlu") {
        if (inapp == "in-app") {
          Navigator.of(Constant.navigatorKey.currentState!.overlay!.context)
              .push(MaterialPageRoute(
                  builder: (context) =>
                      MyWebView(url: message.data["nudge_url"])));
        } else if (message.data.containsKey("image")) {
          _showBigPictureNotificationURL(
              image: message.data['image'],
              title: message.data['title'],
              body: message.data['body']);
        } else {
          flutterLocalNotificationsPlugin.show(
              message.data.hashCode,
              message.data['title'],
              message.data['body'],
              NotificationDetails(
                android: AndroidNotificationDetails(
                    channel.id, channel.name, channel.description),
              ));
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("gjhgj");
      Navigator.of(Constant.navigatorKey.currentState!.overlay!.context).push(
          MaterialPageRoute(
              builder: (context) => MyWebView(url: message.data["nudge_url"])));
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
      home: MyWebView(url: "SOME_URL"), // Replace this with  your Home/Splash Screen
    );
  }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  Future<void> _showBigPictureNotificationURL(
      {required image, required title, required body}) async {
    // final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
    //     await _getByteArrayFromUrl('https://via.placeholder.com/48x48'));
    final ByteArrayAndroidBitmap bigPicture =
        ByteArrayAndroidBitmap(await _getByteArrayFromUrl(image));

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(bigPicture,
            //    largeIcon: largeIcon,
            contentTitle: title,
            htmlFormatContentTitle: true,
            summaryText: body,
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            channel.id, channel.name, channel.description,
            styleInformation: bigPictureStyleInformation);
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }
}
