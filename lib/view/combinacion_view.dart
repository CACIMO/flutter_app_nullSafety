import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/controller/modificar_prod_controller.dart';
import 'package:flutter_app/model/drawer_fil_model.dart';
import 'package:flutter_app/model/modificar_prod_model.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:flutter_app/view/item_view.dart';
import 'package:provider/provider.dart';

class Combinacion extends StatelessWidget {
  final bool isNew;
  final Map<String, dynamic>? data;
  final dynamic prov;
  final Function delete;
  const Combinacion(
      {Key? key,
      required this.isNew,
      this.data,
      required this.prov,
      required this.delete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemCheck talla = ItemCheck('Seleccione tala', 'none', false);
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
    return Container(
        width: mQ(context, 'w', 1),
        margin: EdgeInsets.only(bottom: 5),
        child: Column(children: [
          Row(children: [
            Expanded(
                flex: 4,
                child: isEdit
                    ? InkWell(
                        onTap: () {
                          addImgNewMod(context, true, data ?? {});
                        },
                        child: CachedNetworkImage(
                            height: mQ(context, 'h', .12),
                            imageUrl:
                                'http://$urlDB/getimg/preview/${data!['img']}'))
                    : Image.file(data!['img'])),
            Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: InkWell(
                      onTap: () => stockAlert(context, data, () {
                            Provider.of<ModificarProdModel>(context,
                                    listen: false)
                                .getProductInfo();
                          }),
                      child: Container(
                          width: mQ(context, 'w', .4),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: mQ(context, 'h', .005)),
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
                                                fontSize:
                                                    mQ(context, 'w', .035),
                                                color: Colors.black54,
                                                fontFamily: 'Roboto-Light')))
                                  ]),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: mQ(context, 'h', .005)),
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
                                                fontSize:
                                                    mQ(context, 'w', .035),
                                                color: Colors.black54,
                                                fontFamily: 'Roboto-Light')))
                                  ]),
                                ),
                                Container(
                                    height: 20,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text('Color: ',
                                              style: TextStyle(
                                                  fontSize:
                                                      mQ(context, 'w', .035),
                                                  color: Colors.black54,
                                                  fontFamily: 'Roboto-Light')),
                                          Container(
                                              child: ColorItem(
                                                  primario: color.primario,
                                                  segundario: color.segundario))
                                        ]))
                              ]))),
                )),
            Expanded(
                child: IconButton(
                    iconSize: 30,
                    onPressed: () => delete(),
                    icon: Icon(CupertinoIcons.trash,
                        color: Colors.red.withOpacity(0.5))))
          ])
        ]));
  }
}
