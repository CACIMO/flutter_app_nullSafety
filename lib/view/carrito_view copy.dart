import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/carrito_controller.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/carrito_model.dart';
import 'package:flutter_app/view/drawer_fil_view.dart';
import 'package:flutter_app/view/drawer_menu_view.dart';
import 'package:flutter_app/view/item_view.dart';
import 'package:provider/provider.dart';

class Configuracion extends StatefulWidget {
  @override
  _Configuracion createState() => new _Configuracion();
}

class _Configuracion extends State<Configuracion> {
  final TextEditingController controllerBusq = TextEditingController();
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  GlobalKey filterKey = GlobalKey();
  bool consultar = true;
  ScrollController controllerScroll = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        child: Text('Configuracion',
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
                            onPressed: () {
                              print('');
                            },
                            icon:
                                Icon(CupertinoIcons.doc_richtext, size: 18)))),
              ]),
              Divider(),
            ])));
  }
}
