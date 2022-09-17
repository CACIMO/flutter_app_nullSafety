import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/menu_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/view/menu_item_view.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, dynamic>> menuOption =
        Provider.of<MenuController>(context).menuOption;
    List<Widget> options = [];
    menuOption.keys.forEach((key) {
      if (menuOption[key]!['active'] == true) {
        options.add(MenuElemet(
            titulo: menuOption[key]!['title'],
            icono: menuOption[key]!['icono'],
            route: menuOption[key]!['route']));
      }
    });
    return Container(
      width: mQ(context, 'w', .75),
      child: Drawer(
          child: Container(
              height: mQ(context, 'h', 1),
              child: SingleChildScrollView(
                  child: Column(children: [
                Row(children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          height: mQ(context, 'h', .1),
                          child: Text('MENU DE OPCIONES',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Light',
                                  fontSize: mQ(context, 'w', .04)))))
                ]),
                Divider(),
                Row(children: [
                  Column(
                    children: (options),
                  )
                ])
              ])))),
    );
  }
}
