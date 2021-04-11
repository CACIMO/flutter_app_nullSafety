import 'package:flutter_app/qrScan.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Resumen extends StatefulWidget {
  final String format;

  const Resumen({Key? key, required this.format}) : super(key: key);
  @override
  _Resumen createState() => new _Resumen(this.format);
}

class _Resumen extends State<Resumen> {
  final String format;
  _Resumen(this.format);

  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  List prePed = [];
  Map carrito = {};
  int total = 0;

  Map<String, Map<String, String>> opciones = {
    'I': {'value': 'I', 'titulo': 'Seleccione una opcion'},
    'E': {'value': 'E', 'titulo': 'Efectivo'},
    'CE': {'value': 'CE', 'titulo': 'Contra Entrega'},
    'C': {'value': 'C', 'titulo': 'Consignacion'}
  };

  String? itemData;

  void getFormato(ctx) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('user')!;
    httpPut(ctx, 'formato', {'vendedor': user, 'formato': this.format}, true)
        .then((resp) {
      if (resp['data'].length > 0) {
        setState(() {
          carrito = resp['data'][0];
          prePed = carrito['Productos'];
        });
        print(prePed);
      }
    }).catchError((onError) {
      errorMsg(ctx, 'Error en el resumen', 'Error al cargar el resumen');
    });
  }

  Future<void> qrAlert() {
    return showDialog<void>(
        context: this.context,
        builder: (BuildContext ctx) {
          return QrScanner(callBack: (data) {
            procesarArticulo(data['_id']);
          });
        });
  }

  void procesarArticulo(id) {
    httpPost(context, 'qrscann/null', {'formatoId': this.format, 'itemId': id},
            true)
        .then((value) {
      Navigator.of(this.context, rootNavigator: true).pop();
      getFormato(this.context);
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    super.initState();
    getFormato(this.context);
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
                              flex: 7,
                              child: Container(
                                  child: Text('Resumen',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Light',
                                          fontSize:
                                              mediaQuery(context, 'h', .05))))),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  child: IconButton(
                                      onPressed: () {
                                        qrAlert();
                                      },
                                      icon: Icon(
                                        CupertinoIcons.qrcode_viewfinder,
                                        size: 18,
                                      )))),
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
                                  child: Text('Resumen de Venta',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Thin',
                                          fontSize:
                                              mediaQuery(context, 'h', .03)))))
                        ]),
                        Divider()
                      ])),
                  Container(
                      height: mediaQuery(context, 'h', .26),
                      child: Column(children: [
                        Row(children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: mediaQuery(context, 'h', .005)),
                            child: Text('NOMBRE DEL CLIENTE',
                                style: TextStyle(
                                    fontSize: mediaQuery(context, 'h', .016),
                                    color: Colors.black54,
                                    fontFamily: 'Roboto-Regular')),
                          )
                        ]),
                        Row(children: [
                          Container(
                            child: Text(
                                '${carrito['nombre'].toString().toUpperCase()}',
                                style: TextStyle(
                                    fontSize: mediaQuery(context, 'h', .017),
                                    fontFamily: 'Roboto-Regular')),
                          )
                        ]),
                        Row(children: [
                          Expanded(
                              flex: 6,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: mediaQuery(context, 'h', .015),
                                    bottom: mediaQuery(context, 'h', .005)),
                                child: Text('DIRECCIÓN',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .016),
                                        color: Colors.black54,
                                        fontFamily: 'Roboto-Regular')),
                              )),
                          Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: mediaQuery(context, 'h', .015),
                                    bottom: mediaQuery(context, 'h', .005)),
                                child: Text('TELEFONO',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .016),
                                        color: Colors.black54,
                                        fontFamily: 'Roboto-Regular')),
                              ))
                        ]),
                        Row(children: [
                          Expanded(
                              flex: 6,
                              child: Container(
                                child: Text(
                                    '${carrito['direccion'].toString().toUpperCase()}',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .017),
                                        fontFamily: 'Roboto-Regular')),
                              )),
                          Expanded(
                              flex: 4,
                              child: Container(
                                child: Text(
                                    '${carrito['telefono'].toString().toUpperCase()}',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .017),
                                        fontFamily: 'Roboto-Regular')),
                              ))
                        ]),
                        Row(children: [
                          Expanded(
                              flex: 6,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: mediaQuery(context, 'h', .015),
                                    bottom: mediaQuery(context, 'h', .005)),
                                child: Text('BARRIO',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .016),
                                        color: Colors.black54,
                                        fontFamily: 'Roboto-Regular')),
                              )),
                          Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: mediaQuery(context, 'h', .015),
                                    bottom: mediaQuery(context, 'h', .005)),
                                child: Text('CIUDAD',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .016),
                                        color: Colors.black54,
                                        fontFamily: 'Roboto-Regular')),
                              ))
                        ]),
                        Row(children: [
                          Expanded(
                              flex: 6,
                              child: Container(
                                child: Text(
                                    '${carrito['barrio'].toString().toUpperCase()}',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .017),
                                        fontFamily: 'Roboto-Regular')),
                              )),
                          Expanded(
                              flex: 4,
                              child: Container(
                                child: Text(
                                    '${carrito['ciudad'].toString().toUpperCase()}',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .017),
                                        fontFamily: 'Roboto-Regular')),
                              ))
                        ]),
                        Row(children: [
                          Expanded(
                              flex: 6,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: mediaQuery(context, 'h', .015),
                                    bottom: mediaQuery(context, 'h', .005)),
                                child: Text('METODO DE PAGO',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .016),
                                        color: Colors.black54,
                                        fontFamily: 'Roboto-Regular')),
                              )),
                          Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: mediaQuery(context, 'h', .015),
                                    bottom: mediaQuery(context, 'h', .005)),
                                child: Text('TOTAL',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .016),
                                        color: Colors.black54,
                                        fontFamily: 'Roboto-Regular')),
                              ))
                        ]),
                        Row(children: [
                          Expanded(
                              flex: 6,
                              child: Container(
                                child: Text(
                                    '${opciones[carrito['pago'] ?? 'I']!['titulo'].toString().toUpperCase()}',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .017),
                                        fontFamily: 'Roboto-Regular')),
                              )),
                          Expanded(
                              flex: 4,
                              child: Container(
                                child: Text(
                                    '${NumberFormat.simpleCurrency().format(carrito['total'] ?? 0)}',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .017),
                                        fontFamily: 'Roboto-Regular')),
                              ))
                        ]),
                        Divider()
                      ])),
                  Container(
                      height: mediaQuery(context, 'h', .53),
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 2),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: prePed.length,
                          itemBuilder: (context, i) {
                            var item = prePed[i];
                            //Obtener Titulo
                            // ignore: non_constant_identifier_names
                            Map Prod = carrito['Prods']
                                .where((e) => e['_id'] == item['id'])
                                .toList()[0];
                            // ignore: non_constant_identifier_names
                            Map Colores = carrito['Colores']
                                .where((e) => e['_id'] == item['color'])
                                .toList()[0];
                            // ignore: non_constant_identifier_names
                            Map Talla = carrito['Tallas']
                                .where((e) => e['_id'] == item['talla'])
                                .toList()[0];
                            print(Prod);
                            return Container(
                                child: Column(children: [
                              Row(children: [
                                Expanded(
                                    child: Container(
                                        height: mediaQuery(context, 'h', .15),
                                        //color: Colors.red,
                                        child: Column(children: [
                                          Row(children: [
                                            Expanded(
                                                flex: 3,
                                                child: Container(
                                                    height: mediaQuery(
                                                        context, 'h', .15),
                                                    width: mediaQuery(
                                                        context, 'h', .15),
                                                    child: CachedNetworkImage(
                                                        width: mediaQuery(
                                                            context, 'w', .7),
                                                        height: mediaQuery(
                                                            context, 'w', .7),
                                                        placeholder: (context,
                                                                url) =>
                                                            Container(
                                                                padding:
                                                                    EdgeInsets.all(
                                                                        30),
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        imageUrl:
                                                            'http://$urlDB/getimg/${Prod['_id']}'))),
                                            Expanded(
                                                flex: 7,
                                                child: Container(
                                                    height: mediaQuery(
                                                        context, 'h', .15),
                                                    child: Column(children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 7,
                                                              child: Container(
                                                                  // alignment: Alignment.centerRight,
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              2,
                                                                          left:
                                                                              10,
                                                                          bottom:
                                                                              2),
                                                                  child: Text(
                                                                      Prod[
                                                                          'titulo'],
                                                                      style: TextStyle(
                                                                          fontSize: mediaQuery(
                                                                              context,
                                                                              'h',
                                                                              .02),
                                                                          fontFamily:
                                                                              'Roboto-Light')))),
                                                          Expanded(
                                                              flex: 3,
                                                              child: (item[
                                                                          'restante'] ==
                                                                      0)
                                                                  ? Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.green[
                                                                              400],
                                                                          borderRadius: BorderRadius.circular(
                                                                              5)),
                                                                      child:
                                                                          Center(
                                                                        child: Text(
                                                                            'Finalizado',
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: mediaQuery(context, 'h', .013),
                                                                                fontFamily: 'Roboto-Medium')),
                                                                      ))
                                                                  : Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.orange[
                                                                              400],
                                                                          borderRadius: BorderRadius.circular(
                                                                              5)),
                                                                      child:
                                                                          Center(
                                                                        child: Text(
                                                                            'Pendiente',
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: mediaQuery(context, 'h', .013),
                                                                                fontFamily: 'Roboto-Medium')),
                                                                      )))
                                                        ],
                                                      ),
                                                      Row(children: [
                                                        Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    bottom: 5),
                                                            child: Text(
                                                                'Color:',
                                                                style: TextStyle(
                                                                    fontSize: mediaQuery(
                                                                        context,
                                                                        'h',
                                                                        .017),
                                                                    color: Colors
                                                                        .black54,
                                                                    fontFamily:
                                                                        'Roboto-Light'))),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  bottom: 5),
                                                          child: Column(
                                                            children: [
                                                              Row(children: [
                                                                Container(
                                                                  height: 16,
                                                                  width: 16,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4),
                                                                  child:
                                                                      Container(
                                                                    height: 16,
                                                                    width: 16,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(int.parse(
                                                                            '0xFF${Colores['segundario'] != '' ? Colores['segundario'] : Colores['primario']}')),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8)),
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                      color: Color(
                                                                          int.parse(
                                                                              '0xFF${Colores['primario']}')),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                )
                                                              ])
                                                            ],
                                                          ),
                                                        )
                                                      ]),
                                                      Row(children: [
                                                        Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    bottom: 5),
                                                            child: Text(
                                                                'Cantidad:',
                                                                style: TextStyle(
                                                                    fontSize: mediaQuery(
                                                                        context,
                                                                        'h',
                                                                        .017),
                                                                    color: Colors
                                                                        .black54,
                                                                    fontFamily:
                                                                        'Roboto-Light'))),
                                                        Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    bottom: 5),
                                                            child: Text(
                                                                item['cantidad']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize: mediaQuery(
                                                                        context,
                                                                        'h',
                                                                        .017),
                                                                    fontFamily:
                                                                        'Roboto-Light')))
                                                      ]),
                                                      Row(children: [
                                                        Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    bottom: 5),
                                                            child: Text(
                                                                'Tallas:',
                                                                style: TextStyle(
                                                                    fontSize: mediaQuery(
                                                                        context,
                                                                        'h',
                                                                        .017),
                                                                    color: Colors
                                                                        .black54,
                                                                    fontFamily:
                                                                        'Roboto-Light'))),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  bottom: 5),
                                                          child: Column(
                                                            children: [
                                                              Row(children: [
                                                                Container(
                                                                    padding: EdgeInsets.only(
                                                                        left: 2,
                                                                        right:
                                                                            2),
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            2),
                                                                    child: Text(
                                                                        Talla[
                                                                            'titulo'],
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Roboto-Regular',
                                                                            fontSize: mediaQuery(
                                                                                context,
                                                                                'h',
                                                                                .013))),
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        border:
                                                                            Border.all(color: Colors.black54),
                                                                        borderRadius: BorderRadius.circular(5)))
                                                              ])
                                                            ],
                                                          ),
                                                        )
                                                      ]),
                                                      Row(children: [
                                                        Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    bottom: 5),
                                                            child: Text(
                                                                'Valor:',
                                                                style: TextStyle(
                                                                    fontSize: mediaQuery(
                                                                        context,
                                                                        'h',
                                                                        .017),
                                                                    color: Colors
                                                                        .black54,
                                                                    fontFamily:
                                                                        'Roboto-Light'))),
                                                        Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    bottom: 5),
                                                            child: Text(
                                                                NumberFormat
                                                                        .simpleCurrency()
                                                                    .format(item[
                                                                        'valor'])
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize: mediaQuery(
                                                                        context,
                                                                        'h',
                                                                        .017),
                                                                    fontFamily:
                                                                        'Roboto-Light')))
                                                      ])
                                                    ])))
                                          ])
                                        ])))
                              ]),
                              Divider()
                            ]));
                          })),
                ]))));
  }
}
