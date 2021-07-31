import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/controller/item_controller.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class Producto extends StatelessWidget {
  final Item prodData;
  final bool isCarrito;
  const Producto({Key? key, required this.prodData, required this.isCarrito})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showProd(context, prodData),
      child: Column(children: [
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: mQ(context, 'h', .15)),
          child: Container(
              child: Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: mQ(context, 'h', .15),
                                width: mQ(context, 'h', .15),
                                child: CachedNetworkImage(
                                    height: mQ(context, 'h', .15),
                                    imageUrl: prodData.urlImg),
                              ),
                              Expanded(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Column(children: [
                                        Container(
                                            width: mQ(context, 'w', 1),
                                            padding: EdgeInsets.all(3),
                                            child: Text(prodData.titulo,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize:
                                                        mQ(context, 'w', .05),
                                                    fontFamily:
                                                        'Roboto-Light'))),
                                        if (isCarrito)
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text('Cantidad:',
                                                      style: TextStyle(
                                                          fontSize: mQ(context,
                                                              'w', .035),
                                                          color: Colors.black54,
                                                          fontFamily:
                                                              'Roboto-Light')),
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                      child: Text(
                                                          prodData.cantidad,
                                                          style: TextStyle(
                                                              fontSize: mQ(
                                                                  context,
                                                                  'w',
                                                                  .035),
                                                              color: Colors
                                                                  .black54,
                                                              fontFamily:
                                                                  'Roboto-Light')))
                                                ]),
                                          ),
                                        if (!isCarrito)
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text('Referencias:',
                                                      style: TextStyle(
                                                          fontSize: mQ(context,
                                                              'w', .035),
                                                          color: Colors.black54,
                                                          fontFamily:
                                                              'Roboto-Light')),
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                      child: Text(
                                                          '${prodData.refVendedora} - ${prodData.refInterna}',
                                                          style: TextStyle(
                                                              fontSize: mQ(
                                                                  context,
                                                                  'w',
                                                                  .035),
                                                              color: Colors
                                                                  .black54,
                                                              fontFamily:
                                                                  'Roboto-Light')))
                                                ]),
                                          ),
                                        Container(
                                          padding: EdgeInsets.all(3),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text('Valor:',
                                                    style: TextStyle(
                                                        fontSize: mQ(
                                                            context, 'w', .035),
                                                        color: Colors.black54,
                                                        fontFamily:
                                                            'Roboto-Light')),
                                                Container(
                                                    padding: EdgeInsets
                                                        .only(left: 3),
                                                    child: Text(
                                                        NumberFormat
                                                                .simpleCurrency()
                                                            .format(double
                                                                .parse(prodData
                                                                    .valor)),
                                                        style: TextStyle(
                                                            fontSize: mQ(
                                                                context,
                                                                'w',
                                                                .035),
                                                            color:
                                                                Colors.black54,
                                                            fontFamily:
                                                                'Roboto-Light')))
                                              ]),
                                        ),
                                        Container(
                                          height: 20,
                                          padding: EdgeInsets.all(3),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text('Tallas:',
                                                    style: TextStyle(
                                                        fontSize: mQ(
                                                            context, 'w', .035),
                                                        color: Colors.black54,
                                                        fontFamily:
                                                            'Roboto-Light')),
                                                Container(
                                                    width: mQ(context, 'w', .3),
                                                    height: 20,
                                                    padding: EdgeInsets.only(
                                                        left: 3),
                                                    child: ListView.builder(
                                                        primary: false,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: prodData
                                                            .tallas.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          int lent = prodData
                                                              .tallas.length;
                                                          return Text(
                                                              '${prodData.tallas[index].titulo}${(lent - 1 != index ? ', ' : '')}',
                                                              style: TextStyle(
                                                                  fontSize: mQ(
                                                                      context,
                                                                      'w',
                                                                      .035),
                                                                  color: Colors
                                                                      .black54,
                                                                  fontFamily:
                                                                      'Roboto-Light'));
                                                        }))
                                              ]),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(3),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text('Color:',
                                                    style: TextStyle(
                                                        fontSize: mQ(
                                                            context, 'w', .035),
                                                        color: Colors.black54,
                                                        fontFamily:
                                                            'Roboto-Light')),
                                                Container(
                                                  width: mQ(context, 'w', .3),
                                                  height: 20,
                                                  padding:
                                                      EdgeInsets.only(left: 3),
                                                  child: ListView.builder(
                                                      primary: false,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: prodData
                                                          .colores.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return ColorItem(
                                                            primario: prodData
                                                                .colores[index]
                                                                .primario,
                                                            segundario: prodData
                                                                .colores[index]
                                                                .segundario);
                                                      }),
                                                )
                                              ]),
                                        )
                                      ])))
                            ])
                      ])),
                  secondaryActions: <Widget>[
                if (!isCarrito)
                  IconSlideAction(
                      color: Colors.blue.withOpacity(0.8),
                      icon: CupertinoIcons.pencil_ellipsis_rectangle,
                      onTap: () => goToEditView(context, prodData.id)),
                IconSlideAction(
                    color: Colors.red.withOpacity(0.8),
                    icon: CupertinoIcons.trash,
                    onTap: () => removeProducto(context, prodData))
              ])),
        ),
        Divider()
      ]),
    );
  }
}

class ColorItem extends StatelessWidget {
  final String primario;
  final String segundario;
  const ColorItem({Key? key, required this.primario, required this.segundario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 20,
        width: 20,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(right: 2),
        child: Container(
            height: 20,
            width: 20,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(int.parse('0xFF$segundario')),
                borderRadius: BorderRadius.circular(10))),
        decoration: BoxDecoration(
            color: Color(int.parse('0xFF$primario')),
            borderRadius: BorderRadius.circular(10)));
  }
}
