import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/view/drawer_fil_view.dart';
import 'package:flutter_app/view/drawer_menu_view.dart';
import 'package:intl/intl.dart';

class FormatoMail extends StatefulWidget {
  @override
  _FormatoMail createState() => new _FormatoMail();
}

class _FormatoMail extends State<FormatoMail> {
  DateTime fechaInicial = new DateTime.now();
  DateTime fechaFinal = new DateTime.now();
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  GlobalKey filterKey = GlobalKey();
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
                        child: Text('Enviar Email',
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
                  margin: EdgeInsets.only(top: 10),
                  child: Column(children: [
                    Row(children: [
                      Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('FECHA INICIAL',
                                style: TextStyle(
                                    fontSize: mQ(context, 'h', .016),
                                    color: Colors.black54,
                                    fontFamily: 'Roboto-Regular')),
                          )),
                      Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('FECHA FINAL',
                                style: TextStyle(
                                    fontSize: mQ(context, 'h', .016),
                                    color: Colors.black54,
                                    fontFamily: 'Roboto-Regular')),
                          ))
                    ]),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(children: [
                        Expanded(
                            flex: 5,
                            child: Column(children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: Text(
                                            DateFormat('dd-MM-y')
                                                .format(fechaInicial),
                                            style: TextStyle(
                                                fontSize:
                                                    mQ(context, 'h', .016),
                                                fontFamily: 'Roboto-Regular'))),
                                    IconButton(
                                        icon: Icon(CupertinoIcons.pencil),
                                        onPressed: () => showCalendar(
                                            context,
                                            (date) => setState(
                                                () => fechaInicial = date)))
                                  ])
                            ])),
                        Expanded(
                            flex: 5,
                            child: Column(children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: Text(
                                            DateFormat('dd-MM-y')
                                                .format(fechaFinal),
                                            style: TextStyle(
                                                fontSize:
                                                    mQ(context, 'h', .016),
                                                fontFamily: 'Roboto-Regular'))),
                                    IconButton(
                                        icon: Icon(CupertinoIcons.pencil),
                                        onPressed: () => showCalendar(
                                            context,
                                            (date) => setState(
                                                () => fechaFinal = date)))
                                  ])
                            ]))
                      ]),
                    )
                  ]))
            ])));
  }
}
