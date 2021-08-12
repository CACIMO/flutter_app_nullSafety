import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/controller/producto_controller.dart';
import 'package:flutter_app/model/nuevo_prod_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void getListColorTalla(BuildContext context) {
  getColorsList(context);
  getTallasList(context);
}

void changeTallaProd(BuildContext context, String idTalla) {
  Provider.of<NuevoProdModel>(context, listen: false).changeTalla(idTalla);
}

void changeColorPro(BuildContext context, String idColor) {
  Provider.of<NuevoProdModel>(context, listen: false).changeColor(idColor);
}

void restVars(BuildContext context) {
  Provider.of<NuevoProdModel>(context, listen: false).resetVars();
}

void addNewCombi(BuildContext context) {
  bool statusCombi =
      Provider.of<NuevoProdModel>(context, listen: false).newCombi;
  if (!statusCombi) {
    Provider.of<NuevoProdModel>(context, listen: false).addNewCombi();
  } else
    alertMessage(context, 'w', 'Alerta',
        'Primiero debe guardar la combinacion anterior');
}

void addImgNew(BuildContext context) async {
  ImagePicker _picker = ImagePicker();
  XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  Provider.of<NuevoProdModel>(context, listen: false).setFile(image);
}

void clearData(BuildContext context) {
  Provider.of<NuevoProdModel>(context, listen: false).clear();
}

void removeLast(BuildContext context, bool isNew, int index) {
  if (isNew)
    Provider.of<NuevoProdModel>(context, listen: false).removeLast();
  else
    Provider.of<NuevoProdModel>(context, listen: false)
        .removeCombiByIndex(index);
}

void addCombiToArray(BuildContext context) {
  Provider.of<NuevoProdModel>(context, listen: false)
      .saveCombi()
      .then((value) => alertMessage(
          context, 's', 'Proceso exitoso', 'Combinacion agregada.'))
      .catchError((onError) {
    print(onError);
    alertMessage(context, 'e', 'Error', 'Faltan datos por llenar.');
  });
}

void saveNewProd(
    BuildContext context, Map<String, TextEditingController> controller) async {
  List combiList =
      Provider.of<NuevoProdModel>(context, listen: false).combiList;
  alertLoad(context);

  List<Map<String, dynamic>> auxCombi = [];
  List<File> arrayFiles = [];
  combiList.forEach((e) {
    List aux = (e['img'].path.split('/'));
    arrayFiles.add(e['img']);
    auxCombi.add({
      'talla': e['talla'],
      'color': e['color'],
      'cantidad': e['cantidad'],
      'imgFile': aux[aux.length - 1].split('.')[0]
    });
  });
  Map<String, String> data = {
    'titulo': controller['titulo']!.text,
    'cost': controller['costo']!.text,
    'refVendedora': controller['rfVend']!.text,
    'descripcion': controller['descripcion']!.text,
    'valor': controller['valor']!.text,
    'refInterna': controller['rfInt']!.text,
    'combinaciones': jsonEncode(auxCombi)
  };

  data.keys.forEach((key) async {
    if (key != 'combinaciones' && data[key] == '') {
      alertMessage(context, 'w', 'Alerta', 'Debe llenar todos los campos.');
      return Future.error('Debe llenar todos los campos.');
    } else if (key == 'combinaciones' && combiList.length == 0) {
      alertMessage(
          context, 'w', 'Alerta', 'Debe agregar minimo una combinacion.');
      return Future.error('Debe agregar minimo una combinacion.');
    }
  });
  try {
    await Provider.of<NuevoProdModel>(context, listen: false)
        .saveProd(data, arrayFiles)
        .then((value) {
      Navigator.pop(context);
      alertMessage(
              context, 's', 'Proceso exitoso', 'Producto agregado con exito')
          .then((value) =>
              Provider.of<NuevoProdModel>(context, listen: false).cleanCamps());
    });

    return;
  } catch (e) {
    Navigator.pop(context);
    return Future.error('');
  }
}

void getProducto(BuildContext context) {
  Provider.of<NuevoProdModel>(context, listen: false)
      .getProductInfo()
      .then((value) {
    // print('acabo');
  });
}

void resetView(BuildContext context) {
  Provider.of<NuevoProdModel>(context, listen: false).resetView();
}
