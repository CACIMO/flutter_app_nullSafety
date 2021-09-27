import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/controller/historial_controller.dart';
import 'package:flutter_app/model/historial_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/view/drawer_fil_view.dart';
import 'package:flutter_app/view/drawer_menu_view.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Resumen extends StatefulWidget {
  const Resumen({Key? key}) : super(key: key);
  @override
  _Resumen createState() => new _Resumen();
}

class _Resumen extends State<Resumen> {
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    Provider.of<HistorialModel>(context).refrescarHistorial();
    Formato formato = Provider.of<HistorialModel>(context).selected;
    return Scaffold(
        key: scafoldKey,
        endDrawer: DrawerFilter(),
        drawer: DrawerMenu(),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(
                top: mQ(context, 'h', .05),
                bottom: mQ(context, 'h', .05),
                left: mQ(context, 'w', .05),
                right: mQ(context, 'w', .05)),
            child: Column(children: [
              Row(children: [
                Expanded(
                    flex: 8,
                    child: Container(
                        child: Text('Resumen',
                            style: TextStyle(
                                fontFamily: 'Roboto-Light',
                                fontSize: mQ(context, 'w', .08))))),
                Expanded(
                    flex: 1,
                    child: Container(
                        child: IconButton(
                            onPressed: () => uploadFac(context),
                            icon:
                                Icon(CupertinoIcons.arrow_up_doc, size: 18)))),
                Expanded(
                    flex: 1,
                    child: Container(
                        child: IconButton(
                            onPressed: () {
                              User aux2 =
                                  Provider.of<UserModel>(context, listen: false)
                                      .user;
                              if (aux2.permiso != '6050ae3e96f425bd7bf19d3b')
                                Navigator.pushNamed(context, '/qr');
                              else
                                alertMessage(context, 'e',
                                    'Acceso Restringido.', 'No tienes acceso');
                            },
                            icon: Icon(CupertinoIcons.qrcode_viewfinder,
                                size: 18)))),
              ]),
              Divider(),
              Column(children: [
                Container(
                    height: mQ(context, 'h', .35),
                    child: Column(children: [
                      Row(children: [
                        Container(
                          margin:
                              EdgeInsets.only(bottom: mQ(context, 'h', .005)),
                          child: Text('NOMBRE DEL CLIENTE',
                              style: TextStyle(
                                  fontSize: mQ(context, 'h', .016),
                                  color: Colors.black54,
                                  fontFamily: 'Roboto-Regular')),
                        )
                      ]),
                      Row(children: [
                        Container(
                          child: Text(formato.cliente,
                              style: TextStyle(
                                  fontSize: mQ(context, 'h', .017),
                                  fontFamily: 'Roboto-Regular')),
                        )
                      ]),
                      Row(children: [
                        Expanded(
                            flex: 6,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: mQ(context, 'h', .015),
                                  bottom: mQ(context, 'h', .005)),
                              child: Text('DIRECCIÓN',
                                  style: TextStyle(
                                      fontSize: mQ(context, 'h', .016),
                                      color: Colors.black54,
                                      fontFamily: 'Roboto-Regular')),
                            )),
                        Expanded(
                            flex: 4,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: mQ(context, 'h', .015),
                                  bottom: mQ(context, 'h', .005)),
                              child: Text('TELEFONO',
                                  style: TextStyle(
                                      fontSize: mQ(context, 'h', .016),
                                      color: Colors.black54,
                                      fontFamily: 'Roboto-Regular')),
                            ))
                      ]),
                      Row(children: [
                        Expanded(
                            flex: 6,
                            child: Container(
                              child: Text(formato.direccion,
                                  style: TextStyle(
                                      fontSize: mQ(context, 'h', .017),
                                      fontFamily: 'Roboto-Regular')),
                            )),
                        Expanded(
                            flex: 4,
                            child: Container(
                              child: Text(formato.telefono,
                                  style: TextStyle(
                                      fontSize: mQ(context, 'h', .017),
                                      fontFamily: 'Roboto-Regular')),
                            ))
                      ]),
                      Row(children: [
                        Expanded(
                            flex: 6,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: mQ(context, 'h', .015),
                                  bottom: mQ(context, 'h', .005)),
                              child: Text('BARRIO',
                                  style: TextStyle(
                                      fontSize: mQ(context, 'h', .016),
                                      color: Colors.black54,
                                      fontFamily: 'Roboto-Regular')),
                            )),
                        Expanded(
                            flex: 4,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: mQ(context, 'h', .015),
                                  bottom: mQ(context, 'h', .005)),
                              child: Text('CIUDAD',
                                  style: TextStyle(
                                      fontSize: mQ(context, 'h', .016),
                                      color: Colors.black54,
                                      fontFamily: 'Roboto-Regular')),
                            ))
                      ]),
                      Row(children: [
                        Expanded(
                            flex: 6,
                            child: Container(
                              child: Text(formato.barrio,
                                  style: TextStyle(
                                      fontSize: mQ(context, 'h', .017),
                                      fontFamily: 'Roboto-Regular')),
                            )),
                        Expanded(
                            flex: 4,
                            child: Container(
                              child: Text(formato.ciudad,
                                  style: TextStyle(
                                      fontSize: mQ(context, 'h', .017),
                                      fontFamily: 'Roboto-Regular')),
                            ))
                      ]),
                      Row(children: [
                        Expanded(
                            flex: 6,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: mQ(context, 'h', .015),
                                  bottom: mQ(context, 'h', .005)),
                              child: Text('METODO DE PAGO',
                                  style: TextStyle(
                                      fontSize: mQ(context, 'h', .016),
                                      color: Colors.black54,
                                      fontFamily: 'Roboto-Regular')),
                            )),
                        Expanded(
                            flex: 4,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: mQ(context, 'h', .015),
                                  bottom: mQ(context, 'h', .005)),
                              child: Text('TOTAL',
                                  style: TextStyle(
                                      fontSize: mQ(context, 'h', .016),
                                      color: Colors.black54,
                                      fontFamily: 'Roboto-Regular')),
                            ))
                      ]),
                      Row(children: [
                        Expanded(
                            flex: 6,
                            child: Container(
                              child: Text(formato.formaPago,
                                  style: TextStyle(
                                      fontSize: mQ(context, 'h', .017),
                                      fontFamily: 'Roboto-Regular')),
                            )),
                        Expanded(
                            flex: 4,
                            child: Container(
                              child: Text(
                                  '${NumberFormat.simpleCurrency().format(formato.total)}',
                                  style: TextStyle(
                                      fontSize: mQ(context, 'h', .017),
                                      fontFamily: 'Roboto-Regular')),
                            ))
                      ]),
                      Row(children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: mQ(context, 'h', .015),
                              bottom: mQ(context, 'h', .005)),
                          child: Text('OBSERVACIONES',
                              style: TextStyle(
                                  fontSize: mQ(context, 'h', .016),
                                  color: Colors.black54,
                                  fontFamily: 'Roboto-Regular')),
                        )
                      ]),
                      Row(children: [
                        Container(
                          child: Text(formato.observacion,
                              style: TextStyle(
                                  fontSize: mQ(context, 'h', .017),
                                  fontFamily: 'Roboto-Regular')),
                        )
                      ]),
                      Container(
                          alignment: Alignment.bottomCenter, child: Divider())
                    ])),
                Container(
                    height: mQ(context, 'h', .53),
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 0),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: formato.prods.length,
                        itemBuilder: (context, i) {
                          return ResumenItem(prod: formato.prods[i]);
                        }))
              ])
            ])));
  }
}

