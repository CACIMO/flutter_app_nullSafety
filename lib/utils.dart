import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/carrito.dart';
import 'package:flutter_app/configuracion.dart';
import 'package:flutter_app/historial.dart';
import 'package:flutter_app/login.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'newprod.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path/path.dart';
import 'catalogo.dart';
import 'models.dart';
//import 'package:device_info/device_info.dart';

String token = '';
String urlDB = '3.141.11.180:3000';
List menOptions = [];
String permissions = '';
Map pro = {
  'a': "604f9fedaaa8ce91e788e21f",
  'v': "6050ae3e96f425bd7bf19d3b",
  'b': "6050bc8b96f425bd7bf19d3c"
};

Map<String, Widget> options = {
  "604f9cf5aaa8ce91e788e217": MenuBtn(
      icono: Icon(CupertinoIcons.book),
      title: 'Catalogo',
      nextPage: Catalogo()),
  "604f9cf5aaa8ce91e788e218": MenuBtn(
      icono: Icon(CupertinoIcons.cart), title: 'Carrito', nextPage: Carrito()),
  "604f9cf5aaa8ce91e788e219": MenuBtn(
      icono: Icon(CupertinoIcons.tag),
      title: 'Nuevo Producto',
      nextPage: NuevoProd(prodInfo: null)),
  "604f9cf5aaa8ce91e788e21a": MenuBtn(
      icono: Icon(CupertinoIcons.tickets),
      title: 'Historial de Ventas',
      nextPage: Historial()),
  "604f9cf5aaa8ce91e788e21e": MenuBtn(
      icono: Icon(CupertinoIcons.square_arrow_left),
      title: 'Cerrar Sesión',
      nextPage: Login()),
  "604f9cf5aaa8ce91e788e21b": MenuBtn(
      icono: Icon(CupertinoIcons.qrcode_viewfinder),
      title: 'Escaner Qr',
      nextPage: Catalogo()),
  "604f9cf5aaa8ce91e788e21c": MenuBtn(
      icono: Icon(CupertinoIcons.arrow_down_doc),
      title: 'Descargar Formato',
      nextPage: Catalogo()),
  "604f9cf5aaa8ce91e788e21d": MenuBtn(
      icono: Icon(CupertinoIcons.settings),
      title: 'Configuracion',
      nextPage: Configuracion())
};

double mediaQuery(BuildContext ctx, String type, double factor) {
  Map query = {
    'w': MediaQuery.of(ctx).size.width,
    'h': MediaQuery.of(ctx).size.height,
    'o': MediaQuery.of(ctx).orientation.index,
  };

  return query[type] * factor;
}

Future<String> getDeviceInfo() async {
  String idDevice = 'TEMP';
  /* DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    idDevice = androidInfo.id;
  } else {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    idDevice = iosInfo.name;
  } */
  return idDevice;
}

void alertLoad(BuildContext ctx) async {
  return showDialog<void>(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return new AlertDialog(
            elevation: 0, backgroundColor: Colors.transparent, content: Load());
      });
}

/* void alertQrScanner(BuildContext ctx, Function callback) async {
  return showDialog<void>(
      barrierDismissible: true,
      context: ctx,
      builder: (BuildContext context) {
        return Container(child: QrScanner(callBack: callback, ctx: ctx));
      });
} */

Future httpGet(BuildContext ctx, urlRoute, bool loadDialog) async {
  if (loadDialog) alertLoad(ctx);
  String deviceInfo = await getDeviceInfo();
  var urlData = Uri.http(urlDB, urlRoute);
  var response = await http.get(urlData, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'access-token': token,
    'device-id': deviceInfo
  });
  if (loadDialog) Navigator.of(ctx, rootNavigator: true).pop();
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return Future.error(jsonDecode(response.body));
  }
}

Future httpPost(BuildContext ctx, urlRoute, Map<String, String>? data,
    bool loadDialog) async {
  if (loadDialog) alertLoad(ctx);
  String deviceInfo = await getDeviceInfo();

  var urlData = Uri.http(urlDB, urlRoute);
  var response = await http.post(urlData,
      headers: <String, String>{'access-token': token, 'device-id': deviceInfo},
      body: data);
  if (loadDialog) Navigator.of(ctx, rootNavigator: true).pop();
  if (response.statusCode == 200)
    return jsonDecode(response.body);
  else
    return Future.error(jsonDecode(response.body));
}

