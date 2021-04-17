import 'dart:async';
import 'dart:convert';
//import 'package:amdbb/historial.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'catalogo.dart';
import 'cuenta.dart';
import 'utils.dart';
//import 'cuenta.dart';
//import 'catalogo.dart';
//import 'global.dart';
//import 'dart:convert';
///import 'package:crypto/crypto.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> {
  @override
  void initState() {
    cleanSessions();
    super.initState();
  }

  //vars
  final Map<String, TextEditingController> controllers = {
    'user': TextEditingController(),
    'password': TextEditingController(),
  };

  //methods
  Future<bool> _onBackPressed() async {
    SystemNavigator.pop();
    return true;
  }

  void logIn() async {
    bool flag = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> jsonAux = {
      'usuario': controllers['user']!.text,
      'password':
          sha512.convert(utf8.encode(controllers['password']!.text)).toString()
    };

    //it is validate that the fiels User and password aren't null or thant aren't in blanck
    for (final key in jsonAux.keys) {
      if (jsonAux[key] == '') {
        flag = true;
        errorMsg(this.context, 'Error Log in', 'Por favor ingrese su $key');
        break;
      }
    }

    if (!flag) {
      httpPost(this.context, 'login', jsonAux, true).then((resp) {
        List aux = resp['data']['usuario'];
        if (aux.length == 0) throw '';
        setState(() {
          menOptions = resp['data']['usuario'][0]['MenuData'];
          permissions = resp['data']['usuario'][0]['Permiso'];
          token = resp['data']['token'];
        });
        prefs.setString('token', resp['data']['token']);
        prefs.setString('user', resp['data']['usuario'][0]['_id']);
        prefs.setString('mail', resp['data']['usuario'][0]['correo']);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Catalogo()),
        );
      }).catchError((jsonError) {
        errorMsg(
            this.context, 'Error Log in', 'Usuario o contraseña incorrecto.');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthApp = MediaQuery.of(context).size.width;
    double heightApp = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          body: SingleChildScrollView(
            padding:
                EdgeInsets.only(left: widthApp * .12, right: widthApp * .12),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: heightApp * .2),
                    child: Image.asset('images/logo.png')),
                Container(
                  child: TextFormField(
                    maxLength: 30,
                    controller: controllers['user'],
                    decoration: InputDecoration(
                      counterText: '',
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                      hintText: 'Usuario',
                      hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                      filled: true,
                      fillColor: Color(0xFFEBEBEB),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: heightApp * .015),
                  child: TextFormField(
                    obscureText: true,
                    maxLength: 100,
                    controller: controllers['password'],
                    decoration: InputDecoration(
                      counterText: '',
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                      hintText: 'Contraseña',
                      hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                      filled: true,
                      fillColor:
                          Color(0xFFEBEBEB), //,Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: heightApp * .015, bottom: heightApp * .05),
                    child: Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            logIn();
                          },
                          child: Container(
                            height: 52,
                            child: Center(
                                child: Text(
                              'Iniciar sesión',
                              style: TextStyle(fontSize: 15),
                            )),
                          ),
                        ))
                      ],
                    )),
                Divider(),
                Container(
                    margin: EdgeInsets.only(
                        top: heightApp * .015, bottom: heightApp * .05),
                    child: Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Cuenta()),
                            );
                          },
                          child: Container(
                            height: 52,
                            child: Center(
                                child: Text(
                              'Crear cuenta',
                              style: TextStyle(fontSize: 15),
                            )),
                          ),
                        ))
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
