import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/drawer_fil_controller.dart';
import 'package:flutter_app/controller/general_controller.dart';

import 'filter_item_view.dart';

class DrawerFilter extends StatelessWidget {
  const DrawerFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            child: Text('FILTROS DE BUSQUEDA',
                                style: TextStyle(
                                    fontFamily: 'Roboto-Light',
                                    fontSize: mQ(context, 'w', .04)))))
                  ]),
                  Divider(),
                  Row(children: [
                    Expanded(
                        child: FilterItem(
                            titulo: 'Categoria',
                            onPress: () => btnFilterCategory(context)))
                  ]),
                  Row(children: [
                    Expanded(
                        child: FilterItem(
                            titulo: 'Color',
                            onPress: () => btnFilterColor(context)))
                  ]),
                  Row(children: [
                    Expanded(
                        child: FilterItem(
                            titulo: 'Talla',
                            onPress: () => btnFilterTalla(context)))
                  ]),
                  Row(children: [
                    Expanded(
                        child: FilterItem(
                            titulo: 'Tag',
                            onPress: () => btnFilterTag(context)))
                  ])
                ]),
              ))),
    );
  }
}
