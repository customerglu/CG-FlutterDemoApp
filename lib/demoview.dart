import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AuthProvider.dart';

class DemoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Demo();
  }
}

class Demo extends State<DemoView> {
  var loginProvider = AuthProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Text("Demo"),
          onTap: () {
            loginProvider.loginAPI(
                userID: "himtest79",
                writeKey: "G4VCVVAcLub8hx5SaeqH3pRqLBmDFrwy");
            // Routes.pushSimple(context: context, child: MyWebView());
          },
        ),
      ),
    );
  }
}
