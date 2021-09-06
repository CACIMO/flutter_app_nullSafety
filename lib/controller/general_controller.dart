import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/model/modificar_prod_model.dart';
import 'package:flutter_app/view/alert_component.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

String urlDB = '3.141.11.180:3000';

double mQ(BuildContext ctx, String type, double factor) {
  Map query = {
    'w': MediaQuery.of(ctx).size.width,
    'h': MediaQuery.of(ctx).size.height,
    'o': MediaQuery.of(ctx).orientation.index,
  };
  return query[type] * factor;
}

Future getRequest(urlRoute) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  var urlData = Uri.http(urlDB, urlRoute);
  var response = await http.get(urlData, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'access-token': token,
    'device-id': 'deviceInfo'
  });
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return Future.error(jsonDecode(response.body));
  }
}

Future postRequest(String urlRoute, Map<String, String>? data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  var urlData = Uri.http(urlDB, urlRoute);
  var response = await http.post(urlData,
      headers: <String, String>{
        'access-token': token,
        'device-id': 'deviceInfo'
      },
      body: data);
  if (response.statusCode == 200)
    return jsonDecode(response.body);
  else
    return Future.error(jsonDecode(response.body));
}

Future putRequest(String urlRoute, Map<String, String>? data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  var urlData = Uri.http(urlDB, urlRoute);
  var response = await http.put(urlData,
      headers: <String, String>{'access-token': token}, body: data);
  if (response.statusCode == 200)
    return jsonDecode(response.body);
  else
    return Future.error(jsonDecode(response.body));
}

Future deleteRequest(String urlRoute, Map<String, String>? data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  var urlData = Uri.http(urlDB, urlRoute);
  var response = await http.delete(urlData,
      headers: <String, String>{'access-token': token}, body: data);
  if (response.statusCode == 200)
    return jsonDecode(response.body);
  else
    return Future.error(jsonDecode(response.body));
}

Future<void> alertMessage(
    BuildContext ctx, String type, String titulo, String mensaje) {
  return showDialog<void>(
      context: ctx,
      builder: (BuildContext context) {
        return new AlertDialog(
            title: Text(titulo,
                style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: mQ(context, 'h', .025))),
            content: Container(
                height: mQ(context, 'h', .08),
                child: AlertComponent(msg: mensaje, type: type)));
      });
}

Future<void> stockAlert(BuildContext ctx, data, Function function) {
  return showDialog<void>(
      context: ctx,
      builder: (BuildContext context) {
        return new AlertDialog(
            title: Text('Cambiar Stock',
                style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: mQ(context, 'h', .025))),
            content: Container(
                height: mQ(context, 'h', .15),
                child: StockAlert(
                  data: data,
                  funcion: function,
                )));
      });
}

Future<void> saveStock(
    BuildContext context, String combincion, String stock) async {
  alertLoad(context);
  Map<String, String> data = {
    'combi': combincion,
    'stock': stock,
    'id': Provider.of<ModificarProdModel>(context, listen: false).producto
  };
  try {
    if (combincion != '' && stock != '') {
      await postRequest('updateproducto', data);
      Navigator.pop(context);
      alertMessage(
              context, 's', 'Proceso Exitoso', 'Se ha modificado el Stock.')
          .then((value) {
        Navigator.pop(context);
        return;
      });
    } else {
      alertMessage(context, 'e', 'Error', 'Error 1.1 contacte a soporte');
    }
  } catch (e) {
    Navigator.pop(context);
    return Future.error(e);
  }
}

Future<bool> exitApp(context) async {
  /* actionMsg(context, 'Desea cerrar sesion?', () {
    cleanSessions();
    SystemNavigator.pop();
  }); */
  return false;
}

String getCurrentRoute(BuildContext context) {
  return (ModalRoute.of(context)!.settings.name).toString();
}

Future postFileRequest(
    String urlRoute, Map<String, String> data, List<File> arrayFiles) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  var headers = {'access-token': token};
  var uri = Uri.http(urlDB, urlRoute);
  var stream;

  List<http.MultipartFile> multipartArray = [];

  arrayFiles.forEach((File file) {
    List aux = (file.path.split('/'));
    stream = new http.ByteStream(file.openRead());
    int peso = file.lengthSync();

    multipartArray.add(http.MultipartFile('file', stream, peso,
        filename: (aux[aux.length - 1])));
  });
  var request = new http.MultipartRequest("PUT", uri);
  request.headers.addAll(headers);
  request.fields.addAll(data);
  request.files.addAll(multipartArray);

  var response;
  try {
    response = await request.send();
  } catch (e) {
    return Future.error('Error en el server');
  }

  if (response.statusCode != 200)
    return Future.error('Error en el server');
  else
    return;
}

Future<void> alertLoad(BuildContext ctx) {
  return showDialog<void>(
      context: ctx,
      builder: (BuildContext context) {
        return new AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
                color: Colors.transparent,
                height: mQ(context, 'h', 1),
                child: Center(
                  child: CircularProgressIndicator(),
                )));
      });
}

Future<void> descargarImgShare(BuildContext context, String? imgId) async {
  final RenderBox box = context.findRenderObject() as RenderBox;
  if (imgId != null && imgId != 'null' && imgId != '') {
    alertLoad(context);
    var imageId = await ImageDownloader.downloadImage(imgId,
        destination: AndroidDestinationType.directoryDownloads
          ..inExternalFilesDir());
    Navigator.pop(context);
    var path = await ImageDownloader.findPath(imageId!);

    Share.shareFiles([path.toString()],
        text: 'text',
        subject: 'subject',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}

Future<void> alertQR(BuildContext ctx, Map data) {
  GlobalKey ikey = new GlobalKey();

  return showDialog<void>(
      context: ctx,
      builder: (BuildContext context) {
        return new AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
                color: Colors.transparent,
                height: mQ(context, 'h', 1),
                child: Center(
                    child: Container(
                  alignment: Alignment.center,
                  width: 400,
                  child: InkWell(
                    onTap: () async {
                      try {
                        Directory directory = (await getTemporaryDirectory());
                        RenderRepaintBoundary boundary = ikey.currentContext!
                            .findRenderObject()! as RenderRepaintBoundary;
                        ui.Image image = await boundary.toImage();
                        ByteData? byteData = await image.toByteData(
                            format: ui.ImageByteFormat.png);
                        Uint8List pngBytes = byteData!.buffer.asUint8List();
                        File imgFile = new File('${directory.path}/aux.png');
                        imgFile.writeAsBytes(pngBytes);
                        Share.shareFiles([imgFile.path.toString()],
                            text: 'text', subject: 'subject');
                      } catch (exception) {
                        print(exception);
                      }
                    },
                    child: RepaintBoundary(
                        key: ikey,
                        child: QrImage(
                          data: jsonEncode(data),
                          version: 10,
                          backgroundColor: Colors.white,
                        )),
                  ),
                ))));
      });
}
