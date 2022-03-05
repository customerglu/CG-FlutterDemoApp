import 'package:cgdemoplugin/cgdemoplugin.dart';
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
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }) ,
        backgroundColor: Colors.blue,
        title: Text("Test Screen"),
      ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
           // crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              const SizedBox(height: 30),
              Center(
                child:  boxIcon("Wallet", () => {Cgdemoplugin.openWallet()}),

              ),
              boxIcon(
                  "LoadCampaign Filter",
                      () => {
                    filter = {"type": "giftbox"},
                    Cgdemoplugin.loadCampaignsByFilter(filter)
                  }),
              boxIcon("Campaigns", () => {Cgdemoplugin.loadAllCampaigns()}),
              boxIcon(
                  "Campaign By Id",
                      () => {
                        print("dialog"),
                      showDialog(
                      context: context,
                      builder: (BuildContext context) {
                      return Dialog(
                      shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(20.0)), //this right here
                      child: Container(
                      height: 200,
                      child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      TextField(
                      decoration: InputDecoration(
                      hintText: 'Please Enter Campaign Id or Tag'),
                        controller: _editingController,
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                      onPressed: () {
                        print(_editingController.text);
                        Cgdemoplugin.loadCampaignById(_editingController.text);
                      },
                      child: Text(
                      "Open Campaign ",
                      style: TextStyle(color: Colors.white),
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
                    // Cgdemoplugin.loadCampaignById(
                    //     "0c114806-aeca-4e42-a475-10759b8a303e")

                  }),
              boxIcon(
                  "Test Push Notification",
                      () => {
                    eventproperties = {"dd": "hh"},
                    Cgdemoplugin.sendEventData(
                        "completePurchase", eventproperties)

                  }),
              boxIcon(
                  "In-app Middle Notification",
                      () => {
                    eventproperties = {"dd": "hh"},
                    Cgdemoplugin.sendEventData(
                        "completePurchase3", eventproperties)

                  }),
              boxIcon(
                  "In-app Bottom Notification",
                      () => {
                    eventproperties = {"dd": "hh"},
                    Cgdemoplugin.sendEventData(
                        "completePurchase4", eventproperties)
                  }),

              boxIcon("setBannerImage",
                      () => {Cgdemoplugin.setDefaultBannerImage("https://assets.customerglu.com/demo/quiz/banner-image/Quiz_1.png")}),
              boxIcon("LoaderColour",
                      () => {Cgdemoplugin.configureLoaderColour("#F089b2")}),
              boxIcon("closeWebview",
                      () => {Cgdemoplugin.closeWebviewOnDeeplinkEvent(true)}),
              boxIcon(
                  "disableGluSdk", () => {Cgdemoplugin.disableGluSdk(true)}),
              boxIcon(
                  "enablePrecaching", () => {Cgdemoplugin.enablePrecaching()}),
              boxIcon(
                  "getReferralId", () => {Cgdemoplugin.getReferralId("true")}),
              boxIcon("enableAnalyticsEvent",
                      () => {Cgdemoplugin.enableAnalyticsEvent(true)}),
              boxIcon("updateProfile", () => {updateProfile()}),
              boxIcon(
                  "Safe Area",
                      () => {
                    Cgdemoplugin.configureSafeArea(
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
  Cgdemoplugin.isFcmApn("fcm");
  Cgdemoplugin.setApnFcmToken("", fcm);
  bool is_registered = await Cgdemoplugin.doRegister(profile, true);
  if (is_registered) {
    print("----------================-------------");
    print("Flutter res - ");
  }
}

updateProfile() async {
  String fcm = await LocalStore().getAppSharePopUp();
  var profile = {'userId': 'JohnWickios20872', 'firebaseToken': fcm};
  Cgdemoplugin.isFcmApn("fcm");
  Cgdemoplugin.setApnFcmToken("", fcm);
  await Cgdemoplugin.updateProfile(profile);
}

Widget boxIcon(label, callback) {
  return GestureDetector(
    onTap: () => {callback()},
    child: Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue
        ),
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
                      fontSize: 20, fontWeight: FontWeight.w400,color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}

// Widget showDialog()
// {
//
//    return Dialog(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10),
//     ),
//     elevation: 0,
//     backgroundColor: Colors.black,
//     child: Container(
//       height: 300,
//       width: 300,
//       child: Text("hello"),),
//   );
// }
