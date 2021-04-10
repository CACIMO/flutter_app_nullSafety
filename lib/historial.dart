import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_file/open_file.dart';
import 'utils.dart';
import 'resumen.dart';

class Historial extends StatefulWidget {
  @override
  _Historial createState() => new _Historial();
}

class _Historial extends State<Historial> {
  @override
  void initState() {
    super.initState();
    GetData();
  }

  Future<String> _findLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  void _uploadFile(formato) async {
    var img = await ImagePicker().getImage(source: ImageSource.gallery);
    if (img != null) {
      File imgFile = File(img.path);
      httpPostFile(context, 'fact/$formato', {'id': formato}, imgFile, true)
          .then((resp) {
        successMsg(this.context, 'Factura cargada correctamente')
            .then((value) => Navigator.pop(this.context));
      }).catchError((jsonError) {
        Navigator.pop(this.context);
        errorMsg(this.context, 'Error', 'Error en la subida')
            .then((value) => Navigator.pop(this.context));
      });
    }
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

  void descargaFile(BuildContext ctx, idFile, nameFile) async {
    alertLoad(ctx);
    bool permiso = await _checkPermission();
    String ruta = (await _findLocalPath()) + '/AMDBBFiles';

    if (!Directory(ruta).existsSync()) Directory(ruta).createSync();
    if (permiso) {
      var imgId =
          await ImageDownloader.downloadImage('http://$urlDB/fact/$idFile',
              destination: AndroidDestinationType.directoryDownloads
                ..inExternalFilesDir()
                ..subDirectory('$nameFile.jpg'));
      var path = await ImageDownloader.findPath(imgId!);
      Navigator.of(ctx, rootNavigator: true).pop();
      OpenFile.open(path!)
          .then((value) => Navigator.of(ctx, rootNavigator: true).pop());
    }
  }

  bool viewVentas = false;
  List<Step> stepersD = [];
  int _currentStep = 0;

  final TextEditingController controllerBusq = TextEditingController();

  List<dynamic> formatos = [];

  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();

  // ignore: non_constant_identifier_names
  void GetData() async {
    access('aformat') ? getFormatosAll() : getFormatos();
  }

  void getFormatos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('user')!;

    httpPost(context, 'getForm/null', {'vendedor': user}, true).then((resp) {
      Map<String, List> listFormt = {};
      resp['data'].forEach((data) {
        DateTime aux = DateTime.parse(data['fecha']);
        String time1 = '${aux.day}/${aux.month}/${aux.year}';
        bool flag = true;

        for (var key in listFormt.keys) {
          if (key == time1) {
            flag = false;
            listFormt[key]!.add(data);
            break;
          }
        }
        if (flag) listFormt[time1] = [data];
      });

      setState(() {
        stepersD = _stepsData(listFormt);
      });
    }).catchError((onError) {
      print(onError);
      errorMsg(this.context, 'Error', 'Error al Cargar');
    });
  }

  void getFormatosAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('user')!;

