import 'dart:async';

import 'package:customerglu_plugin/customerglu_plugin.dart';
import 'package:customerglu_plugin/refreshWidget.dart';
import 'package:customerglu_plugin_example/LocalStore.dart';
import 'package:customerglu_plugin_example/loginScreen.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _versionName = 'V1.0';
  final splashDelay = 3;
  bool bacKground = false;
  String token = "";
  @override
  void initState() {
    super.initState();
    CustomergluPlugin.gluSDKDebuggingMode(true);
    CustomergluPlugin.configureLoadingScreenColor("#FFFFFF00");
    setupInitial();
  }

  setupInitial() async {
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    bool isLogged = await LocalStore().getUserId();
    if (isLogged) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const MyHomePage(
                    title: "da",
                  )),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CGScreenDetector(
        classname: this.runtimeType.toString(),
        child: Scaffold(
            backgroundColor: Colors.black,
            body: Container(
              child: Center(
                child: Image.asset(
                  'assets/images/customerglu.jpg',
                  height: 150,
                  width: 150,
                ),
              ),
            )));
  }
}
