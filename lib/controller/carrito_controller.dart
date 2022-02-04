import 'package:flutter/material.dart';
import 'package:flutter_app/model/carrito_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:provider/provider.dart';

void getCarrito(BuildContext context) {
  Provider.of<CarritoModel>(context, listen: false).getCarrito(
      context, Provider.of<UserModel>(context, listen: false).user.cedula);
}