Future httpPut(BuildContext ctx, urlRoute, Map<String, String>? data,
    bool loadDialog) async {
  if (loadDialog) alertLoad(ctx);
  String deviceInfo = await getDeviceInfo();

  var urlData = Uri.http(urlDB, urlRoute);
  var response = await http.put(urlData,
      headers: <String, String>{'access-token': token, 'device-id': deviceInfo},
      body: data);
  if (loadDialog) Navigator.of(ctx, rootNavigator: true).pop();
  if (response.statusCode == 200)
    return jsonDecode(response.body);
  else
    return Future.error(jsonDecode(response.body));
}

Future<void> errorMsg(BuildContext ctx, String title, String msgx) {
  return showDialog<void>(
      context: ctx,
      builder: (BuildContext context) {
        return new AlertDialog(
            title: Text(title,
                style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: mediaQuery(ctx, 'h', .025))),
            content: Error(msg: msgx));
      });
}

Future<void> successMsg(BuildContext ctx, String msgx) {
  return showDialog<void>(
      context: ctx,
      builder: (BuildContext context) {
        return new AlertDialog(
            title: Text('Proceso exitoso',
                style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: mediaQuery(ctx, 'h', .025))),
            content: Success(msg: msgx));
      });
}

Future<void> actionMsg(BuildContext ctx, String msgx, Function okFunction) {
  return showDialog<void>(
      context: ctx,
      builder: (BuildContext context) {
        return new AlertDialog(
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar',
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: mediaQuery(ctx, 'h', .02)))),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    okFunction();
                  },
                  child: Text('Ok',
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: mediaQuery(ctx, 'h', .02))))
            ],
            title: Text('Alerta',
                style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: mediaQuery(ctx, 'h', .025))),
            content: ActionAlert(msg: msgx));
      });
}

Drawer menuOptions(ctx) {
  //it is added each option of menu
  List<Widget> opciones = [Divider()];
  if (access('admin'))
    opciones.add(MenuBtn(
        icono: Icon(CupertinoIcons.cloud_upload),
        title: 'Enviar Formato',
        nextPage: Container()));
  if (menOptions.length != 0)
    menOptions.forEach((op) {
      opciones.add(options[op['_id']] ?? Container());
    });
  return Drawer(
      child: Container(
          padding: EdgeInsets.only(
              top: mediaQuery(ctx, 'h', .08),
              left: mediaQuery(ctx, 'w', .05),
              right: mediaQuery(ctx, 'w', .05)),
          child: Column(children: [
            Row(children: [
              Expanded(
                  child: Container(
                      child: Text('Menu de Opciones',
                          style: TextStyle(
                              fontFamily: 'Roboto-Light',
                              fontSize: mediaQuery(ctx, 'h', .03)))))
            ]),
            Container(
                height: mediaQuery(ctx, 'h', .7),
                child: ListView(children: opciones)),
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: mediaQuery(ctx, 'h', .09),
                  child: Text('Version 1.2',
                      style:
                          TextStyle(fontFamily: 'Roboto-Light', fontSize: 15)),
                  alignment: Alignment.center,
                ))
              ],
            )
          ])));
}

bool access(String aux) {
  bool resp = false;
  switch (aux) {
    case 'venta':
      resp =
          (pro['a'] == permissions || pro['v'] == permissions) ? true : false;
      break;
    case 'eprod':
      resp =
          (pro['a'] == permissions || pro['b'] == permissions) ? true : false;
      break;
    case 'mprod':
      resp =
          (pro['a'] == permissions || pro['b'] == permissions) ? true : false;
      break;
    case 'aformat':
      resp =
          (pro['a'] == permissions || pro['b'] == permissions) ? true : false;
      break;
    case 'admin':
      resp = (pro['a'] == permissions) ? true : false;
      break;
  }
  return resp;
}

