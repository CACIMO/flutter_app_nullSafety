import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';

class MenuItem extends StatelessWidget {
  final String titulo;
  final Icon icono;
  final String route;
  const MenuItem(
      {Key? key,
      required this.titulo,
      required this.icono,
      required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/$route'),
      child: Column(children: [
        Row(children: [
          Container(
              width: mQ(context, 'w', .75),
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: mQ(context, 'h', .06),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                    alignment: Alignment.center, child: icono)),
                            Expanded(
                                flex: 8,
                                child: Container(
                                  padding: EdgeInsets.only(left: 20),
                                  alignment: Alignment.centerLeft,
                                  child: Text(titulo,
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Light',
                                          fontSize: mQ(context, 'w', .05))),
                                ))
                          ]),
                    ),
                    Divider()
                  ]))
        ])
      ]),
    );
  }
}
