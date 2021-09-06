import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/menu_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:provider/provider.dart';

void logIn(
    BuildContext context, Map<String, TextEditingController> controller) async {
  bool flag = false;
  alertLoad(context);
  Map<String, String> jsonAux = {
    'usuario': controller['user']!.text,
    'password':
        sha512.convert(utf8.encode(controller['password']!.text)).toString()
  };

  for (final key in jsonAux.keys) {
    if (jsonAux[key] == '') {
      flag = true;
      alertMessage(context, 'e', 'Login Error', 'Por favor ingrese su $key.');
      break;
    }
  }
  if (!flag) {
    Provider.of<UserModel>(context, listen: false)
        .loginUser(jsonAux)
        .then((value) => Provider.of<MenuController>(context, listen: false)
                .getMenu()
                .then((value) {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/catalogo');
            }))
        .catchError((error) {
      alertMessage(
          context, 'e', 'Login Error', 'Usuario o contraseña incorrectos.');
    });
  }

  //void

/*
    print(jsonAux);

    //it is validate that the fiels User and password aren't null or thant aren't in blanck
    

    if (!flag) {
      httpPost(this.context, 'login', jsonAux, true).then((resp) {
        print(resp);
        /*List aux = resp['data']['usuario'];
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
      */
      }).catchError((jsonError) {
        print(jsonError);
        errorMsg(
            this.context, 'Error Log in', 'Usuario o contraseña incorrecto.');
      });
    } */
}
