import 'package:customerglu_plugin/customerglu_plugin.dart';
import 'package:flutter/material.dart';

import 'LocalStore.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TestScreen> {
  var eventproperties;
  late TextEditingController _editingController;
  String initialText = "Initial Text";
  var filter;
  String name = "";
  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: Colors.blue,
          title: const Text("Test Screen"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Center(
                child:
                boxIcon("Wallet", () => {CustomergluPlugin.openWallet()}),
              ),
              boxIcon(
                  "LoadCampaign Filter",
                      () => {
                    filter = {"type": "giftbox"},
                    CustomergluPlugin.loadCampaignsByFilter(filter)
                  }),
              boxIcon(
                  "Campaigns", () => {CustomergluPlugin.loadAllCampaigns()}),
              boxIcon(
                  "Campaign By Id",
                      () => {
                    print("dialog"),
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0)), //this right here
                            child: SizedBox(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      decoration: const InputDecoration(
                                          hintText:
                                          'Please Enter Campaign Id or Tag'),
                                      controller: _editingController,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          print(_editingController.text);
                                          CustomergluPlugin
                                              .loadCampaignById(
                                              _editingController.text);
                                        },
                                        child: const Text(
                                          "Open Campaign ",
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                        color: const Color(0xFF1BC0C5),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    // CustomergluPlugin.loadCampaignById(
                    //     "0c114806-aeca-4e42-a475-10759b8a303e")
                  }),
              boxIcon(
                  "Test Push Notification",
                      () => {
                    eventproperties = {"dd": "hh"},
                    CustomergluPlugin.sendEventData(
                        "completePurchase", eventproperties)
                  }),
              boxIcon(
                  "In-app Middle Notification",
                      () => {
                    eventproperties = {"dd": "hh"},
                    CustomergluPlugin.sendEventData(
                        "completePurchase3", eventproperties)
                  }),
              boxIcon(
                  "In-app Bottom Notification",
                      () => {
                    eventproperties = {"dd": "hh"},
                    CustomergluPlugin.sendEventData(
                        "completePurchase4", eventproperties)
                  }),
              boxIcon(
                  "setBannerImage",
                      () => {
                    CustomergluPlugin.setDefaultBannerImage(
                        "https://assets.customerglu.com/demo/quiz/banner-image/Quiz_1.png")
                  }),
              boxIcon("LoaderColour",
                      () => {CustomergluPlugin.configureLoaderColour("#F089b2")}),
              boxIcon("closeWebview",
                      () => {CustomergluPlugin.closeWebviewOnDeeplinkEvent(true)}),
              boxIcon("disableGluSdk",
                      () => {CustomergluPlugin.disableGluSdk(true)}),
              boxIcon("enablePrecaching",
                      () => {CustomergluPlugin.enablePrecaching()}),
              boxIcon("getReferralId",
                      () => {CustomergluPlugin.getReferralId("true")}),
              boxIcon("enableAnalyticsEvent",
                      () => {CustomergluPlugin.enableAnalyticsEvent(true)}),
              boxIcon("updateProfile", () => {updateProfile()}),
              boxIcon(
                  "Safe Area",
                      () => {
                    CustomergluPlugin.configureSafeArea(
                        50, 30, "#FF0Ebc", "#FF0ENJ")
                  }),
              const SizedBox(height: 30),
            ],
          ),
        ));
  }
}

registerUser() async {
  String fcm = await LocalStore().getAppSharePopUp();
  var profile = {'userId': 'JohnWickios20899', 'firebaseToken': fcm};
  CustomergluPlugin.isFcmApn("fcm");
  CustomergluPlugin.setApnFcmToken("", fcm);
  bool is_registered = await CustomergluPlugin.doRegister(profile, true);
  if (is_registered) {
    print("----------================-------------");
    print("Flutter res - ");
  }
}

updateProfile() async {
  String fcm = await LocalStore().getAppSharePopUp();
  var profile = {'userId': 'JohnWickios20872', 'firebaseToken': fcm};
  CustomergluPlugin.isFcmApn("fcm");
  CustomergluPlugin.setApnFcmToken("", fcm);
  await CustomergluPlugin.updateProfile(profile);
}

Widget boxIcon(label, callback) {
  return GestureDetector(
    onTap: () => {callback()},
    child: Card(
      elevation: 3,
      child: Container(
        decoration: const BoxDecoration(color: Colors.blue),
        height: 50,
        width: 300,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
