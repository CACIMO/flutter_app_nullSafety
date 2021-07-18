import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //vars
  bool visibility = false;

  //methods
  @override
  void initState() {
    super.initState();
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
