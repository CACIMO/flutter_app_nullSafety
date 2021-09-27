import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/controller/producto_controller.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:flutter_app/view/item_view.dart';

class DropDownColor extends StatelessWidget {
  final String idSelec;
  final List<ColorD> list;
  final Function? onChange;
  const DropDownColor(
      {Key? key, required this.idSelec, required this.list, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ColorD> aux = [
      new ColorD('FFFFFF', 'FFFFFF', 'Seleccione un color ', 'none', false)
    ];
    aux.addAll(list);
    return DropdownButton<String>(
      value: idSelec,
      icon: Container(
          child: const Icon(CupertinoIcons.arrowtriangle_down_circle)),
      iconSize: 24,
      elevation: 16,
      onChanged: (String? idColor) {
        if (onChange != null)
          onChange!(idColor);
        else
          changeColor(context, idColor.toString());
      },
      items: aux.map<DropdownMenuItem<String>>((ColorD color) {
        return DropdownMenuItem<String>(
            value: color.id,
            child: Container(
              height: mQ(context, 'h', .03),
              //width: mQ(context, 'w', .5),
              child: Column(children: [
                Row(children: [
                  Visibility(
                    visible: (color.id != 'none'),
                    child: ColorItem(
                        primario: color.primario, segundario: color.segundario),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 3),
                    child: Text(color.titulo,
                        style: TextStyle(
                            fontFamily: 'Roboto-Light',
                            fontSize: mQ(context, 'h', .02))),
                  )
                ])
              ]),
            ));
      }).toList(),
    );
  }
}

class DropDownTalla extends StatelessWidget {
  final String idSelec;
  final List<Talla> list;
  final Function? onChange;
  const DropDownTalla(
      {Key? key, required this.idSelec, required this.list, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Talla> aux = [new Talla('Seleccione una talla ', 'none')];
    aux.addAll(list);
    return DropdownButton<String>(
      value: idSelec,
      icon: Container(
          child: const Icon(CupertinoIcons.arrowtriangle_down_circle)),
      iconSize: 24,
      elevation: 16,
      onChanged: (String? idTalla) {
        if (onChange != null)
          onChange!(idTalla);
        else
          changeTalla(context, idTalla.toString());
      },
      items: aux.map<DropdownMenuItem<String>>((Talla talla) {
        return DropdownMenuItem<String>(
            value: talla.id,
            child: Container(
                height: mQ(context, 'h', .03),
                child: Text(talla.titulo,
                    style: TextStyle(
                        fontFamily: 'Roboto-Light',
                        fontSize: mQ(context, 'h', .02)))));
      }).toList(),
    );
  }
}
