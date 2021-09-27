import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/controller/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //vars
  bool visibility = false;
  late String pass, user, token;

  //methods
  @override
  void initState() {
    super.initState();
    getinitialData();
  }

  Future<void> getinitialData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    user = prefs.getString('user') ?? '';
    pass = prefs.getString('pass') ?? '';
    if (token != '') {
      logInCat(context, {'user': user, 'pass': pass});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafbfd),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(mQ(context, 'w', 0.1)),
          child: AnimatedOpacity(
              opacity: visibility ? 0 : 1,
              duration: Duration(milliseconds: 500),
              child: Image.asset('images/logo.png')),
        ),
      ),
    );
  }
}
