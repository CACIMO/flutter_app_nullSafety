import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/config_controller.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/config_model.dart';
import 'package:flutter_app/view/drawer_menu_view.dart';
import 'package:flutter_app/view/profile_view.dart';
import 'package:provider/provider.dart';

class UserConfig extends StatefulWidget {
  @override
  _UserConfig createState() => new _UserConfig();
}

class _UserConfig extends State<UserConfig> {
  @override
  void initState() {
    super.initState();
    getUsers(context);
  }

  List<Widget> usersW = [];
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        key: scafoldKey,
        drawer: DrawerMenu(),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    top: mQ(context, 'h', .05),
                    left: mQ(context, 'w', .05),
                    right: mQ(context, 'w', .05)),
                child: Column(children: [
                  Container(
                      child: Column(children: [
                    Row(children: [
                      Expanded(
                          flex: 9,
                          child: Container(
                              child: Text('Usuarios',
                                  style: TextStyle(
                                      fontFamily: 'Roboto-Light',
                                      fontSize: mQ(context, 'w', .08))))),
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
                    Divider()
                  ])),
                  Column(children: [
                    Container(
                        height: mQ(context, 'h', .75),
                        child: SingleChildScrollView(
                            child: Column(
                                children: Provider.of<ConfigModel>(context)
                                    .users
                                    .map((e) => Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: InkWell(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PerfilView(data: e))),
                                            child: Row(children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: CircleAvatar()),
                                              Expanded(
                                                  flex: 8,
                                                  child: Column(children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            top: 5),
                                                        child: Row(children: [
                                                          Expanded(
                                                              flex: 3,
                                                              child: Container(
                                                                child: Text(
                                                                    'NOMBRE: ',
                                                                    style: TextStyle(
                                                                        fontSize: mQ(
                                                                            context,
                                                                            'h',
                                                                            .017),
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            'Roboto-Regular')),
                                                              )),
                                                          Expanded(
                                                              flex: 7,
                                                              child: Text(
                                                                  '${e.nombre} ${e.apellido}',
                                                                  style: TextStyle(
                                                                      fontSize: mQ(
                                                                          context,
                                                                          'h',
                                                                          .017),
                                                                      fontFamily:
                                                                          'Roboto-Regular')))
                                                        ])),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            top: 5),
                                                        child: Row(children: [
                                                          Expanded(
                                                              flex: 3,
                                                              child: Container(
                                                                child: Text(
                                                                    'USUARIO: ',
                                                                    style: TextStyle(
                                                                        fontSize: mQ(
                                                                            context,
                                                                            'h',
                                                                            .017),
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            'Roboto-Regular')),
                                                              )),
                                                          Expanded(
                                                              flex: 7,
                                                              child: Text(
                                                                  '${e.usuario}',
                                                                  style: TextStyle(
                                                                      fontSize: mQ(
                                                                          context,
                                                                          'h',
                                                                          .017),
                                                                      fontFamily:
                                                                          'Roboto-Regular')))
                                                        ])),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            top: 5),
                                                        child: Row(children: [
                                                          Expanded(
                                                              flex: 3,
                                                              child: Container(
                                                                child: Text(
                                                                    'PERMISO: ',
                                                                    style: TextStyle(
                                                                        fontSize: mQ(
                                                                            context,
                                                                            'h',
                                                                            .017),
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            'Roboto-Regular')),
                                                              )),
                                                          Expanded(
                                                              flex: 7,
                                                              child: Text(
                                                                  '${e.token}',
                                                                  style: TextStyle(
                                                                      fontSize: mQ(
                                                                          context,
                                                                          'h',
                                                                          .017),
                                                                      fontFamily:
                                                                          'Roboto-Regular')))
                                                        ]))
                                                  ]))
                                            ]))))
                                    .toList())))
                  ])
                ]))));
  }
}
