import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:customerglu_plugin/customerglu_plugin.dart';

import 'LocalStore.dart';
import 'SplashScreen.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("backgroundHandler(RemoteMessage message)");
  await Firebase.initializeApp();
  CustomergluPlugin.displayCustomerGluBackgroundNotification(message.data);
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var fcmtoken = "";

  static const broadcast_channel = MethodChannel("CUSTOMERGLU_EVENTS");

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();

    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      print("FirebaseMessaging.instance.getInitialMessage().then((message)");
      if (message != null) {
        CustomergluPlugin.displayCustomerGluBackgroundNotification(
            message.data);
      }
    });

    var messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value) {
      print("fcm token" + value.toString());
      fcmtoken = value!;
      LocalStore().setAppSharePopUp(fcmtoken);
    });

    FirebaseMessaging.onMessage.listen((message) {
      print("FirebaseMessaging.onMessage.listen");
      CustomergluPlugin.displayCustomerGluNotification(message.data,
          autoclosewebview: true, opacity: 0.5);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      CustomergluPlugin.displayCustomerGluBackgroundNotification(message.data);
    });

    broadcast_channel.setMethodCallHandler((call) async {
      print("home method channel");

      switch (call.method) {
        case "CUSTOMERGLU_DEEPLINK_EVENT":
          print("CUSTOMERGLU_DEEPLINK_EVENT");
          print(call.arguments);
          var json = jsonDecode(call.arguments);
          print(json["name"]);
          break;
        case "CUSTOMERGLU_ANALYTICS_EVENT":
          print("CUSTOMERGLU_ANALYTICS_EVENT FROM FLUTTER");
          print(call.arguments);
          var json = jsonDecode(call.arguments);
          print(json["event_name"]);
          break;
        case "CUSTOMERGLU_BANNER_LOADED":
          print("CUSTOMERGLU_BANNER_LOADED");
          print(call.arguments);
          break;
        case "CG_INVALID_CAMPAIGN_ID":
          print("CG_INVALID_CAMPAIGN_ID");
          print(call.arguments);
          break;
      }
    });
    CustomergluPlugin.enableAnalyticsEvent(true);
    CustomergluPlugin.configureLoaderColour("#0B66EA");
  }

  static const EventChannel _eventChannel = EventChannel("CustomerGlu");
  late StreamSubscription _mystream;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    try {} on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
