import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/controller/carrito_controller.dart';
import 'package:flutter_app/model/carrito_model.dart';
import 'package:flutter_app/model/modificar_prod_model.dart';
import 'package:flutter_app/model/nuevo_prod_model.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:flutter_app/view/producto_view.dart';
import 'package:provider/provider.dart';

import 'general_controller.dart';

void showProd(BuildContext context, Item prodData) {
  String route = getCurrentRoute(context);
  Provider.of<ProductosModel>(context, listen: false).cleanProdInfo();
  if (route == '/catalogo') {
    Provider.of<ProductosModel>(context, listen: false).setProd(prodData);
    prodData.combinaciones.forEach((combi) {
      int indexC =
          prodData.colores.indexWhere((color) => color.id == combi['color']);
      int indexT =
          prodData.tallas.indexWhere((talla) => talla.id == combi['talla']);

      Provider.of<ProductosModel>(context, listen: false)
          .addColorViewProd(prodData.colores[indexC]);

      Provider.of<ProductosModel>(context, listen: false)
          .addTallaViewProd(prodData.tallas[indexT]);
    });
    showModal(context);
  }
}

Future<void> showModal(BuildContext context) async {
  Provider.of<ProductosModel>(context, listen: false).colorSelect = 'none';
  Provider.of<ProductosModel>(context, listen: false).tallaSelect = 'none';
  return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.3),
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) {
        return ProductoView();
      });
}

void removeToListProd(BuildContext context, String id) {
  Provider.of<ProductosModel>(context, listen: false).removeItemList(id);
}

void removeProducto(BuildContext context, Item prodInfo) {
  String carritoId =
      Provider.of<CarritoModel>(context, listen: false).carritoId;
  String route = getCurrentRoute(context);
  if (route == '/catalogo') {
    removeProdCatalogo(prodInfo)
        .then((value) => alertMessage(context, 's', 'Proceso exitoso',
                'Producto eliminado con exito.')
            .then((value) => removeToListProd(context, prodInfo.id)))
        .catchError((onError) => alertMessage(context, 'e', 'Alerta',
            'Producto en uso, no es posible eliminarlo.'));
  } else {
    removeProdCarrito(prodInfo, carritoId)
        .then((value) => alertMessage(
                context, 's', 'Proceso exitoso', 'Producto removido con exito.')
            .then((value) => getCarrito(context)))
        .catchError((onError) => alertMessage(context, 'e', 'Error de datos',
            'Error de datos contacte a soporte'));
  }
}

void goToEditView(BuildContext context, String id) {
  Provider.of<ModificarProdModel>(context, listen: false).producto = id;
  Navigator.pushNamed(context, '/modifView');
}
