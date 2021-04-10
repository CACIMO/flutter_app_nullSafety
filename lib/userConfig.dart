import 'perfil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'catalogo.dart';
import 'utils.dart';

class UserConfig extends StatefulWidget {
  @override
  _UserConfig createState() => new _UserConfig();
}

class _UserConfig extends State<UserConfig> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  List<Widget> usersW = [];
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    alertLoad(this.context);
    List<Widget> cont = [];
    httpGet(context, 'usuario', false).then((resp) {
      List aux = resp['data'];
      aux.forEach((user) {
        String permiso = '';
        try {
          permiso = '${user['Permisos'][0]['titulo'] ?? ''}';
        } catch (error) {
          permiso = '';
        }
        cont.add(InkWell(
          onTap: () => Navigator.push(this.context,
              MaterialPageRoute(builder: (ctx) => Perfil(data: user['_id']))),
          child: Row(
            children: [
              Expanded(flex: 2, child: CircleAvatar()),
              Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(children: [
                            Expanded(
                                flex: 3,
                                child: Container(
                                  child: Text('NOMBRE: ',
                                      style: TextStyle(
                                          fontSize:
                                              mediaQuery(context, 'h', .017),
                                          color: Colors.black54,
                                          fontFamily: 'Roboto-Regular')),
                                )),
                            Expanded(
                                flex: 7,
                                child: Text(
                                    '${user['nombre']} ${user['apellido']}',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .017),
                                        fontFamily: 'Roboto-Regular')))
                          ])),
                      Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(children: [
                            Expanded(
                                flex: 3,
                                child: Container(
                                  child: Text('USUARIO: ',
                                      style: TextStyle(
                                          fontSize:
                                              mediaQuery(context, 'h', .017),
                                          color: Colors.black54,
                                          fontFamily: 'Roboto-Regular')),
                                )),
                            Expanded(
                                flex: 7,
                                child: Text('${user['usuario']}',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .017),
                                        fontFamily: 'Roboto-Regular')))
                          ])),
                      Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(children: [
                            Expanded(
                                flex: 3,
                                child: Container(
                                  child: Text('PERMISOS: ',
                                      style: TextStyle(
                                          fontSize:
                                              mediaQuery(context, 'h', .017),
                                          color: Colors.black54,
                                          fontFamily: 'Roboto-Regular')),
                                )),
                            Expanded(
                                flex: 7,
                                child: Text('$permiso',
                                    style: TextStyle(
                                        fontSize:
                                            mediaQuery(context, 'h', .017),
                                        fontFamily: 'Roboto-Regular')))
                          ])),
                    ],
                  ))
            ],
          ),
        ));
        cont.add(Divider());
      });

      setState(() {
        usersW = cont;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }).catchError((onError) {
      Navigator.of(context, rootNavigator: true).pop();
    });
  }

  // ignore: missing_return
  Future<bool> _onBackPressed() async {
    Navigator.push(
        this.context, MaterialPageRoute(builder: (ctx) => Catalogo()));
    return true;
  }

  @override
  Widget build(BuildContext ctx) {
    return WillPopScope(
        onWillPop: _onBackPressed,
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
                                            scafoldKey.currentState!
                                                .openDrawer();
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
                                      child: Text('Usuarios',
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
                                  child: Text('USUARIOS DISPONIBLES',
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
                                child: Column(children: usersW)))
                      ])
                    ])))));
  }
}
