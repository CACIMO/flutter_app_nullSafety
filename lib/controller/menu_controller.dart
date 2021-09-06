import 'package:flutter/material.dart';
import 'package:flutter_app/model/modificar_prod_model.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:provider/provider.dart';

void changeView(BuildContext context, String ruta) {
  resetViews(context);
  if (ruta == '/catalogo')
    Provider.of<ProductosModel>(context, listen: false).getList(context, true);
  Navigator.pushNamed(context, ruta);
}

void resetViews(BuildContext context) {
  Provider.of<ModificarProdModel>(context, listen: false).resetView2();
}
