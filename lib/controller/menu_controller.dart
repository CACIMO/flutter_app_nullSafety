import 'package:flutter/material.dart';
import 'package:flutter_app/model/modificar_prod_model.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> changeView(BuildContext context, String ruta) async {
  resetViews(context);
  if (ruta == '/logout') {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushNamed(context, '/login');
  } else if (ruta == '/catalogo') {
    Provider.of<ProductosModel>(context, listen: false).getList(context, true);
    Navigator.pushNamed(context, ruta);
  } else {
    Navigator.pushNamed(context, ruta);
  }
}

void resetViews(BuildContext context) {
  Provider.of<ModificarProdModel>(context, listen: false).resetView2();
}
