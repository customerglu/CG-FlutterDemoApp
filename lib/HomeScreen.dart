import 'package:customerglu_plugin/customerglu_plugin.dart';
import 'package:flutter/material.dart';
import 'package:nudgetest/testScreen.dart';

import 'LocalStore.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var eventproperties;
  String name = "";
  @override
  void initState() {
    super.initState();
    CustomergluPlugin.getInstance();
    CustomergluPlugin.setDefaultBannerImage(
        "https://assets.customerglu.com/demo/quiz/banner-image/Quiz_1.png");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
                        onPressed: () {
                          CustomergluPlugin.clearGluData();
                        }),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                boxIcon("assets/images/purse.png", "Wallet",
                        () => {CustomergluPlugin.openWallet()}),
                boxIcon("assets/images/quiz.png", "Campaigns",
                        () => {CustomergluPlugin.loadAllCampaigns()}),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                boxIcon(
                    "assets/images/onlineshopping.png",
                    "Test Screen",
                        () => {
                      // DemoPlugin.loadCampaignById(
                      //     "410e804b-0642-4f6d-88ff-14b2e9570c38")
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TestScreen()))
                    }),
                boxIcon(
                    "assets/images/trolley.png",
                    "Cart",
                        () => {
                      eventproperties = {"dd": "hh"},
                      CustomergluPlugin.sendEventData(
                          "completePurchase", eventproperties)
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => CartScreen()))
                    }),
              ],
            )
          ],
        ));
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
