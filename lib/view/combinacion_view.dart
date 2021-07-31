import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/controller/nuevo_prod_controller.dart';
import 'package:flutter_app/model/drawer_fil_model.dart';
import 'package:flutter_app/model/editar_model.dart';
import 'package:flutter_app/model/nuevo_prod_model.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:flutter_app/view/dropdown_view.dart';
import 'package:flutter_app/view/item_view.dart';
import 'package:provider/provider.dart';

class Combinacion extends StatelessWidget {
  final bool isNew;
  final bool isEdit;
  final Map<String, dynamic>? data;
  const Combinacion(
      {Key? key, required this.isNew, this.data, required this.isEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemCheck talla = ItemCheck('Seleccione tala', 'none', false);
    File img = isEdit
        ? Provider.of<EditarModel>(context).imgFile
        : Provider.of<NuevoProdModel>(context).imgFile;
    ColorD color =
        ColorD('FFFFFF', 'FFFFFF', 'Seleccione un color', 'none', false);
    if (data != null) {
      color = Provider.of<DrawerFilterModel>(context)
          .colorList
          .where((e) => e.id == data!['color'])
          .toList()[0];
      talla = Provider.of<DrawerFilterModel>(context)
          .tallaList
          .where((e) => e.id == data!['talla'])
          .toList()[0];
    }
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(children: [
        Container(
            margin: EdgeInsets.only(right: 10),
            height: mQ(context, 'h', .12),
            width: mQ(context, 'h', .12),
            child: (!Provider.of<NuevoProdModel>(context).imgSelec &&
                        data == null ||
                    (data == null &&
                        isEdit &&
                        !Provider.of<EditarModel>(context).imgSelec))
                ? IconButton(
                    onPressed: () => addImgNew(context),
                    icon: Icon(CupertinoIcons.add_circled),
                  )
                : (isEdit && data != null)
                    ? CachedNetworkImage(
                        height: mQ(context, 'h', .12),
                        imageUrl:
                            'http://$urlDB/getimg/preview/${data!['img']}')
                    : Image.file(data == null ? img : data!['img'])),
        if (data == null)
          Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(children: [
                  DropDownColor(
                      onChange: (String? idColor) =>
                          changeColorPro(context, idColor.toString()),
                      idSelec: Provider.of<NuevoProdModel>(context).colorSelect,
                      list: Provider.of<DrawerFilterModel>(context).colorList)
                ]),
                Row(children: [
                  DropDownTalla(
                      onChange: (String? idTalla) =>
                          changeTallaProd(context, idTalla.toString()),
                      idSelec: Provider.of<NuevoProdModel>(context).tallaSelect,
                      list: Provider.of<DrawerFilterModel>(context)
                          .tallaList
                          .map((e) => Talla(e.titulo, e.id))
                          .toList())
                ]),
              ]))
        else
          Container(
              width: mQ(context, 'w', .4),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: mQ(context, 'h', .005)),
                      height: 20,
                      child: Row(children: [
                        Text('Tallas: ',
                            style: TextStyle(
                                fontSize: mQ(context, 'w', .035),
                                color: Colors.black54,
                                fontFamily: 'Roboto-Light')),
                        Container(
                            height: 20,
                            child: Text(talla.titulo,
                                style: TextStyle(
                                    fontSize: mQ(context, 'w', .035),
                                    color: Colors.black54,
                                    fontFamily: 'Roboto-Light')))
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: mQ(context, 'h', .005)),
                      height: 20,
                      child: Row(children: [
                        Container(
                          child: Text('Stock: ',
                              style: TextStyle(
                                  fontSize: mQ(context, 'w', .035),
                                  color: Colors.black54,
                                  fontFamily: 'Roboto-Light')),
                        ),
                        Container(
                            height: 20,
                            child: Text(
                                isEdit
                                    ? data!['stock'].toString()
                                    : data!['cantidad'],
                                style: TextStyle(
                                    fontSize: mQ(context, 'w', .035),
                                    color: Colors.black54,
                                    fontFamily: 'Roboto-Light')))
                      ]),
                    ),
                    Container(
                        height: 20,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Color: ',
                                  style: TextStyle(
                                      fontSize: mQ(context, 'w', .035),
                                      color: Colors.black54,
                                      fontFamily: 'Roboto-Light')),
                              Container(
                                  child: ColorItem(
                                      primario: color.primario,
                                      segundario: color.segundario))
                            ]))
                  ])),
        Container(
          width: mQ(context, 'w', .15),
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () => removeLast(
                context, isNew, (data == null) ? -1 : data!['index']),
            icon: Icon(CupertinoIcons.trash,
                size: 30, color: Colors.red.withOpacity(.5)),
          ),
        )
      ]),
      if (data == null)
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              margin: EdgeInsets.only(right: 10),
              width: mQ(context, 'w', .4),
              child: TextFormField(
                  controller: Provider.of<NuevoProdModel>(context).stock,
                  maxLength: 30,
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: 'Stock',
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                      hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                      fillColor: Color(0xFFEBEBEB)))),
          ElevatedButton(
              onPressed: () => addCombiToArray(context),
              child: Container(
                  child: Text('Agregar',
                      style: TextStyle(
                          fontFamily: 'Roboto-Light',
                          fontSize: mQ(context, 'w', .05)))))
        ])
    ]);
  }
}
