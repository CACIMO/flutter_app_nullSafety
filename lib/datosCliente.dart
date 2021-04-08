import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/pedido.dart';
import 'utils.dart';
//import 'pedido.dart';

class DatosCliente extends StatefulWidget {
  @override
  _DatosCliente createState() => new _DatosCliente();
}

class _DatosCliente extends State<DatosCliente> {
  String dropdownValue = 'I';

  Map<String, Map<String, String>> opciones = {
    'I': {'value': 'I', 'titulo': 'Seleccione una opcion'},
    'E': {'value': 'E', 'titulo': 'Efectivo'},
    'CE': {'value': 'CE', 'titulo': 'Contra Entrega'},
    'C': {'value': 'C', 'titulo': 'Consignacion'}
  };

  final Map<String, TextEditingController> controllers = {
    'documento': TextEditingController(),
    'nombre': TextEditingController(),
    'direccion': TextEditingController(),
    'barrio': TextEditingController(),
    'ciudad': TextEditingController(),
    'telefono': TextEditingController(),
    'envio': TextEditingController()
  };

  Future<String> getCsc() async {
    var data = await httpGet(context, 'csc', false);
    return data['data'][0]['csc'];
  }

  void guardarFormato() async {
    bool flag = true;
    Map<String, String> dataSend = {};

    for (final key in controllers.keys) {
      dataSend[key] = controllers[key]!.text;
      if (controllers[key]!.text == '') {
        flag = false;
        errorMsg(this.context, 'Error',
            'Verifique el campo ${key[0].toUpperCase()}${key.substring(1)}');
        break;
      }
    }
    dataSend['pago'] = dropdownValue;
    if (dropdownValue == 'I') {
      flag = false;
      errorMsg(this.context, 'Error', 'Verifique el campo Forma de Pago');
    }

      if (flag) {
      Navigator.push(this.context,
          MaterialPageRoute(builder: (ctx) => Pedido(dataClient: dataSend)));
    } 
  }

  // ignore: non_constant_identifier_names
  List<DropdownMenuItem> Drops = [];

  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controllers['envio']!.text = '0';

