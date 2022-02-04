import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/controller/historial_controller.dart';
import 'package:flutter_app/model/historial_model.dart';
import 'package:intl/intl.dart';

class HistoryStep extends StatelessWidget {
  final Formato formato;
  final Function callback;
  const HistoryStep({Key? key, required this.formato, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Row(children: [
        Expanded(
            flex: 9,
            child: InkWell(
                onTap: () => goToResumen(context, formato),
                child: Column(children: [
                  Row(children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                          child: Text('Vendedor: ',
                              style: TextStyle(
                                  fontSize: mQ(context, 'h', .017),
                                  color: Colors.black54,
                                  fontFamily: 'Roboto-Regular')),
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(formato.vendedor,
                            style: TextStyle(
                                fontSize: mQ(context, 'h', .017),
                                fontFamily: 'Roboto-Regular')))
                  ]),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            child: Text('Fecha: ',
                                style: TextStyle(
                                    fontSize: mQ(context, 'h', .017),
                                    color: Colors.black54,
                                    fontFamily: 'Roboto-Regular')),
                          )),
                      Expanded(
                          flex: 7,
                          child: Text(
                              DateFormat.yMd().add_jm().format(formato.fecha),
                              style: TextStyle(
                                  fontSize: mQ(context, 'h', .017),
                                  fontFamily: 'Roboto-Regular')))
                    ]),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(children: [
                        Expanded(
                            flex: 3,
                            child: Container(
                              child: Text('Formato: ',
                                  style: TextStyle(
                                      fontSize: mQ(context, 'h', .017),
                                      color: Colors.black54,
                                      fontFamily: 'Roboto-Regular')),
                            )),
                        Expanded(
                            flex: 7,
                            child: Text(formato.formato,
                                style: TextStyle(
                                    fontSize: mQ(context, 'h', .017),
                                    fontFamily: 'Roboto-Regular')))
                      ])),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(children: [
                      Expanded(
                          flex: 3,
                          child: Text('Etapa: ',
                              style: TextStyle(
                                  fontSize: mQ(context, 'h', .017),
                                  color: Colors.black54,
                                  fontFamily: 'Roboto-Regular'))),
                      Expanded(
                          flex: 7,
                          child: Text(formato.etapa,
                              style: TextStyle(
                                  fontSize: mQ(context, 'h', .017),
                                  fontFamily: 'Roboto-Regular')))
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(children: [
                      Expanded(
                          flex: 3,
                          child: Text('Total: ',
                              style: TextStyle(
                                  fontSize: mQ(context, 'h', .017),
                                  color: Colors.black54,
                                  fontFamily: 'Roboto-Regular'))),
                      Expanded(
                          flex: 7,
                          child: Text(
                              '${NumberFormat.simpleCurrency().format(formato.total)}',
                              style: TextStyle(
                                  fontSize: mQ(context, 'h', .017),
                                  fontFamily: 'Roboto-Regular')))
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(children: [
                      Expanded(
                          flex: 3,
                          child: Text('M. Pago: ',
                              style: TextStyle(
                                  fontSize: mQ(context, 'h', .017),
                                  color: Colors.black54,
                                  fontFamily: 'Roboto-Regular'))),
                      Expanded(
                          flex: 7,
                          child: Text(formato.formaPago,
                              style: TextStyle(
                                  fontSize: mQ(context, 'h', .017),
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
                                child: Text('Cliente: ',
                                    style: TextStyle(
                                        fontSize: mQ(context, 'h', .017),
                                        color: Colors.black54,
                                        fontFamily: 'Roboto-Regular')))),
                        Expanded(
                            flex: 7,
                            child: Text(formato.cliente,
                                style: TextStyle(
                                    fontSize: mQ(context, 'h', .017),
                                    fontFamily: 'Roboto-Regular')))
                      ]))
                ]))),
        Expanded(
            flex: 1,
            child: IconButton(
                onPressed: () => callback(),
                icon: Icon(CupertinoIcons.arrow_down_doc)))
      ]),
      Divider()
    ]));
  }
}
