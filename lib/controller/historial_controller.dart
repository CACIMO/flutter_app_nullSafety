import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/historial_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

void getHistorial(BuildContext context) {
  User aux = Provider.of<UserModel>(context, listen: false).user;
  Provider.of<HistorialModel>(context, listen: false).getHistorial(aux);
}

void setFormato(BuildContext context, Formato formato) {
  Provider.of<HistorialModel>(context, listen: false).setFormato(formato);
}

void goToResumen(BuildContext context, Formato formato) {
  setFormato(context, formato);
  Navigator.pushNamed(context, '/resumen');
}

Future<void> uploadFac(BuildContext context) async {
  ImagePicker _picker = ImagePicker();
  XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    alertLoad(context);
    Provider.of<HistorialModel>(context, listen: false)
        .addFactura(image)
        .then((value) => alertMessage(
            context, 's', 'Proceso exitoso', 'Factura guardada correctamente.'))
        .catchError((onError) => alertMessage(context, 'e', 'Error al subir',
            'Error al subir la imagen al server.'))
        .whenComplete(() async {
      User aux2 = Provider.of<UserModel>(context, listen: false).user;
      await Provider.of<HistorialModel>(context, listen: false)
          .getHistorial(aux2);
      Navigator.pop(context);
    });
  } else
    alertMessage(context, 'w', 'Atencion!', 'Debe seleccionar una imagen');
}

Future<void> descargarFactura(BuildContext context, String? imgId) async {
  if (imgId != null && imgId != 'null' && imgId != '') {
    alertLoad(context);
    var imageId = await ImageDownloader.downloadImage(
        "http://3.141.11.180:3000/formato/img/$imgId",
        destination: AndroidDestinationType.directoryDownloads
          ..inExternalFilesDir());
    Navigator.pop(context);
    var path = await ImageDownloader.findPath(imageId!);
    OpenFile.open(path!);
  }
}

Future<void> descontarProd(BuildContext context, String code) async {
  Map aux = jsonDecode(code);
  try {
    await putRequest('getForm/null', {
      'formato':
          Provider.of<HistorialModel>(context, listen: false).selected.formato,
      'idFor': Provider.of<HistorialModel>(context, listen: false).selected.id,
      'id': aux['id'],
      'color': aux['color'],
      'talla': aux['talla'],
    });

    await Provider.of<HistorialModel>(context, listen: false)
        .refrescarHistorial();
  } catch (e) {
    alertMessage(context, 'e', 'Error Interno', 'Error al descontar');
  }
}
