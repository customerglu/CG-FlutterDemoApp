import 'package:customerglu_plugin/customerglu_plugin.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: RaisedButton(
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
                      registerUser();
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.black,
                ),
              )
            ],
          )),
    );
  }

  registerUser() async {
    String fcm = await LocalStore().getAppSharePopUp();
    String user_id = _editingController.text;
    var profile = {'userId': user_id, 'firebaseToken': fcm};
    CustomergluPlugin.isFcmApn("fcm");
    CustomergluPlugin.setApnFcmToken("", fcm);
    bool is_registered = await CustomergluPlugin.doRegister(profile, true);
    if (is_registered) {
      print("----------================-------------");
      print("Flutter res - ");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MyHomePage(title: '')),
              (Route<dynamic> route) => false);
    }
  }
}
