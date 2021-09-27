import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/controller/producto_controller.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:flutter_app/view/dropdown_view.dart';
import 'package:provider/provider.dart';

class ProductoView extends StatelessWidget {
  const ProductoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController precioController = TextEditingController();
    Item prodData = Provider.of<ProductosModel>(context).prodSelected!;
    int stock = Provider.of<ProductosModel>(context).maxStock;
    precioController.text = prodData.valor;
    return Container(
      height: mQ(context, 'h', 1),
      child: Stack(
        children: [
          Positioned(
              bottom: 0,
              child: Container(
                  height: mQ(context, 'h', .65),
                  width: mQ(context, 'w', 1),
                  padding: EdgeInsets.only(
                      top: mQ(context, 'h', .09), left: 30, right: 30),
                  margin: EdgeInsets.only(top: mQ(context, 'h', .4)),
                  child: Scaffold(
                      floatingActionButton: FloatingActionButton(
                        onPressed: () =>
                            addToCar(context, prodData, precioController),
                        child: Icon(CupertinoIcons.cart_badge_plus),
                      ),
                      body: Container(
                          child: Column(children: [
                        Row(children: [
                          Expanded(
                            flex: 8,
                            child: Text(prodData.titulo,
                                style: TextStyle(
                                    fontSize: mQ(context, 'h', .030),
                                    fontFamily: 'Roboto-Light')),
                          ),
                          Expanded(
                              flex: 2,
                              child: IconButton(
                                onPressed: () => showQr(context, prodData),
                                icon: Icon(CupertinoIcons.qrcode),
                              ))
                        ]),
                        Divider(),
                        Container(
                            //height: mQ(context, 'h', .4),
                            padding: EdgeInsets.only(bottom: 10),
                            child: Column(children: [
                              Container(
                                  height: mQ(context, 'h', .08),
                                  child: Row(children: [
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                            child: Text('Stock: ',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto-Light',
                                                    fontSize: mQ(
                                                        context, 'h', .022))))),
                                    Expanded(
                                        flex: 7,
                                        child: Text(
                                            (stock > 0)
                                                ? stock.toString()
                                                : (Provider.of<ProductosModel>(
                                                                    context)
                                                                .colorSelect ==
                                                            'none' ||
                                                        Provider.of<ProductosModel>(
                                                                    context)
                                                                .tallaSelect ==
                                                            'none')
                                                    ? 'Seleccione color y talla'
                                                    : 'No hay Stock disponible',
                                            style: TextStyle(
                                                fontFamily: 'Roboto-Light',
                                                fontSize:
                                                    mQ(context, 'h', .022))))
                                  ])),
                              Container(
                                  height: mQ(context, 'h', .08),
                                  child: Row(children: [
                                    Expanded(
                                        flex: 4,
                                        child: Container(
                                            child: Text('Cantidad: ',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto-Light',
                                                    fontSize: mQ(
                                                        context, 'h', .022))))),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                            child: IconButton(
                                          onPressed: () => resCounter(context),
                                          icon: Icon(Icons.remove_outlined,
                                              color: Color(0xFFff472f)
                                                  .withOpacity(.7)),
                                        ))),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                                '${Provider.of<ProductosModel>(context).counter.toString()}',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto-Light',
                                                    fontSize: mQ(
                                                        context, 'h', .022))))),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                            child: IconButton(
                                          onPressed: () => sumCounter(context),
                                          icon: Icon(Icons.add_outlined,
                                              color: Color(0xFF05b071)
                                                  .withOpacity(.7)),
                                        ))),
                                  ])),
                              Container(
                                height: mQ(context, 'h', .08),
                                child: Row(children: [
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                          child: Text('Precio: ',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto-Light',
                                                  fontSize: mQ(
                                                      context, 'h', .022))))),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          child: Text('\$',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto-Light',
                                                  fontSize: mQ(
                                                      context, 'h', .022))))),
                                  Expanded(
                                      flex: 6,
                                      child: Container(
                                          child: TextFormField(
                                              controller: precioController,
                                              onFieldSubmitted: (val) {
                                                Provider.of<ProductosModel>(
                                                        context)
                                                    .focusNode
                                                    .unfocus();
                                              },
                                              maxLength: 30,
                                              focusNode: Provider.of<
                                                      ProductosModel>(context)
                                                  .focusNode,
                                              autofocus: false,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  counterText: "",
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide
                                                              .none),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  hintText: 'Precio',
                                                  hintStyle: TextStyle(
                                                      color: Color(0xFFAAAAAA)),
                                                  fillColor:
                                                      Color(0xFFEBEBEB))))),
                                ]),
                              ),
                              Container(
                                height: mQ(context, 'h', .08),
                                child: Row(children: [
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                          child: Text('Colores:',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto-Light',
                                                  fontSize: mQ(
                                                      context, 'h', .022))))),
                                  Expanded(
                                      flex: 7,
                                      child: Container(
                                          width: mQ(context, 'w', .7),
                                          child: DropDownColor(
                                            list: Provider.of<ProductosModel>(
                                                    context)
                                                .arrayColors,
                                            idSelec:
                                                Provider.of<ProductosModel>(
                                                        context)
                                                    .colorSelect,
                                          )))
                                ]),
                              ),
                              Container(
                                  height: mQ(context, 'h', .08),
                                  child: Row(children: [
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                            child: Text('Tallas:',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto-Light',
                                                    fontSize: mQ(
                                                        context, 'h', .022))))),
                                    Expanded(
                                        flex: 7,
                                        child: Container(
                                            width: mQ(context, 'w', .7),
                                            child: DropDownTalla(
                                              list: Provider.of<ProductosModel>(
                                                      context)
                                                  .arryTallas,
                                              idSelec:
                                                  Provider.of<ProductosModel>(
                                                          context)
                                                      .tallaSelect,
                                            )))
                                  ]))
                            ]))
                      ]))),
                  decoration: BoxDecoration(
                      color: Color(0xfffafbfd),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )))),
          Positioned(
              bottom: mQ(context, 'h', .58),
              child: Visibility(
                  visible: true,
                  child: Container(
                    width: mQ(context, 'w', 1),
                    alignment: Alignment.topCenter,
                    child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(15),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                                child: InkWell(
                              onTap: () => shareImg(context, prodData.urlImg),
                              child: CachedNetworkImage(
                                  width: mQ(context, 'w', .7),
                                  height: mQ(context, 'w', .7),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  imageUrl: Provider.of<ProductosModel>(context)
                                      .imgProd),
                            )))),
                  )))
        ],
      ),
    );
  }
}
