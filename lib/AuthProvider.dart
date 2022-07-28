import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'main.dart';

class AuthProvider with ChangeNotifier {
  loginAPI({userID, writeKey}) async {
    var param = {
      'userId': userID,
      'writeKey': writeKey,
      'firebaseToken':
          'dVNOvhTISPiLnc8sbS79zd:APA91bHeR71c-q39p5AxfhbK10qmmXIHVGY5tGoIKhkn4Iu8s_AMLzX-ynrQ3hlsR--_de1nb0nBs97e51DYrMf-CtaAakBlqrod-A4cHk2L2296y_NJWjzvoi1_XUHWDJnIm9nn7sJe',
      'deviceType': 'android'
    };

    print(param);
    //  loader(cxt);

    try {
      Response response;
      response = await post(Uri.parse(""), body: param);
      //  await pr.hide();
      //  Navigator.pop(cxt);
      print(response.statusCode);

      var data = jsonDecode(response.body);
      print('${data}');
      print(data['token']);
      if (!data['token'].toString().isEmpty) {}
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      //   await pr.hide();
      //  dismissWaitDialog();
      print(e.toString());
      // showErrorAlert(e.toString());
    }
  }
}
