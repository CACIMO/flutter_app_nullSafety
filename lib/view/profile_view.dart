import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/view/drawer_menu_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PerfilView extends StatelessWidget {
  final User data;
  const PerfilView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
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
                      height: mQ(context, 'h', .15),
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                              flex: 9,
                              child: Container(
                                  child: Text('Perfil',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Light',
                                          fontSize: mQ(context, 'h', .05))))),
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
                                      top: mQ(context, 'w', .01)),
                                  child: Text('Informacion Personal',
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Thin',
                                          fontSize: mQ(context, 'h', .03)))))
                        ]),
                        Divider()
                      ])),
                  Column(children: [
                    Container(
                        height: mQ(context, 'h', .75),
                        padding: EdgeInsets.only(top: 5),
                        child: SingleChildScrollView(
                            child: Column(children: [
                          Row(children: [
                            Expanded(
                                child: Container(
                                    height: mQ(context, 'h', .3),
                                    child: CircleAvatar(
                                      child: InkWell(
                                        onTap: () => print(''),
                                        child: Container(),
                                      ),
                                    )))
                          ]),
                          Divider(),
                          InkWell(
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: mQ(context, 'h', .012),
                                    bottom: mQ(context, 'h', .012)),
                                child: Row(children: [
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        child: Text('Nombre ',
                                            style: TextStyle(
                                                fontSize:
                                                    mQ(context, 'h', .022),
                                                color: Colors.black54,
                                                fontFamily: 'Roboto-Light')),
                                      )),
                                  Expanded(
                                      flex: 7,
                                      child: Text(
                                          '${data.nombre} ${data.apellido}',
                                          style: TextStyle(
                                              fontSize: mQ(context, 'h', .020),
                                              fontFamily: 'Roboto-Light')))
                                ])),
                          ),
                          Divider(),
                          InkWell(
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: mQ(context, 'h', .012),
                                    bottom: mQ(context, 'h', .012)),
                                child: Row(children: [
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        child: Text('Cedula ',
                                            style: TextStyle(
                                                fontSize:
                                                    mQ(context, 'h', .022),
                                                color: Colors.black54,
                                                fontFamily: 'Roboto-Light')),
                                      )),
                                  Expanded(
                                      flex: 7,
                                      child: Text(data.cedula,
                                          style: TextStyle(
                                              fontSize: mQ(context, 'h', .020),
                                              fontFamily: 'Roboto-Light')))
                                ])),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () => print(''),
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: mQ(context, 'h', .012),
                                    bottom: mQ(context, 'h', .012)),
                                child: Row(children: [
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        child: Text('Usuario ',
                                            style: TextStyle(
                                                fontSize:
                                                    mQ(context, 'h', .022),
                                                color: Colors.black54,
                                                fontFamily: 'Roboto-Light')),
                                      )),
                                  Expanded(
                                      flex: 7,
                                      child: Text(data.usuario,
                                          style: TextStyle(
                                              fontSize: mQ(context, 'h', .020),
                                              fontFamily: 'Roboto-Light')))
                                ])),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () => print(''),
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: mQ(context, 'h', .012),
                                    bottom: mQ(context, 'h', .012)),
                                child: Row(children: [
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        child: Text('Correo ',
                                            style: TextStyle(
                                                fontSize:
                                                    mQ(context, 'h', .022),
                                                color: Colors.black54,
                                                fontFamily: 'Roboto-Light')),
                                      )),
                                  Expanded(
                                      flex: 7,
                                      child: Text(data.correo,
                                          style: TextStyle(
                                              fontSize: mQ(context, 'h', .020),
                                              fontFamily: 'Roboto-Light')))
                                ])),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () => print(''),
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: mQ(context, 'h', .012),
                                    bottom: mQ(context, 'h', .012)),
                                child: Row(children: [
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        child: Text('Telefono ',
                                            style: TextStyle(
                                                fontSize:
                                                    mQ(context, 'h', .022),
                                                color: Colors.black54,
                                                fontFamily: 'Roboto-Light')),
                                      )),
                                  Expanded(
                                      flex: 7,
                                      child: Text(data.telefono.toString(),
                                          style: TextStyle(
                                              fontSize: mQ(context, 'h', .020),
                                              fontFamily: 'Roboto-Light')))
                                ])),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () => alertAddCTTG(context, data),
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: mQ(context, 'h', .012),
                                    bottom: mQ(context, 'h', .012)),
                                child: Row(children: [
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        child: Text('Perfil ',
                                            style: TextStyle(
                                                fontSize:
                                                    mQ(context, 'h', .022),
                                                color: Colors.black54,
                                                fontFamily: 'Roboto-Light')),
                                      )),
                                  Expanded(
                                      flex: 7,
                                      child: Text(data.token,
                                          style: TextStyle(
                                              fontSize: mQ(context, 'h', .020),
                                              fontFamily: 'Roboto-Light')))
                                ])),
                          ),
                          Divider()
                        ])))
                  ])
                ]))));
  }
}