class ResumenItem extends StatelessWidget {
  final HistorialProd prod;
  const ResumenItem({Key? key, required this.prod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Row(children: [
        Expanded(
            child: Container(
                child: Column(children: [
          Row(children: [
            Expanded(
                flex: 3,
                child: Container(
                    child: CachedNetworkImage(
                        imageUrl: 'http://$urlDB/getimg/preview/${prod.id}'))),
            Expanded(
                flex: 7,
                child: Container(
                    child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 7,
                          child: Container(
                              padding:
                                  EdgeInsets.only(top: 2, left: 10, bottom: 2),
                              child: Text(prod.titulo,
                                  style: TextStyle(
                                      fontSize: mQ(context, 'h', .02),
                                      fontFamily: 'Roboto-Light')))),
                      Expanded(
                          flex: 3,
                          child: (prod.restante == 0)
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green[400],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text('Finalizado',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: mQ(context, 'h', .013),
                                            fontFamily: 'Roboto-Medium')),
                                  ))
                              : Container(
                                  decoration: BoxDecoration(
                                      color: Colors.orange[400],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text('Pendiente',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: mQ(context, 'h', .013),
                                            fontFamily: 'Roboto-Medium')),
                                  )))
                    ],
                  ),
                  Row(children: [
                    Container(
                        padding: EdgeInsets.only(left: 10, bottom: 5),
                        child: Text('Color:',
                            style: TextStyle(
                                fontSize: mQ(context, 'h', .017),
                                color: Colors.black54,
                                fontFamily: 'Roboto-Light'))),
                    Container(
                      padding: EdgeInsets.only(left: 10, bottom: 5),
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 10, bottom: 5),
                              child: Column(children: [
                                Row(children: [
                                  Container(
                                      height: 16,
                                      width: 16,
                                      padding: EdgeInsets.all(4),
                                      child: Container(
                                        height: 16,
                                        width: 16,
                                        decoration: BoxDecoration(
                                            color: Color(int.parse(
                                                '0xFF${prod.color.segundario != '' ? prod.color.segundario : prod.color.primario}')),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(int.parse(
                                              '0xFF${prod.color.primario}')),
                                          borderRadius:
                                              BorderRadius.circular(8)))
                                ])
                              ]))
                        ],
                      ),
                    )
                  ]),
                  Row(children: [
                    Container(
                        padding: EdgeInsets.only(left: 10, bottom: 5),
                        child: Text('Cantidad:',
                            style: TextStyle(
                                fontSize: mQ(context, 'h', .017),
                                color: Colors.black54,
                                fontFamily: 'Roboto-Light'))),
                    Container(
                        padding: EdgeInsets.only(left: 10, bottom: 5),
                        child: Text(prod.cantidad.toString(),
                            style: TextStyle(
                                fontSize: mQ(context, 'h', .017),
                                fontFamily: 'Roboto-Light')))
                  ]),
                  Row(children: [
                    Container(
                        padding: EdgeInsets.only(left: 10, bottom: 5),
                        child: Text('Restante:',
                            style: TextStyle(
                                fontSize: mQ(context, 'h', .017),
                                color: Colors.black54,
                                fontFamily: 'Roboto-Light'))),
                    Container(
                        padding: EdgeInsets.only(left: 10, bottom: 5),
                        child: Text(prod.restante.toString(),
                            style: TextStyle(
                                fontSize: mQ(context, 'h', .017),
                                fontFamily: 'Roboto-Light')))
                  ]),
                  Row(children: [
                    Container(
                        padding: EdgeInsets.only(left: 10, bottom: 5),
                        child: Text('Tallas:',
                            style: TextStyle(
                                fontSize: mQ(context, 'h', .017),
                                color: Colors.black54,
                                fontFamily: 'Roboto-Light'))),
                    Container(
                      padding: EdgeInsets.only(left: 10, bottom: 5),
                      child: Column(
                        children: [
                          Row(children: [
                            Container(
                                padding: EdgeInsets.only(left: 2, right: 2),
                                margin: EdgeInsets.only(left: 2),
                                child: Text(prod.talla,
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Regular',
                                        fontSize: mQ(context, 'h', .013))),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(color: Colors.black54),
                                    borderRadius: BorderRadius.circular(5)))
                          ])
                        ],
                      ),
                    )
                  ]),
                  Row(children: [
                    Container(
                        padding: EdgeInsets.only(left: 10, bottom: 5),
                        child: Text('Valor:',
                            style: TextStyle(
                                fontSize: mQ(context, 'h', .017),
                                color: Colors.black54,
                                fontFamily: 'Roboto-Light'))),
                    Container(
                        padding: EdgeInsets.only(left: 10, bottom: 5),
                        child: Text(
                            NumberFormat.simpleCurrency()
                                .format(prod.valor)
                                .toString(),
                            style: TextStyle(
                                fontSize: mQ(context, 'h', .017),
                                fontFamily: 'Roboto-Light')))
                  ])
                ])))
          ])
        ])))
      ]),
      Divider()
    ]));
  }
}
/**
 * 
 * 
 *   
 * 
 * 


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





     
                                  
 */
