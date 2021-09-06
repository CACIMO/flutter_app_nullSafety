import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/controller/login_controller.dart';
import 'package:flutter_app/controller/general_controller.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  final Map<String, TextEditingController> controllers = {
    'user': TextEditingController(),
    'password': TextEditingController(),
  };

  Future<bool> _onBackPressed() async {
    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            body: SingleChildScrollView(
                padding: EdgeInsets.only(
                    left: mQ(context, 'w', .12), right: mQ(context, 'w', .12)),
                child: Column(children: [
                  Container(
                      margin: EdgeInsets.only(top: mQ(context, 'h', .2)),
                      child: Image.asset('images/logo.png')),
                  Container(
                      child: TextFormField(
                          maxLength: 30,
                          controller: controllers['user'],
                          decoration: InputDecoration(
                              counterText: '',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFEBEBEB), width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFEBEBEB), width: 1)),
                              hintText: 'Usuario',
                              hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                              filled: true,
                              fillColor: Color(0xFFEBEBEB)))),
                  Container(
                    margin: EdgeInsets.only(top: mQ(context, 'h', .015)),
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
                        fillColor: Color(0xFFEBEBEB),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: mQ(context, 'h', .015),
                          bottom: mQ(context, 'h', .05)),
                      child: Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              logIn(context, controllers);
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
                          top: mQ(context, 'h', .015),
                          bottom: mQ(context, 'w', .05)),
                      child: Row(children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  /*  Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Cuenta()),
                              ); */
                                },
                                child: Container(
                                    height: 52,
                                    child: Center(
                                        child: Text('Crear cuenta',
                                            style: TextStyle(fontSize: 15))))))
                      ]))
                ]))));
  }
}
