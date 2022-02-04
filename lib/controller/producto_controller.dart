import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/drawer_fil_model.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:provider/provider.dart';

void sumCounter(BuildContext context) {
  Provider.of<ProductosModel>(context, listen: false).addCounter();
}

void resCounter(BuildContext context) {
  Provider.of<ProductosModel>(context, listen: false).lessCounter();
}

void changeColor(BuildContext context, String idColor) {
  Provider.of<ProductosModel>(context, listen: false).setSelectColor(idColor);
  Provider.of<ProductosModel>(context, listen: false).changeDropDown();
}

void changeTalla(BuildContext context, String idTalla) {
  Provider.of<ProductosModel>(context, listen: false).setSelectTalla(idTalla);
  Provider.of<ProductosModel>(context, listen: false).changeDropDown();
}

Future<void> findByname(BuildContext context, String controllerBus) async {
  Provider.of<ProductosModel>(context, listen: false).busqueda = controllerBus;
  Provider.of<ProductosModel>(context, listen: false).getList(context, true);
}

void refreshFinder(BuildContext context, TextEditingController controllerBus) {
  controllerBus.text = '';
  Provider.of<ProductosModel>(context, listen: false).busqueda = '';
  Provider.of<ProductosModel>(context, listen: false).getList(context, true);
}

void getColorsList(BuildContext context) {
  Provider.of<DrawerFilterModel>(context, listen: false).getColorFilter();
}

void getTallasList(BuildContext context) {
  Provider.of<DrawerFilterModel>(context, listen: false).getTallaFilter();
}

bool verifyPermisonToSale() {
  bool permiso = true;
  return permiso;
}

void addToCar(
    BuildContext context, Item prodData, TextEditingController precio) {
  if (verifyPermisonToSale()) {
    bool flagError = false;
    String auxError = '';
    if (Provider.of<ProductosModel>(context, listen: false).colorSelect ==
        'none') {
      flagError = true;
      auxError = 'Debe seleccionar un color';
    } else if (Provider.of<ProductosModel>(context, listen: false)
            .tallaSelect ==
        'none') {
      flagError = true;
      auxError = 'Debe seleccionar una talla';
    } else if (Provider.of<ProductosModel>(context, listen: false).counter <
        1) {
      flagError = true;
      auxError = 'Debe agregar  minimo una unidad';
    } else if (precio.text == '') {
      flagError = true;
      auxError = 'Debe ingresar el precio de venta';
    }

    if (flagError)
      alertMessage(context, 'e', 'Error carrito', auxError);
    else {
      alertLoad(context);
      Provider.of<ProductosModel>(context, listen: false)
          .addToCarrito(precio.text,
              Provider.of<UserModel>(context, listen: false).user.cedula)
          .then((value) {
        Navigator.pop(context);
        precio.text = '';
        Provider.of<ProductosModel>(context, listen: false).cleanProdInfo();
        alertMessage(context, 's', 'Proceso exitoso',
                'Articulo agregado correctamente')
            .then((value) {
          Navigator.pop(context);
          findByname(context,
              Provider.of<ProductosModel>(context, listen: false).busqueda);
        });
      }).catchError((onError) {
        Navigator.pop(context);
      });
    }
  } else {
    alertMessage(context, 'e', 'Error Privilegios',
        'Tu usaurio no puede realizar ventas');
  }
}

void shareImg(BuildContext context, String img) {
  descargarImgShare(
      context, Provider.of<ProductosModel>(context, listen: false).imgProd);
}

void showQr(BuildContext context, Item prodData) {
  bool flagError = false;
  String auxError = '';

  if (Provider.of<ProductosModel>(context, listen: false).colorSelect ==
      'none') {
    flagError = true;
    auxError = 'Debe seleccionar un color';
  } else if (Provider.of<ProductosModel>(context, listen: false).tallaSelect ==
      'none') {
    flagError = true;
    auxError = 'Debe seleccionar una talla';
  }

  if (flagError)
    alertMessage(context, 'e', 'Error QR Generator', auxError);
  else {
    Map aux = {
      'id':
          Provider.of<ProductosModel>(context, listen: false).prodSelected!.id,
      'color': Provider.of<ProductosModel>(context, listen: false).colorSelect,
      'talla': Provider.of<ProductosModel>(context, listen: false).tallaSelect
    };
    alertQR(context, aux);
  }
}
