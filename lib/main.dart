import 'dart:async';
import 'dart:ui';
import 'package:flutter_app/catalogo.dart';

import 'login.dart';
import 'utils.dart';
import 'package:flutter_app/login.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
//import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //_initDownloader();

  runApp(new MaterialApp(
    theme: ThemeData(fontFamily: 'Roboto-Regular'),
    home: new MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto-Regular',
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //vars
  bool visibility = false;

  //methods
  void authToken() async {
    if (token != '') {
      httpGet(this.context, 'auth', false).then((resp) {
        httpGet(this.context, 'menuTk', false).then((resp) {
          setState(() {
            menOptions = resp['data'][0]['MenuData'];
            permissions = resp['data'][0]['Permiso'];
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => Catalogo()));
        }).catchError((onError) {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => Login()));
        });
      }).catchError((onError) {
        Timer(Duration(milliseconds: 1500), () {
          setState(() {
            visibility = !visibility;
          });
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => Login()));
        });
      });
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => Login()));
    }
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }

  @override
  void initState() {
    super.initState();

    getToken().then((value) => authToken()).catchError((onError) =>
        errorMsg(this.context, 'Error Auth', 'Error al autenticar'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafbfd),
      //key: _scaffoldKey,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(mediaQuery(context, 'w', 0.1)),
          child: AnimatedOpacity(
              opacity: visibility ? 0 : 1,
              duration: Duration(milliseconds: 500),
              child: Image.asset('images/logo.png')),
        ),
      ),
    );
  }
}