    httpGet(context, 'formato', true).then((resp) {
      Map<String, List> listFormt = {};
      resp['data'].forEach((data) {
        DateTime aux = DateTime.parse(data['fecha']);
        String time1 = '${aux.day}/${aux.month}/${aux.year}';
        bool flag = true;

        for (var key in listFormt.keys) {
          if (key == time1) {
            flag = false;
            listFormt[key]!.add(data);
            break;
          }
        }
        if (flag) listFormt[time1] = [data];
      });

      setState(() {
        stepersD = _stepsData(listFormt);
      });
    }).catchError((onError) {
      print(onError);
      errorMsg(this.context, 'Error', 'Error al Cargar');
    });
  }

  List<Step> _stepsData(Map<String, List> data) {
    List<Step> stepers = [];
    List<Widget> elements = [];
    data.forEach((String key, List forms) {
      elements = [];
      forms.forEach((info) {
        elements.add(Row(children: [
          Expanded(
              flex: 9,
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        this.context,
                        MaterialPageRoute(
                            builder: (ctx) => Resumen(format: info['_id'])));
                  },
                  child: Column(children: [
                    Row(children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            child: Text('FORMATO: ',
                                style: TextStyle(
                                    fontSize: mediaQuery(context, 'h', .017),
                                    color: Colors.black54,
                                    fontFamily: 'Roboto-Regular')),
                          )),
                      Expanded(
                          flex: 7,
                          child: Text('${info['formato']}',
                              style: TextStyle(
                                  fontSize: mediaQuery(context, 'h', .017),
                                  fontFamily: 'Roboto-Regular')))
                    ]),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(children: [
                        Expanded(
                            flex: 3,
                            child: Text('ETAPA: ',
                                style: TextStyle(
                                    fontSize: mediaQuery(context, 'h', .017),
                                    color: Colors.black54,
                                    fontFamily: 'Roboto-Regular'))),
                        Expanded(
                            flex: 7,
                            child: Text(
                                '${info['Etapa'][0]['titulo'].toString().toUpperCase()}',
                                style: TextStyle(
                                    fontSize: mediaQuery(context, 'h', .017),
                                    fontFamily: 'Roboto-Regular')))
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(children: [
                        Expanded(
                            flex: 3,
                            child: Text('TOTAL: ',
                                style: TextStyle(
                                    fontSize: mediaQuery(context, 'h', .017),
                                    color: Colors.black54,
                                    fontFamily: 'Roboto-Regular'))),
                        Expanded(
                            flex: 7,
                            child: Text(
                                '${NumberFormat.simpleCurrency().format(info['total'])}',
                                style: TextStyle(
                                    fontSize: mediaQuery(context, 'h', .017),
                                    fontFamily: 'Roboto-Regular')))
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(children: [
                        Expanded(
                            flex: 3,
                            child: Text('F. PAGO: ',
                                style: TextStyle(
                                    fontSize: mediaQuery(context, 'h', .017),
                                    color: Colors.black54,
                                    fontFamily: 'Roboto-Regular'))),
                        Expanded(
                            flex: 7,
                            child: Text(
                                '${info['FPago'][0]['titulo'].toString().toUpperCase()}',
                                style: TextStyle(
                                    fontSize: mediaQuery(context, 'h', .017),
                                    fontFamily: 'Roboto-Regular')))
                      ]),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text('CLIENTE: ',
                                      style: TextStyle(
                                          fontSize:
                                              mediaQuery(context, 'h', .017),
                                          color: Colors.black54,
                                          fontFamily: 'Roboto-Regular')))),
                          Expanded(
                              flex: 7,
                              child: Text(
                                  '${info['nombre'].toString().toUpperCase()}',
                                  style: TextStyle(
                                      fontSize: mediaQuery(context, 'h', .017),
                                      fontFamily: 'Roboto-Regular')))
                        ])),
                    Divider()
                  ]))),
          Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {
                    uploadMsg(
                        context,
                        'Factura Formato : ${info['formato']}',
                        () => access('venta')
                            ? _uploadFile(info['_id'])
                            : errorMsg(
                                context, 'Error de Acceso', 'No tienes acesso'),
                        () => descargaFile(
                            context, info['_id'], info['formato']));
                  },
                  icon: Icon(CupertinoIcons.square_favorites)))
        ]));
      });

      stepers.add(Step(
          title: Text(key,
              style: TextStyle(
                  fontSize: mediaQuery(context, 'h', .022),
                  fontFamily: 'Roboto-Regular')),
          content: Container(
              child: Column(children: [
            Divider(),
            Row(children: [
              Expanded(
                  child: Container(
                      child: Column(children: [
                Container(child: Container(child: Column(children: elements)))
              ])))
            ])
          ]))));
    });
    setState(() {
      if (data.keys.length > 0) viewVentas = true;
    });
    return stepers;
  }

  void _tapped(step) {
    setState(() {
      _currentStep = step;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        key: scafoldKey,
        drawer: Container(
            width: mediaQuery(context, 'w', .70), child: menuOptions(ctx)),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    top: mediaQuery(context, 'h', .05),
                    left: mediaQuery(context, 'w', .05),
                    right: mediaQuery(context, 'w', .05)),
                child: Column(children: [
                  Container(
                      height: mediaQuery(context, 'h', .15),
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                              flex: 9,
                              child: Container(
                                  child: Text('Ventas',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Light',
                                          fontSize:
                                              mediaQuery(context, 'h', .06))))),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  child: IconButton(
                                      onPressed: () {
                                        scafoldKey.currentState!.openDrawer();
                                      },
                                      icon: Icon(
                                        CupertinoIcons.sidebar_left,
                                        size: 18,
                                      ))))
                        ]),
                        Row(children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: mediaQuery(context, 'w', .01)),
                                  child: Text('Historial de Ventas',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Thin',
                                          fontSize:
                                              mediaQuery(context, 'h', .04)))))
                        ])
                      ])),
                  Divider(),
                  Column(children: [
                    Row(children: [
                      Expanded(
                          child: Container(
                              height: mediaQuery(context, 'h', .77),
                              child: !viewVentas
                                  ? Container()
                                  : Stepper(
                                      onStepTapped: (step) => _tapped(step),
                                      currentStep: _currentStep,
                                      controlsBuilder: (BuildContext context,
                                          {VoidCallback? onStepContinue,
                                          VoidCallback? onStepCancel}) {
                                        return Container();
                                      },
                                      //onStepCancel: () {},
                                      // onStepContinue: () {},
                                      steps: stepersD)))
                    ])
                  ])
                ]))));
  }
}

/*
 (controlsBuilder: (BuildContext context,
                                          {VoidCallback onStepContinue,
                                          VoidCallback onStepCancel}) {
                                        return Container();
                                      })

 */
