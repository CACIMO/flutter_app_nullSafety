import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:flutter_app/view/item_view.dart';
import 'package:provider/provider.dart';

class Catalogo extends StatefulWidget {
  @override
  _Catalogo createState() => new _Catalogo();
}

class _Catalogo extends State<Catalogo> {
  final TextEditingController controllerBusq = TextEditingController();
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  GlobalKey filterKey = GlobalKey();
  ScrollController controllerScroll = new ScrollController();

  void _scrollListener() {
    if (controllerScroll.position.extentAfter.round() == 0) {}
  }

  @override
  void initState() {
    controllerScroll..addListener(_scrollListener);
    Provider.of<ProductosModel>(context, listen: false).getList();
    super.initState();
  }

  @override
  void dispose() {
    controllerScroll..removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scafoldKey,
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
                        child: Text('Catalogo',
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
                            onPressed: () =>
                                scafoldKey.currentState!.openEndDrawer(),
                            icon: Icon(CupertinoIcons.slider_horizontal_3,
                                size: 18)))),
              ]),
              Divider(),
              Row(children: [
                Expanded(
                    child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 3,
                        child: Container(
                            width: mQ(context, 'w', .9),
                            child: TextFormField(
                                autofocus: false,
                                maxLength: 100,
                                controller: controllerBusq,
                                onChanged: (val) {
                                  //getProduct(context, controllerBusq.text);
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search_outlined,
                                        color: Color(0xFFAAAAAA), size: 20),
                                    counterText: '',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1)),
                                    hintText: 'Busqueda',
                                    hintStyle:
                                        TextStyle(color: Color(0xFFAAAAAA)),
                                    fillColor: Color(0xFFEBEBEB))))))
              ]),
              Divider(),
              Container(
                  height: mQ(context, 'h', .7),
                  child: ListView.builder(
                      itemCount:
                          Provider.of<ProductosModel>(context).listProds.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Producto(
                            prodData: Provider.of<ProductosModel>(context)
                                .listProds[index]);
                      }))
            ])));
  }
}
