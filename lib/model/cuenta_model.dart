import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';

class CuentaModel extends ChangeNotifier {
  final Map<String, TextEditingController> controllers = {
    'usuario': TextEditingController(),
    'nombre': TextEditingController(),
    'apellido': TextEditingController(),
    'cedula': TextEditingController(),
    'telefono': TextEditingController(),
    'correo': TextEditingController(),
    'password': TextEditingController(),
  };

  Future<void> createCuenta() async {
    bool flag = true;
    Map<String, String> aux = {};
    controllers.forEach((key, value) {
      if (value.text == '') flag = false;
      aux.addAll({
        key: (key == 'password')
            ? sha512.convert(utf8.encode(value.text)).toString()
            : value.text
      });
    });
    print(aux);
    if (flag) {
      try {
        await postRequest('usuario', aux);
        return;
      } catch (e) {
        return Future.error(e);
      }
    }
  }

  void clearData() {
    controllers.forEach((key, value) {
      value.text = '';
    });
    notifyListeners();
  }
}
