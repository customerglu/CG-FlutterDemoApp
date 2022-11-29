import 'package:customerglu_plugin/customerglu_plugin.dart';
import 'package:customerglu_plugin/refreshWidget.dart';
import 'package:flutter/material.dart';

import 'LocalStore.dart';
import 'homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Demo();
  }
}

class Demo extends State<LoginScreen> {
  late TextEditingController _editingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editingController = TextEditingController(text: "");
    //CustomergluPlugin.entryPointData();
  }

  @override
  Widget build(BuildContext context) {
    return CGScreenDetector(
      classname: "LoginScreen",
      child: Scaffold(
        body: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Image.asset(
              "assets/images/customerglu.jpg",
              height: 150,
              width: 150,
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration:
                    const InputDecoration(hintText: 'Please Enter userId'),
                controller: _editingController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 320.0,
              child: ElevatedButton(
                onPressed: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  print(_editingController.text);
                  String user_id = _editingController.text.trim();
                  if (user_id.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Please Enter User_id"),
                            content: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Close"),
                            ),
                          );
                        });
                  } else {
          //           Navigator.of(context).pushAndRemoveUntil(
          // MaterialPageRoute(builder: (context) => MyHomePage(title: user_id)),
          // (Route<dynamic> route) => false);
                    registerUser();
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  registerUser() async {
    // CustomergluPlugin.clearGluData();
    String fcm = await LocalStore().getAppSharePopUp();
    String user_id = _editingController.text;
    CustomergluPlugin.isFcmApn("fcm");
    CustomergluPlugin.enableEntryPoints(true);
    CustomergluPlugin.setApnFcmToken("", fcm);
    var profile = {'userId': user_id, 'firebaseToken': fcm};
    bool res =
        await CustomergluPlugin.registerDevice(profile);
    if (res) {
      await LocalStore().setuserId("saved");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MyHomePage(title: user_id)),
          (Route<dynamic> route) => false);
    }

  }
}
