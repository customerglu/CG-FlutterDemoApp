import 'dart:async';
import 'dart:convert';

import 'package:customerglu_plugin/NudgeConfiguration.dart';
import 'package:customerglu_plugin/refreshWidget.dart';

import 'package:customerglu_plugin/customerglu_plugin.dart';
import 'package:customerglu_plugin_example/testScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'LocalStore.dart';
import 'cartScreen.dart';
import 'loginScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var eventproperties;
  String name = "";
  late NudgeConfiguration nudgeConfiguration;

  @override
  void initState() {
    super.initState();
    CustomergluPlugin.enableEntryPoints(true);
    CustomergluPlugin.setCurrentClassName("HomeScreen");
    CustomergluPlugin.enableAnalyticsEvent(true);
    CustomergluPlugin.configureStatusBarColour("#000000");
    CustomergluPlugin.configureLoadingScreenColor("#FFFFFF");
    CustomergluPlugin.configureSafeArea(100, 100, "#1099FF00", "#FF0099");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Widget build");

    return CGScreenDetector(
      classname: "HomeScreen",
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.8,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Colors.black),
                  ),
                  Image.asset("assets/images/customerglu.jpg"),
                  Positioned(
                    top: 20.0,
                    right: 0.0,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            print("logout");
                            await LocalStore().setuserId("");

                            CustomergluPlugin.clearGluData();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                                (Route<dynamic> route) => false);
                          }),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  boxIcon(
                      "assets/images/purse.png",
                      "Wallet",
                      () => {
                            nudgeConfiguration = NudgeConfiguration(
                                relativeHeight: -20.0,
                                absoluteHeight: -50.0,
                                layout: "full-default",
                                closeOnDeepLink: false,
                                opacity: 0.1),
                            CustomergluPlugin.openWallet(
                                nudgeConfiguration: nudgeConfiguration)
                          }),
                  boxIcon(
                      "assets/images/quiz.png",
                      "Campaigns",
                      () => {
                            nudgeConfiguration = NudgeConfiguration(
                                absoluteHeight: 1000, layout: "bottom-default"),
                            CustomergluPlugin.loadCampaignById(
                                "3ceca97a-5287-4a87-a583-354af7cd348f")
                          }),
                ],
              ),
              const SizedBox(height: 10),
              CustomergluPlugin().showBanner(id: "entry1"),
           //   CustomergluPlugin().CGEmbedView(id: "embedded1"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  boxIcon(
                      "assets/images/onlineshopping.png",
                      "Test Screen",
                      () => {
                            // DemoPlugin.loadCampaignById(
                            //     "410e804b-0642-4f6d-88ff-14b2e9570c38")

                            //       changeState()
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const TestScreen()))
                          }),
                  boxIcon(
                      "assets/images/trolley.png",
                      "Cart",
                      () => {
                            // eventproperties = {"dd": "hh"},
                            // CustomergluPlugin.sendEventData(
                            //     "completePurchase", eventproperties)

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CartScreen()))
                          }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

 
}

Widget boxIcon(image, label, callback) {
  return GestureDetector(
    onTap: () => {callback()},
    child: Card(
      elevation: 3,
      child: Container(
        height: 150,
        width: 150,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  image,
                  height: 80,
                  width: 80,
                ),
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}

registerUser(id) async {
  print("registering start");
  var list = ["google.com", "cloudfront.net"];
  CustomergluPlugin.configureWhiteListedDomains(domainsList: list);
  String fcm = await LocalStore().getAppSharePopUp();
  String user_id = "dkashd";
  var profile = {'userId': user_id, 'firebaseToken': fcm};
  CustomergluPlugin.isFcmApn("fcm");

  CustomergluPlugin.enableEntryPoints(true);
  await CustomergluPlugin.registerDevice(profile);

  //  CustomergluPlugin.registerDeviceWithoutCallback(profile, loadCampaigns: true);
  print("EntryPointData");
//CustomergluPlugin.enableEntryPoints(true);
  // CustomergluPlugin.entryPointData();
}
