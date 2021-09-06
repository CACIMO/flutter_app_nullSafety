import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/controller/nuevo_prod_controller.dart';
import 'package:flutter_app/model/nuevo_prod_model.dart';
import 'package:flutter_app/view/combinacion_view.dart';
import 'package:flutter_app/view/drawer_fil_view.dart';
import 'package:flutter_app/view/drawer_menu_view.dart';
import 'package:provider/provider.dart';

class NuevoProducto extends StatefulWidget {
  @override
  _NuevoProducto createState() => new _NuevoProducto();
}

class _NuevoProducto extends State<NuevoProducto> {
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String titulo = 'Nuevo Producto';
    if (Provider.of<NuevoProdModel>(context).isEdit) getProducto(context);
    Map<String, TextEditingController> controllers =
        Provider.of<NuevoProdModel>(context).controllers;
    List combinaciones = Provider.of<NuevoProdModel>(context).combiList;

    for (var i = 0; i < combinaciones.length; i++) {
      combinaciones[i].addAll({'index': i});
    }
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
                        child: Text(titulo,
                            style: TextStyle(
                                fontFamily: 'Roboto-Light',
                                fontSize: mQ(context, 'w', .075))))),
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
                            onPressed: () => saveNewProd(context, controllers),
                            icon:
                                Icon(CupertinoIcons.cloud_upload, size: 18)))),
              ]),
              Divider(),
              Column(children: [
                Row(children: [
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(
                              bottom: mQ(context, 'h', .012),
                              top: mQ(context, 'h', .005)),
                          child: TextFormField(
                              autofocus: false,
                              controller: controllers['titulo'],
                              maxLength: 30,
                              decoration: InputDecoration(
                                  counterText: '',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFEBEBEB), width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFEBEBEB), width: 1)),
                                  hintText: 'Titulo del Producto',
                                  labelText: 'Titulo del Producto',
                                  hintStyle:
                                      TextStyle(color: Color(0xFFAAAAAA)),
                                  //filled: true,
                                  fillColor: Color(0xFFEBEBEB)))))
                ]),
                Row(children: [
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(
                              bottom: mQ(context, 'h', .012),
                              top: mQ(context, 'h', .005)),
                          child: TextFormField(
                              controller: controllers['rfInt'],
                              autofocus: false,
                              maxLength: 30,
                              decoration: InputDecoration(
                                  counterText: '',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFEBEBEB), width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFEBEBEB), width: 1)),
                                  hintText: 'Refencia interna',
                                  labelText: 'Refencia interna',
                                  hintStyle:
                                      TextStyle(color: Color(0xFFAAAAAA)),
                                  //filled: true,
                                  fillColor: Color(0xFFEBEBEB)))))
                ]),
                Row(children: [
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(
                              bottom: mQ(context, 'h', .012),
                              top: mQ(context, 'h', .005)),
                          child: TextFormField(
                              autofocus: false,
                              controller: controllers['rfVend'],
                              maxLength: 30,
                              decoration: InputDecoration(
                                  counterText: '',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFEBEBEB), width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFEBEBEB), width: 1)),
                                  hintText: 'Refencia Vendedor@',
                                  labelText: 'Refencia Vendedor@',
                                  hintStyle:
                                      TextStyle(color: Color(0xFFAAAAAA)),
                                  //filled: true,
                                  fillColor: Color(0xFFEBEBEB)))))
                ]),
                Row(children: [
                  Expanded(
                      child: Container(
                          margin:
                              EdgeInsets.only(bottom: mQ(context, 'h', .012)),
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              autofocus: false,
                              controller: controllers['valor'],
                              maxLength: 7,
                              decoration: InputDecoration(
                                  counterText: '',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFEBEBEB), width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFEBEBEB), width: 1)),
                                  hintText: 'Valor de Venta',
                                  labelText: 'Valor de Venta',
                                  hintStyle:
                                      TextStyle(color: Color(0xFFAAAAAA)),
                                  fillColor: Color(0xFFEBEBEB)))))
                ]),
                Row(children: [
                  Expanded(
                      child: Container(
                          margin:
                              EdgeInsets.only(bottom: mQ(context, 'h', .012)),
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              autofocus: false,
                              controller: controllers['costo'],
                              maxLength: 7,
                              decoration: InputDecoration(
                                  counterText: '',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFEBEBEB), width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFEBEBEB), width: 1)),
                                  hintText: 'Costo',
                                  labelText: 'Costo',
                                  hintStyle:
                                      TextStyle(color: Color(0xFFAAAAAA)),
                                  fillColor: Color(0xFFEBEBEB)))))
                ]),
                Row(children: [
                  Expanded(
                      child: Container(
                          margin:
                              EdgeInsets.only(bottom: mQ(context, 'h', .012)),
                          child: TextFormField(
                              autofocus: false,
                              maxLines: 5,
                              controller: controllers['descripcion'],
                              maxLength: 100,
                              decoration: InputDecoration(
                                  counterText: '',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFEBEBEB), width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFEBEBEB), width: 1)),
                                  hintText: 'Descripción',
                                  hintStyle:
                                      TextStyle(color: Color(0xFFAAAAAA)),
                                  fillColor: Color(0xFFEBEBEB)))))
                ]),
                Row(children: [
                  Expanded(
                      flex: 9,
                      child: Container(
                          child: Text('Combinaciones',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Light',
                                  fontSize: mQ(context, 'w', .06))))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          child: IconButton(
                              onPressed: () => addNewCombi(context),
                              icon: Icon(CupertinoIcons.plus_app, size: 18)))),
                ]),
                Visibility(
                  visible: Provider.of<NuevoProdModel>(context).newCombi,
                  child: Row(children: [
                    Combinacion(
                        isNew: true, prov: Provider.of<NuevoProdModel>(context))
                  ]),
                ),
                Container(
                    height: mQ(context, 'h', .2),
                    child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: combinaciones.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Combinacion(
                              isNew: false,
                              data: combinaciones[index],
                              prov: Provider.of<NuevoProdModel>(context));
                        }))
              ])
            ])));
  }
}
