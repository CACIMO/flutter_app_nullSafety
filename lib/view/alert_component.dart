import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';

class AlertComponent extends StatelessWidget {
  final String type;
  final String msg;
  const AlertComponent({Key? key, required this.type, required this.msg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Icon> iconos = {
      'e': Icon(CupertinoIcons.multiply_circle,
          color: Colors.red.withOpacity(.75)),
      'w': Icon(CupertinoIcons.multiply_circle,
          color: Colors.yellow.withOpacity(.75)),
      's': Icon(CupertinoIcons.check_mark_circled,
          color: Colors.green.withOpacity(.75))
    };
    return Container(
        child: Column(children: [
      Row(children: [
        Expanded(flex: 2, child: iconos[type]!),
        Expanded(
            flex: 8,
            child: Text(this.msg,
                style: TextStyle(
                    fontFamily: 'Roboto-Light',
                    fontSize: mQ(context, 'h', .022))))
      ])
    ]));
  }
}