    Drops = opciones.keys.map<DropdownMenuItem<String>>((String key) {
      return DropdownMenuItem<String>(
        value: key,
        child: Text(opciones[key]!['titulo']!,
            style: TextStyle(fontSize: 15, fontFamily: 'Roboto-Light')),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        key: scafoldKey,
        drawer: Container(
            width: mediaQuery(ctx, 'w', .70), child: menuOptions(ctx)),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    top: mediaQuery(ctx, 'h', .05),
                    left: mediaQuery(ctx, 'w', .05),
                    right: mediaQuery(ctx, 'w', .05)),
                child: Column(children: [
                  Container(
                      //padding: EdgeInsets.only(top: mediaQuery(ctx, 'h',.05),
                      height: mediaQuery(ctx, 'h', .15),
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                              flex: 7,
                              child: Container(
                                  child: Text('Formato',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Light',
                                          fontSize:
                                              mediaQuery(ctx, 'h', .05))))),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  child: IconButton(
                                      onPressed: () => guardarFormato(),
                                      icon: Icon(
                                        CupertinoIcons.arrow_right_to_line_alt,
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
                                      top: mediaQuery(ctx, 'w', .01)),
                                  child: Text('Datos del Cliente',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Thin',
                                          fontSize:
                                              mediaQuery(ctx, 'h', .03)))))
                        ]),
                        Divider()
                      ])),
                  Container(
                      height: mediaQuery(ctx, 'h', .79),
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child:
                          ListView(padding: EdgeInsets.only(top: 0), children: [
                        Container(
                          //margin: EdgeInsets.only(top: mediaQuery(ctx, 'h',.015),
                          child: TextFormField(
                            controller: controllers['documento'],
                            keyboardType: TextInputType.number,
                            maxLength: 11,
                            decoration: InputDecoration(
                              counterText: '',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFEBEBEB), width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFEBEBEB), width: 1)),
                              hintText: 'Documento de Identidad',
                              labelText: 'Documento de Identidad',
                              hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                              fillColor: Color(
                                  0xFFEBEBEB), //,Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: mediaQuery(ctx, 'h', .015)),
                          child: TextFormField(
                            controller: controllers['nombre'],
                            maxLength: 100,
                            decoration: InputDecoration(
                              counterText: '',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFEBEBEB), width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFEBEBEB), width: 1)),
                              hintText: 'Nombre Cliente',
                              labelText: 'Nombre Cliente',
                              hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                              //filled: true,
                              fillColor: Color(
                                  0xFFEBEBEB), //,Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: mediaQuery(ctx, 'h', .015)),
                          child: TextFormField(
                            controller: controllers['direccion'],
                            maxLength: 60,
                            decoration: InputDecoration(
                              counterText: '',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFEBEBEB), width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFEBEBEB), width: 1)),
                              hintText: 'Dirección',
                              labelText: 'Dirección',
                              hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                              //filled: true,
                              fillColor: Color(
                                  0xFFEBEBEB), //,Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: mediaQuery(ctx, 'h', .015)),
                          child: TextFormField(
                            controller: controllers['barrio'],
                            maxLength: 30,
                            decoration: InputDecoration(
                              counterText: '',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFEBEBEB), width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFEBEBEB), width: 1)),
                              hintText: 'Barrio',
                              labelText: 'Barrio',
                              hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                              //filled: true,
                              fillColor: Color(
                                  0xFFEBEBEB), //,Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: mediaQuery(ctx, 'h', .015)),
                          child: TextFormField(
                            controller: controllers['ciudad'],
                            maxLength: 30,
                            decoration: InputDecoration(
                              counterText: '',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFEBEBEB), width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFEBEBEB), width: 1)),
                              hintText: 'Ciudad',
                              labelText: 'Ciudad',
                              hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                              //filled: true,
                              fillColor: Color(
                                  0xFFEBEBEB), //,Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: mediaQuery(ctx, 'h', .015)),
                            child: TextFormField(
                                controller: controllers['telefono'],
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    counterText: '',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFEBEBEB),
                                            width: 1)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFEBEBEB),
                                            width: 1)),
                                    hintText: 'Telefono',
                                    labelText: 'Telefono',
                                    hintStyle:
                                        TextStyle(color: Color(0xFFAAAAAA)),
                                    //filled: true,
                                    fillColor: Color(0xFFEBEBEB)))),
                        Container(
                            margin: EdgeInsets.only(
                                top: mediaQuery(ctx, 'h', .015)),
                            child: TextFormField(
                                controller: controllers['envio'],
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    counterText: '',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFEBEBEB),
                                            width: 1)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFEBEBEB),
                                            width: 1)),
                                    hintText: 'Costo de Envio',
                                    labelText: 'Costo de Envio',
                                    hintStyle:
                                        TextStyle(color: Color(0xFFAAAAAA)),
                                    //filled: true,
                                    fillColor: Color(0xFFEBEBEB)))),
                        Container(
                          child: Divider(),
                        ),
                        Container(
                            margin:
                                EdgeInsets.only(top: mediaQuery(ctx, 'h', .01)),
                            child: Text('Forma de Pago',
                                style: TextStyle(
                                    fontSize: mediaQuery(ctx, 'h', .018),
                                    fontFamily: 'Roboto-Regular'))),
                        Container(
                          margin:
                              EdgeInsets.only(top: mediaQuery(ctx, 'h', .01)),
                          child: Divider(),
                        ),
                        Container(
                            child: Row(children: [
                          Expanded(
                              child: Container(
                            child: DropdownButtonFormField(
                              
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: Color(
                                    0xFFEBEBEB), //,Colors.grey.withOpacity(0.5),
                              ),
                              onChanged: ( dynamic newValue) {
                                setState(() {
                                  dropdownValue = newValue.toString();
                                });
                              },
                              items: Drops,
                            ),
                          ))
                        ]))
                      ]))
                ]))));
  }
  /*
  Widget build(BuildContext ctx) {
 );
  }*/
}
