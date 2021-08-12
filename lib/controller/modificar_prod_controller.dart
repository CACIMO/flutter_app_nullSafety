import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/controller/producto_controller.dart';
import 'package:flutter_app/model/modificar_prod_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void getListColorTalla(BuildContext context) {
  getColorsList(context);
  getTallasList(context);
}

void changeTallaProdMod(BuildContext context, String idTalla) {
  Provider.of<ModificarProdModel>(context, listen: false).changeTalla(idTalla);
}

void changeColorProMod(BuildContext context, String idColor) {
  Provider.of<ModificarProdModel>(context, listen: false).changeColor(idColor);
}

void restVars(BuildContext context) {
  Provider.of<ModificarProdModel>(context, listen: false).resetVars();
}

void addNewCombi(BuildContext context) {
  bool statusCombi =
      Provider.of<ModificarProdModel>(context, listen: false).newCombi;
  if (!statusCombi) {
    Provider.of<ModificarProdModel>(context, listen: false).addNewCombi();
  } else
    alertMessage(context, 'w', 'Alerta',
        'Primiero debe guardar la combinacion anterior');
}

void addImgNewMod(BuildContext context) async {
  ImagePicker _picker = ImagePicker();
  XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  Provider.of<ModificarProdModel>(context, listen: false).setFile(image);
}

void clearData(BuildContext context) {
  Provider.of<ModificarProdModel>(context, listen: false).clear();
}

void removeLastProd(BuildContext context, bool isNew, int index) {
  if (isNew)
    Provider.of<ModificarProdModel>(context, listen: false).removeLast();
  else
    Provider.of<ModificarProdModel>(context, listen: false)
        .removeCombiByIndex(index);
}

void addCombiToArrayMod(BuildContext context) {
  Provider.of<ModificarProdModel>(context, listen: false)
      .saveCombi()
      .then((value) => alertMessage(
          context, 's', 'Proceso exitoso', 'Combinacion agregada.'))
      .catchError((onError) {
    print(onError);
    alertMessage(context, 'e', 'Error', 'Faltan datos por llenar.');
  });
}

void updateProd(
    BuildContext context, Map<String, TextEditingController> controller) async {
  Map<String, String> data = {
    'titulo': controller['titulo']!.text,
    'costo': controller['costo']!.text,
    'refVendedora': controller['rfVend']!.text,
    'descripcion': controller['descripcion']!.text,
    'valor': controller['valor']!.text,
    'refInterna': controller['rfInt']!.text,
    'prod_id': Provider.of<ModificarProdModel>(context, listen: false).producto
  };

  data.keys.forEach((key) async {
    if (data[key] == '') {
      alertMessage(context, 'w', 'Alerta', 'Debe llenar todos los campos.');
      return Future.error('Debe llenar todos los campos.');
    }
  });
  try {
    await Provider.of<ModificarProdModel>(context, listen: false)
        .saveProd(data)
        .then((value) => alertMessage(
                context, 's', 'Proceso exitoso', 'Producto agregado con exito')
            .then((value) =>
                Provider.of<ModificarProdModel>(context, listen: false)
                    .cleanCamps()));

    return;
  } catch (e) {
    return Future.error('');
  }
}

void getProducto(BuildContext context) {
  Provider.of<ModificarProdModel>(context, listen: false)
      .getProductInfo()
      .then((value) {});
}

void resetView(BuildContext context) {
  Provider.of<ModificarProdModel>(context, listen: false).resetView();
}
