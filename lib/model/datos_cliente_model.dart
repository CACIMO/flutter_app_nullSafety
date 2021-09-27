import 'package:flutter/material.dart';

class FormatoModel extends ChangeNotifier {
  List<Map<String, String>> opciones = [
    {'value': 'I', 'titulo': 'Seleccione una opcion'},
    {'value': 'E', 'titulo': 'Efectivo'},
    {'value': 'CE', 'titulo': 'Contra Entrega'},
    {'value': 'C', 'titulo': 'Consignacion'}
  ];
  Map<String, TextEditingController> controllers = {
    'documento': TextEditingController(),
    'nombre': TextEditingController(),
    'direccion': TextEditingController(),
    'barrio': TextEditingController(),
    'ciudad': TextEditingController(),
    'telefono': TextEditingController(),
    'envio': TextEditingController(),
    'obs': TextEditingController()
  };

  String idSelect = 'I';

  void changeFPago(String value) {
    idSelect = value;
    notifyListeners();
  }

  void clearData() {
    controllers.keys.forEach((key) {
      controllers[key]!.text = '';
    });
    notifyListeners();
  }
}
