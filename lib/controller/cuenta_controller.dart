import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/cuenta_model.dart';
import 'package:provider/provider.dart';

void createCuenta(BuildContext context) {
  Provider.of<CuentaModel>(context, listen: false).createCuenta().then((value) {
    Provider.of<CuentaModel>(context, listen: false).clearData();
    alertMessage(context, 's', 'Nuevo usuario', 'Usuario creado con exito.');
  }).catchError((onError) {
    alertMessage(
        context, 'e', 'Nuevo usuario', 'No ha sido creado el usuario.');
  });
}
