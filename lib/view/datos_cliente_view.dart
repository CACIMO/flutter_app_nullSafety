import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/datos_cliente_controller.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/datos_cliente_model.dart';
import 'package:flutter_app/view/drawer_fil_view.dart';
import 'package:flutter_app/view/drawer_menu_view.dart';
import 'package:provider/provider.dart';

class FormatoView extends StatefulWidget {
  @override
  _FormatoView createState() => new _FormatoView();
}

class _FormatoView extends State<FormatoView> {
  final TextEditingController controllerBusq = TextEditingController();
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  GlobalKey filterKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, TextEditingController> controllers =
        Provider.of<FormatoModel>(context).controllers;
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
                        child: Text('Formato',
                            style: TextStyle(
                                fontFamily: 'Roboto-Light',
                                fontSize: mQ(context, 'w', .08))))),
                Expanded(
                    flex: 1,
                    child: Container(
                        child: IconButton(
                            onPressed: () =>
                                scafoldKey.currentState!.openDrawer(),
                            icon:
                                Icon(CupertinoIcons.sidebar_left, size: 18)))),
                Expanded(
                    flex: 1,
                    child: Container(
                        child: IconButton(
                            onPressed: () => saveDataC(context),
                            icon:
                                Icon(CupertinoIcons.arrow_up_doc, size: 18)))),
              ]),
              Divider(),
              Container(
                //margin: EdgeInsets.only(top: mQ(context, 'h',.015),
                child: TextFormField(
                  controller: controllers['documento'],
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  decoration: InputDecoration(
                    counterText: '',
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    hintText: 'Documento de Identidad',
                    labelText: 'Documento de Identidad',
                    hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    fillColor:
                        Color(0xFFEBEBEB), //,Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: mQ(context, 'h', .015)),
                child: TextFormField(
                  controller: controllers['nombre'],
                  maxLength: 100,
                  decoration: InputDecoration(
                    counterText: '',
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    hintText: 'Nombre Cliente',
                    labelText: 'Nombre Cliente',
                    hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    //filled: true,
                    fillColor:
                        Color(0xFFEBEBEB), //,Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: mQ(context, 'h', .015)),
                child: TextFormField(
                  controller: controllers['direccion'],
                  maxLength: 60,
                  decoration: InputDecoration(
                    counterText: '',
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    hintText: 'Dirección',
                    labelText: 'Dirección',
                    hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    //filled: true,
                    fillColor:
                        Color(0xFFEBEBEB), //,Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: mQ(context, 'h', .015)),
                child: TextFormField(
                  controller: controllers['barrio'],
                  maxLength: 30,
                  decoration: InputDecoration(
                    counterText: '',
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    hintText: 'Barrio',
                    labelText: 'Barrio',
                    hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    //filled: true,
                    fillColor:
                        Color(0xFFEBEBEB), //,Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: mQ(context, 'h', .015)),
                child: TextFormField(
                  controller: controllers['ciudad'],
                  maxLength: 30,
                  decoration: InputDecoration(
                    counterText: '',
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    hintText: 'Ciudad',
                    labelText: 'Ciudad',
                    hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    //filled: true,
                    fillColor:
                        Color(0xFFEBEBEB), //,Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: mQ(context, 'h', .015)),
                  child: TextFormField(
                      controller: controllers['telefono'],
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFEBEBEB), width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFEBEBEB), width: 1)),
                          hintText: 'Telefono',
                          labelText: 'Telefono',
                          hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                          //filled: true,
                          fillColor: Color(0xFFEBEBEB)))),
              Container(
                  margin: EdgeInsets.only(top: mQ(context, 'h', .015)),
                  child: TextFormField(
                      controller: controllers['envio'],
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFEBEBEB), width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFEBEBEB), width: 1)),
                          hintText: 'Costo de Envio',
                          labelText: 'Costo de Envio',
                          hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                          //filled: true,
                          fillColor: Color(0xFFEBEBEB)))),
              Container(
                  margin: EdgeInsets.only(top: mQ(context, 'h', .015)),
                  child: TextFormField(
                      controller: controllers['obs'],
                      maxLines: 5,
                      decoration: InputDecoration(
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFEBEBEB), width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFEBEBEB), width: 1)),
                          hintText: 'Observacion',
                          labelText: 'Observacion',
                          hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                          //filled: true,
                          fillColor: Color(0xFFEBEBEB)))),
              Container(
                child: Divider(),
              ),
              Container(
                  margin: EdgeInsets.only(top: mQ(context, 'h', .01)),
                  child: Text('Forma de Pago',
                      style: TextStyle(
                          fontSize: mQ(context, 'h', .018),
                          fontFamily: 'Roboto-Regular'))),
              Container(
                margin: EdgeInsets.only(top: mQ(context, 'h', .01)),
                child: Divider(),
              ),
              Container(
                  height: mQ(context, 'h', .08),
                  child: Row(children: [
                    Expanded(
                        child: DropdownButton<String>(
                      value: Provider.of<FormatoModel>(context).idSelect,
                      icon: Container(
                          child: const Icon(
                              CupertinoIcons.arrowtriangle_down_circle)),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (String? value) {
                        changeFPago(context, value ?? 'I');
                      },
                      items: Provider.of<FormatoModel>(context)
                          .opciones
                          .map<DropdownMenuItem<String>>((opcion) {
                        return DropdownMenuItem(
                            value: opcion['value'],
                            child: Container(
                                height: mQ(context, 'h', .03),
                                width: mQ(context, 'w', .8),
                                child: Text(opcion['titulo'] ?? '',
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Light',
                                        fontSize: mQ(context, 'h', .02)))));
                      }).toList(),
                    ))
                  ]))
            ])));
  }
}
