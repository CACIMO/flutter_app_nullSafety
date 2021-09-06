import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/controller/modificar_prod_controller.dart';
import 'package:flutter_app/controller/nuevo_prod_controller.dart';
import 'package:flutter_app/model/drawer_fil_model.dart';
import 'package:flutter_app/model/modificar_prod_model.dart';
import 'package:flutter_app/model/nuevo_prod_model.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:flutter_app/view/dropdown_view.dart';
import 'package:flutter_app/view/item_view.dart';
import 'package:provider/provider.dart';

class Combinacion extends StatelessWidget {
  final bool isNew;
  final Map<String, dynamic>? data;
  final dynamic prov;
  const Combinacion(
      {Key? key, required this.isNew, this.data, required this.prov})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemCheck talla = ItemCheck('Seleccione tala', 'none', false);
    File img = prov.imgFile;
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
    bool isEdit = prov.isEdit;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(children: [
        Container(
            margin: EdgeInsets.only(right: 10),
            height: mQ(context, 'h', .12),
            width: mQ(context, 'h', .12),
            child: ((prov.isEdit
                        ? !Provider.of<ModificarProdModel>(context).imgSelec
                        : !Provider.of<NuevoProdModel>(context).imgSelec) &&
                    data == null)
                ? IconButton(
                    onPressed: () => isEdit
                        ? addImgNewMod(context, false, {})
                        : addImgNew(context),
                    icon: Icon(CupertinoIcons.add_circled),
                  )
                : (prov.isEdit && data != null)
                    ? InkWell(
                        onTap: () {
                          addImgNewMod(context, true, data ?? {});
                        },
                        child: CachedNetworkImage(
                            height: mQ(context, 'h', .12),
                            imageUrl:
                                'http://$urlDB/getimg/preview/${data!['img']}'),
                      )
                    : Image.file(data == null ? img : data!['img'])),
        if (data == null)
          Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(children: [
                  DropDownColor(
                      onChange: (String? idColor) => isEdit
                          ? changeColorProMod(context, idColor.toString())
                          : changeColorPro(context, idColor.toString()),
                      idSelec: prov.colorSelect,
                      list: Provider.of<DrawerFilterModel>(context).colorList)
                ]),
                Row(children: [
                  DropDownTalla(
                      onChange: (String? idTalla) => isEdit
                          ? changeTallaProdMod(context, idTalla.toString())
                          : changeTallaProd(context, idTalla.toString()),
                      idSelec: prov.tallaSelect,
                      list: Provider.of<DrawerFilterModel>(context)
                          .tallaList
                          .map((e) => Talla(e.titulo, e.id))
                          .toList())
                ]),
              ]))
        else
          InkWell(
            onTap: () => stockAlert(context, data, () {
              Provider.of<ModificarProdModel>(context, listen: false)
                  .getProductInfo();
            }),
            child: Container(
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
                                  (prov.isEdit)
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
          ),
        if (isNew)
          Container(
            width: mQ(context, 'w', .15),
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => isEdit
                  ? removeLastProd(
                      context, isNew, (data == null) ? -1 : data!['index'])
                  : removeLast(
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
                  controller: prov.stock,
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
              onPressed: () => isEdit
                  ? addCombiToArrayMod(context)
                  : addCombiToArray(context),
              child: Container(
                  child: Text('Agregar',
                      style: TextStyle(
                          fontFamily: 'Roboto-Light',
                          fontSize: mQ(context, 'w', .05)))))
        ])
    ]);
  }
}
