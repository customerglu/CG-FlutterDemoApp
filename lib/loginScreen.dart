import 'package:cgdemoplugin/cgdemoplugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nudgetest/homeScreen.dart';

import 'AuthProvider.dart';
import 'LocalStore.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Demo();
  }
}

class Demo extends State<LoginScreen> {
  late TextEditingController _editingController;

  var loginProvider = AuthProvider();

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
            SizedBox(height: 150,),
            Image.asset("assets/images/customerglu.jpg",height: 150,width: 150,),
            SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Please Enter userId'),
                controller: _editingController,
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: 320.0,
              child: RaisedButton(
                onPressed: () {
                  print(_editingController.text);
                  String user_id = _editingController.text.trim();
                  if (user_id.isEmpty)
                    {
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Please Enter User_id"),
                              content: ElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("Close"),
                              ),
                            );
                          }
                      );
                    }
                  else {
                    registerUser();
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
              ),
            )
          ],
        )
      ),
    );
  }
  registerUser() async {
    String fcm = await LocalStore().getAppSharePopUp();
    String user_id = _editingController.text;
    var profile = {'userId': user_id, 'firebaseToken': fcm};
    Cgdemoplugin.isFcmApn("fcm");
    Cgdemoplugin.setApnFcmToken("", fcm);
    bool is_registered = await Cgdemoplugin.doRegister(profile, true);
    if (is_registered) {
      print("----------================-------------");
      print("Flutter res - ");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>  MyHomePage(title: '')),
              (Route<dynamic> route) => false);
    }
  }
}
