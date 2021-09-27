import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';

class CuentaModel extends ChangeNotifier {
  final Map<String, TextEditingController> controllers = {
    'usuario': TextEditingController(),
    'nombre': TextEditingController(),
    'apellido': TextEditingController(),
    'documento': TextEditingController(),
    'telefono': TextEditingController(),
    'correo': TextEditingController(),
    'password': TextEditingController(),
  };

  Future<void> createCuenta() async {
    bool flag = true;
    Map<String, String> aux = {};
    controllers.forEach((key, value) {
      if (value.text == '') flag = false;
      aux.addAll({key: (key == 'password') ? '' : value.text});
    });

    if (flag) {
      try {
        await postRequest('usuario', {});
      } catch (e) {}
    }

    // User.usuario = req.body.usuario
    // User.cedula = req.body.cedula
    // User.nombre = req.body.nombre
    // User.apellido = req.body.apellido
    // User.correo = req.body.correo
    // User.telefono = req.body.telefono
    // User.password = req.body.password
  }
}
