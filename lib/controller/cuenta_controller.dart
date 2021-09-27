import 'package:flutter/material.dart';
import 'package:flutter_app/model/cuenta_model.dart';
import 'package:provider/provider.dart';

void createCuenta(BuildContext context) {
  Provider.of<CuentaModel>(context, listen: false)
      .createCuenta()
      .then((value) => null);
}