Future<void> alertQr(ctx, Map data) async {
  return showDialog<void>(
      //barrierDismissible: type == 'S'?false:true,
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
            content: Container(
                height: 200,
                child: InkWell(
                    onDoubleTap: () =>
                        _descargaFile(context, data, data['_id']),
                    child: SingleChildScrollView(
                        child: Center(
                            child: Container(
                                height: 200,
                                width: 200,
                                child: QrImage(
                                  data: jsonEncode(data),
                                  version: QrVersions.auto,
                                  size: 200,
                                  gapless: true,
                                )))))));
      });
}

Future<String> httpPostFile(BuildContext ctx, urlRoute,
    Map<String, String> data, File? imgFile, bool load) async {
  if (load) alertLoad(ctx);
  var headers = {'access-token': token};
  var stream =
      (imgFile != null) ? new http.ByteStream(imgFile.openRead()) : null;
  var length = (imgFile != null) ? await imgFile.length() : null;
  var uri = Uri.http(urlDB, urlRoute);
  var request = new http.MultipartRequest("POST", uri);
  request.headers.addAll(headers);
  var multipartFile = (imgFile != null)
      ? new http.MultipartFile('file', stream!, length!,
          filename: basename(imgFile.path))
      : null;
  if (multipartFile != null) request.files.add(multipartFile);
  request.fields.addAll(data);
  var response;
  try {
    response = await request.send();
  } catch (e) {
    return Future.error('Error en el server');
  }

  if (load) Navigator.of(ctx, rootNavigator: true).pop();
  if (response.statusCode != 200) {
    return Future.error('Error en el server');
  } else
    return 'Poducto Creado Correctamente';
}

Future<void> uploadMsg(
    BuildContext ctx, String msgx, Function upload, Function download) {
  return showDialog<void>(
      context: ctx,
      builder: (BuildContext context) {
        return new AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    download();
                    //Navigator.pop(context);
                  },
                  child: Text('Descargar Factura',
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: mediaQuery(ctx, 'h', .02)))),
              TextButton(
                  onPressed: () {
                    upload();
                    //Navigator.pop(context);
                  },
                  child: Text('Subir Factura',
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: mediaQuery(ctx, 'h', .02))))
            ],
            title: Text('Alerta',
                style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: mediaQuery(ctx, 'h', .025))),
            content: ActionAlert(msg: msgx));
      });
}

void _descargaFile(BuildContext ctx, Map data, String nameFile) async {
  alertLoad(ctx);
  bool permiso = await _checkPermission();
  if (permiso) {
    try {
      String jsonstr = jsonEncode(data);
      print(jsonstr);

      var urlData = Uri.http(urlDB, 'qrscann/$jsonstr').toString();
      print(urlData);

      var imgId = await ImageDownloader.downloadImage(urlData);
      var path = await ImageDownloader.findPath(imgId!);
      Navigator.of(ctx, rootNavigator: true).pop();
      OpenFile.open(path!)
          .then((value) => Navigator.of(ctx, rootNavigator: true).pop());
    } catch (onError) {
      errorMsg(ctx, 'Error ', 'Error al descargar QR');
    }
  }
}

Future<String> _findLocalPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

void _checkfolder() async {
  var _localPath = (await _findLocalPath()) + '/AMDBBFiles';
  final savedDir = Directory(_localPath);
  bool hasExisted = await savedDir.exists();
  if (!hasExisted) {
    savedDir.create();
  }
}

Future<bool> _checkPermission() async {
  final status = await Permission.storage.status;
  if (status != PermissionStatus.granted) {
    final result = await Permission.storage.request();
    if (result == PermissionStatus.granted) {
      _checkfolder();
      return true;
    }
  } else {
    _checkfolder();
    return true;
  }

  return false;
}

void cleanSessions() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future<bool> exitApp(context) async {
  actionMsg(context, 'Desea cerrar sesion?', () {
    cleanSessions();
    SystemNavigator.pop();
  });
  return false;
}

Future<void> downloadFormat(BuildContext ctx) {
  return showDialog<void>(
      context: ctx,
      builder: (BuildContext context) {
        return new AlertDialog(
            title: Text('Enviar Formato',
                style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: mediaQuery(ctx, 'h', .025))),
            content: Container(
                height: mediaQuery(ctx, 'h', .18),
                child: DateFormat(context: ctx)));
      });
}
