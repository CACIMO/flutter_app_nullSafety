import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/config_controller.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/controller/historial_controller.dart';
import 'package:flutter_app/model/historial_model.dart';
import 'package:flutter_app/view/drawer_fil_view.dart';
import 'package:flutter_app/view/drawer_menu_view.dart';
import 'package:flutter_app/view/historial_step.dart';
import 'package:provider/provider.dart';

class Historial extends StatefulWidget {
  @override
  _Historial createState() => new _Historial();
}

class _Historial extends State<Historial> {
  final TextEditingController controllerBusq = TextEditingController();
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  GlobalKey filterKey = GlobalKey();
  bool consultar = true;
  ScrollController controllerScroll = new ScrollController();

  @override
  void initState() {
    getHistorial(context);
    getUsers(context);
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
                        child: Text('Historial',
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
                                openFilters(context, 'e', 'Filtros', 'mensaje'),
                            icon: Icon(CupertinoIcons.slider_horizontal_3,
                                size: 18)))),
              ]),
              Divider(),
              Column(
                  children: Provider.of<HistorialModel>(context)
                      .formatos
                      .map((formato) => HistoryStep(
                          formato: formato,
                          callback: () =>
                              descargarFactura(context, formato.fac)))
                      .toList())
            ])));
  }
}
