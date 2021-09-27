import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/view/drawer_fil_view.dart';
import 'package:flutter_app/view/drawer_menu_view.dart';

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
              ]),
              Divider(),
              Container(
                  height: 50,
                  child: InkWell(
                      onTap: () => Navigator.pushNamed(context, '/color'),
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                child: Icon(CupertinoIcons.color_filter,
                                    color: Colors.black87, size: 20))),
                        Expanded(
                            flex: 9,
                            child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('Colores',
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Light',
                                        fontSize: 18))))
                      ]))),
              Divider(),
              Container(
                  height: 50,
                  child: InkWell(
                      onTap: () => Navigator.pushNamed(context, '/categoria'),
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                child: Icon(
                                    CupertinoIcons.square_stack_3d_down_right,
                                    color: Colors.black87,
                                    size: 20))),
                        Expanded(
                            flex: 9,
                            child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('Categorias',
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Light',
                                        fontSize: 18))))
                      ]))),
              Divider(),
              Container(
                  height: 50,
                  child: InkWell(
                      onTap: () => Navigator.pushNamed(context, '/tag'),
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                child: Icon(CupertinoIcons.number,
                                    color: Colors.black87, size: 20))),
                        Expanded(
                            flex: 9,
                            child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('Tags',
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Light',
                                        fontSize: 18))))
                      ]))),
              Divider(),
              Container(
                  height: 50,
                  child: InkWell(
                      onTap: () => Navigator.pushNamed(context, '/talla'),
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                child: Icon(CupertinoIcons.minus_slash_plus,
                                    color: Colors.black87, size: 20))),
                        Expanded(
                            flex: 9,
                            child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('Tallas',
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Light',
                                        fontSize: 18))))
                      ]))),
              Divider(),
              Container(
                  height: 50,
                  child: InkWell(
                      onTap: () => Navigator.pushNamed(context, '/userconf'),
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                child: Icon(CupertinoIcons.person_2,
                                    color: Colors.black87, size: 20))),
                        Expanded(
                            flex: 9,
                            child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('Usuarios',
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Light',
                                        fontSize: 18))))
                      ]))),
              Divider()
            ])));
  }
}
