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
  print(jsonAux);
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
}

void logInCat(BuildContext context, Map data) async {
  bool flag = false;
  alertLoad(context);
  Map<String, String> jsonAux = {
    'usuario': data['user'],
    'password': data['pass']
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
        .then((value) {
      Provider.of<MenuController>(context, listen: false)
          .getMenu()
          .then((value) {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/catalogo');
      });
    }).catchError((error) {
      alertMessage(
          context, 'e', 'Login Error', 'Usuario o contraseña incorrectos.');
    });
  }
}
