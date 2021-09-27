import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/config_controller.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/config_model.dart';
import 'package:flutter_app/view/drawer_fil_view.dart';
import 'package:flutter_app/view/drawer_menu_view.dart';
import 'package:provider/provider.dart';

class ColorView extends StatefulWidget {
  @override
  _ColorView createState() => new _ColorView();
}

class _ColorView extends State<ColorView> {
  final TextEditingController controllerBusq = TextEditingController();
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  GlobalKey filterKey = GlobalKey();
  bool consultar = true;
  ScrollController controllerScroll = new ScrollController();

  @override
  void initState() {
    getColor(context);
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
                        child: Text('Colores',
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
                            onPressed: () => newDataColorAlert(
                                context,
                                'Color',
                                (titulo, prim, seg) =>
                                    createColor(context, prim, seg, titulo)),
                            icon: Icon(CupertinoIcons.add, size: 18))))
              ]),
              Divider(),
              Column(
                  children: Provider.of<ConfigModel>(context)
                      .colores
                      .map((e) => Column(children: [
                            Row(children: [
                              Container(
                                width: 40,
                                height: 40,
                                child: Card(
                                    child: Container(
                                        width: 40,
                                        height: 40,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Color(
                                                int.parse('0xFF${e.primario}')),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(int.parse(
                                                    '0xFF${e.segundario}')),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25)))),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(e.titulo,
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Light',
                                            fontSize: mQ(context, 'w', .06)))),
                              ),
                              IconButton(
                                  icon: Icon(e.active
                                      ? CupertinoIcons.eye_slash
                                      : CupertinoIcons.eye),
                                  onPressed: () => updColor(context, e))
                            ]),
                            Divider()
                          ]))
                      .toList())
            ])));
  }
}
