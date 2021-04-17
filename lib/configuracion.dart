import 'catConfig.dart';
import 'tagConfig.dart';
import 'tallaConfig.dart';
import 'userConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colorConfig.dart';
import 'utils.dart';

class Configuracion extends StatefulWidget {
  @override
  _Configuracion createState() => new _Configuracion();
}

class _Configuracion extends State<Configuracion> {
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();

  @override
  Widget build(BuildContext ctx) {
    return WillPopScope(
      onWillPop: () => exitApp(context),
      child: Scaffold(
          key: scafoldKey,
          drawer: Container(
              width: mediaQuery(context, 'w', .70), child: menuOptions(ctx)),
          body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      top: mediaQuery(context, 'h', .05),
                      left: mediaQuery(context, 'w', .05),
                      right: mediaQuery(context, 'w', .05)),
                  child: Column(children: [
                    Container(
                        //padding: EdgeInsets.only(top: mediaQuery(context, 'h', .05),
                        height: mediaQuery(context, 'h', .15),
                        child: Column(children: [
                          Row(children: [
                            Expanded(
                                flex: 9,
                                child: Container(
                                    child: Text('Configuracion',
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Light',
                                            fontSize: mediaQuery(
                                                context, 'h', .05))))),
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
                                        top: mediaQuery(context, 'w', .01)),
                                    child: Text('Parametrizacion',
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Thin',
                                            fontSize: mediaQuery(
                                                context, 'h', .03)))))
                          ]),
                          Divider()
                        ])),
                    Column(children: [
                      Row(children: [
                        Expanded(
                            child: Container(
                                child: Text('MENU DE OPCIONES',
                                    style: TextStyle(
                                        fontFamily: 'Roboto-light',
                                        fontSize:
                                            mediaQuery(context, 'h', .015)))))
                      ]),
                      Divider(),
                      Container(
                          height: mediaQuery(context, 'h', .75),
                          padding: EdgeInsets.only(top: 2),
                          child: SingleChildScrollView(
                              child: Column(children: [
                            Container(
                                height: 50,
                                child: InkWell(
                                    onTap: () => Navigator.push(
                                        ctx,
                                        MaterialPageRoute(
                                            builder: (ctx) => ConfigColor())),
                                    child: Row(children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              child: Icon(
                                                  CupertinoIcons.color_filter,
                                                  color: Colors.black87,
                                                  size: 20))),
                                      Expanded(
                                          flex: 9,
                                          child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text('Colores',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Light',
                                                      fontSize: 18))))
                                    ]))),
                            Divider(),
                            Container(
                                height: 50,
                                child: InkWell(
                                    onTap: () => Navigator.push(
                                        ctx,
                                        MaterialPageRoute(
                                            builder: (ctx) => CatConfig())),
                                    child: Row(children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              child: Icon(
                                                  CupertinoIcons
                                                      .square_stack_3d_down_right,
                                                  color: Colors.black87,
                                                  size: 20))),
                                      Expanded(
                                          flex: 9,
                                          child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text('Categorias',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Light',
                                                      fontSize: 18))))
                                    ]))),
                            Divider(),
                            Container(
                                height: 50,
                                child: InkWell(
                                    onTap: () => Navigator.push(
                                        ctx,
                                        MaterialPageRoute(
                                            builder: (ctx) => TagConfig())),
                                    child: Row(children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              child: Icon(CupertinoIcons.number,
                                                  color: Colors.black87,
                                                  size: 20))),
                                      Expanded(
                                          flex: 9,
                                          child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text('Tags',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Light',
                                                      fontSize: 18))))
                                    ]))),
                            Divider(),
                            Container(
                                height: 50,
                                child: InkWell(
                                    onTap: () => Navigator.push(
                                        ctx,
                                        MaterialPageRoute(
                                            builder: (ctx) => TallaConfig())),
                                    child: Row(children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              child: Icon(
                                                  CupertinoIcons
                                                      .minus_slash_plus,
                                                  color: Colors.black87,
                                                  size: 20))),
                                      Expanded(
                                          flex: 9,
                                          child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text('Tallas',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Light',
                                                      fontSize: 18))))
                                    ]))),
                            Divider(),
                            Container(
                                height: 50,
                                child: InkWell(
                                    onTap: () => Navigator.push(
                                        ctx,
                                        MaterialPageRoute(
                                            builder: (ctx) => UserConfig())),
                                    child: Row(children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              child: Icon(
                                                  CupertinoIcons.person_2,
                                                  color: Colors.black87,
                                                  size: 20))),
                                      Expanded(
                                          flex: 9,
                                          child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text('Usuarios',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Light',
                                                      fontSize: 18))))
                                    ]))),
                            Divider()
                          ])))
                    ])
                  ])))),
    );
  }
}
