import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/newprod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'catalogo.dart';
import 'utils.dart';

//Models Class
class Error extends StatefulWidget {
  final String msg;
  Error({Key? key, required this.msg}) : super(key: key);

  @override
  _ErrorState createState() => _ErrorState(this.msg);
}

class _ErrorState extends State<Error> {
  final String _msg;

  _ErrorState(this._msg);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: mediaQuery(context, 'h', .07),
        child: Column(children: [
          Row(children: [
            Expanded(
                flex: 2,
                child: Icon(CupertinoIcons.xmark_circle,
                    color: Colors.red.withOpacity(.75),
                    size: mediaQuery(context, 'h', .05))),
            Expanded(
                flex: 8,
                child: Text(this._msg,
                    style: TextStyle(
                        fontFamily: 'Roboto-Light',
                        fontSize: mediaQuery(context, 'h', .022))))
          ])
        ]));
  }
}

class ActionAlert extends StatefulWidget {
  final String msg;
  ActionAlert({Key? key, required this.msg}) : super(key: key);

  @override
  _ActionState createState() => _ActionState(this.msg);
}

class _ActionState extends State<ActionAlert> {
  final String _msg;

  _ActionState(this._msg);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: mediaQuery(context, 'h', .07),
        child: Column(children: [
          Row(children: [
            Expanded(
                flex: 2,
                child: Icon(CupertinoIcons.question_circle,
                    color: Colors.orange.withOpacity(.75),
                    size: mediaQuery(context, 'h', .05))),
            Expanded(
                flex: 8,
                child: Text(this._msg,
                    style: TextStyle(
                        fontFamily: 'Roboto-Light',
                        fontSize: mediaQuery(context, 'h', .022))))
          ])
        ]));
  }
}

class Success extends StatefulWidget {
  final String msg;
  Success({Key? key, required this.msg}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState(this.msg);
}

class _SuccessState extends State<Success> {
  final String _msg;

  _SuccessState(this._msg);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: mediaQuery(context, 'h', .07),
        child: Column(children: [
          Row(children: [
            Expanded(
                flex: 2,
                child: Icon(CupertinoIcons.checkmark_alt_circle,
                    color: Colors.green.withOpacity(.75),
                    size: mediaQuery(context, 'h', .05))),
            Expanded(
                flex: 8,
                child: Text(this._msg,
                    style: TextStyle(
                        fontFamily: 'Roboto-Light',
                        fontSize: mediaQuery(context, 'h', .022))))
          ])
        ]));
  }
}

class Load extends StatefulWidget {
  Load({Key? key}) : super(key: key);

  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
            backgroundColor: Colors.blue.withOpacity(0.25)));
  }
}

class MenuBtn extends StatefulWidget {
  final Icon icono;
  final String title;
  final Widget nextPage;
  MenuBtn(
      {Key? key,
      required this.icono,
      required this.title,
      required this.nextPage})
      : super(key: key);

  @override
  _MenuBtnState createState() =>
      _MenuBtnState(this.icono, this.title, this.nextPage);
}

class _MenuBtnState extends State<MenuBtn> {
  final Icon _icono;
  final String _title;
  final Widget _nextPage;

  _MenuBtnState(this._icono, this._title, this._nextPage);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: 50,
          child: InkWell(
              onTap: () {
                if (_title == 'Enviar Formato') {
                  downloadFormat(context);
                } else
                  Navigator.push(
                      context, MaterialPageRoute(builder: (ctx) => _nextPage));
              },
              child: Row(children: [
                Expanded(flex: 1, child: Container(child: this._icono)),
                Expanded(
                    flex: 9,
                    child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(this._title,
                            style: TextStyle(
                                fontFamily: 'Roboto-Light', fontSize: 18))))
              ]))),
      Divider()
    ]);
  }
}

class ItemList extends StatefulWidget {
  final product;
  final BuildContext ctx;
  final Function voidCallBack;
  final Function voidCallBack1;
  ItemList(
      {Key? key,
      this.product,
      required this.ctx,
      required this.voidCallBack,
      required this.voidCallBack1})
      : super(key: key);

  @override
  _ItemListState createState() => _ItemListState(
      this.product, this.ctx, this.voidCallBack, this.voidCallBack1);
}

class _ItemListState extends State<ItemList> {
  final BuildContext _ctx;
  final _prod;
  final Function _voidCallBack;
  final Function _voidCallBack1;

  _ItemListState(
      this._prod, this._ctx, this._voidCallBack, this._voidCallBack1);

  List<Widget> colorData = [];
  List<Widget> tallaData = [];

  void deleteProd(idProd) {
    actionMsg(
        _ctx,
        '¿Desea eliminar este producto?',
        () => httpGet(_ctx, 'producto/$idProd', false).then((resp) {
              successMsg(_ctx, 'Producto eliminado correctamente.')
                  .then((v) => _voidCallBack());
            }).catchError((resp) {
              errorMsg(context, 'Eliminar producto',
                  'Este producto esta uso y no puede ser eliminado');
            }));
  }

  Future<void> _showModal(ctxs, data, Function callback) async {
    return showModalBottomSheet<void>(
        context: ctxs,
        isScrollControlled: true,
        barrierColor: Colors.black.withOpacity(0.3),
        backgroundColor: Colors.transparent,
        builder: (BuildContext ctx) {
          return Producto(data: data, callBack: callback);
        });
  }

  void fillArrays() {
    List auxColor = _prod['colorData'];
    auxColor.forEach((color) {
      setState(() {
        colorData.add(Container(
          height: 16,
          width: 16,
          padding: EdgeInsets.all(4),
          child: Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
                color: Color(int.parse(
                    '0xFF${color['segundario'] == '' ? color['segundario'] : color['primario']}')),
                borderRadius: BorderRadius.circular(8)),
          ),
          decoration: BoxDecoration(
              color: Color(int.parse('0xFF${color['primario']}')),
              borderRadius: BorderRadius.circular(8)),
        ));
      });
    });

    List auxTalla = _prod['tallaData'];
    auxTalla.forEach((talla) {
      setState(() {
        tallaData.add(Container(
            padding: EdgeInsets.only(left: 2, right: 2),
            margin: EdgeInsets.only(left: 2),
            child: Text(talla['titulo'],
                style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: mediaQuery(_ctx, 'h', .013))),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(5))));
      });
    });
  }

  @override
  void initState() {
    fillArrays();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: InkWell(
          onTap: () => _showModal(context, _prod, _voidCallBack1),
          child: Container(
              child: Column(children: [
            Row(children: [
              Expanded(
                  child: Container(
                      height: mediaQuery(this.context, 'h', .15),
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                  height: mediaQuery(this.context, 'h', .15),
                                  width: mediaQuery(this.context, 'h', .15),
                                  child: CachedNetworkImage(
                                      width: mediaQuery(this.context, 'w', .7),
                                      height: mediaQuery(this.context, 'w', .7),
                                      placeholder: (context, url) => Container(
                                          padding: EdgeInsets.all(30),
                                          child: CircularProgressIndicator()),
                                      imageUrl:
                                          'http://$urlDB/getimg/${this._prod['_id']}'))),
                          Expanded(
                              flex: 7,
                              child: Container(
                                  height: mediaQuery(this.context, 'h', .15),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 2,
                                                    left: 10,
                                                    bottom: 2),
                                                child: Text(
                                                    this._prod['titulo'],
                                                    style: TextStyle(
                                                        fontSize: mediaQuery(
                                                            this.context,
                                                            'h',
                                                            .02),
                                                        fontFamily:
                                                            'Roboto-Light'))))
                                      ],
                                    ),
                                    Row(children: [
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 5),
                                          child: Text('Color:',
                                              style: TextStyle(
                                                  fontSize: mediaQuery(
                                                      this.context, 'h', .017),
                                                  color: Colors.black54,
                                                  fontFamily: 'Roboto-Light'))),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10, bottom: 5),
                                        child: Column(
                                          children: [Row(children: colorData)],
                                        ),
                                      )
                                    ]),
                                    Row(children: [
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 5),
                                          child: Text('Cantidad:',
                                              style: TextStyle(
                                                  fontSize: mediaQuery(
                                                      this.context, 'h', .017),
                                                  color: Colors.black54,
                                                  fontFamily: 'Roboto-Light'))),
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 5),
                                          child: Text(
                                              this._prod['stock'].toString(),
                                              style: TextStyle(
                                                  fontSize: mediaQuery(
                                                      this.context, 'h', .017),
                                                  fontFamily: 'Roboto-Light')))
                                    ]),
                                    Row(children: [
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 5),
                                          child: Text('Tallas:',
                                              style: TextStyle(
                                                  fontSize: mediaQuery(
                                                      this.context, 'h', .017),
                                                  color: Colors.black54,
                                                  fontFamily: 'Roboto-Light'))),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10, bottom: 5),
                                        child: Column(
                                          children: [Row(children: tallaData)],
                                        ),
                                      )
                                    ]),
                                    Row(children: [
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 5),
                                          child: Text('Valor:',
                                              style: TextStyle(
                                                  fontSize: mediaQuery(
                                                      this.context, 'h', .017),
                                                  color: Colors.black54,
                                                  fontFamily: 'Roboto-Light'))),
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 5),
                                          child: Text(
                                              NumberFormat.simpleCurrency()
                                                  .format(
                                                      this._prod['valor'] ?? 0),
                                              style: TextStyle(
                                                  fontSize: mediaQuery(
                                                      this.context, 'h', .017),
                                                  fontFamily: 'Roboto-Light')))
                                    ])
                                  ])))
                        ])
                      ])))
            ]),
          ]))),
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Editar',
            color: Colors.blue.withOpacity(0.8),
            icon: CupertinoIcons.pencil_ellipsis_rectangle,
            onTap: () {
              access('mprod')
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => NuevoProd(prodInfo: this._prod)))
                  : errorMsg(
                      _ctx, 'Error de aceso', 'No puedes modificar productos');
            }),
        IconSlideAction(
            caption: 'Borrar',
            color: Colors.red.withOpacity(0.8),
            icon: CupertinoIcons.trash,
            onTap: () => access('eprod')
                ? deleteProd(_prod['_id'])
                : errorMsg(
                    _ctx, 'Error de aceso', 'No puedes eliminar productos')),
      ],
    );
  }
}

class Producto extends StatefulWidget {
  final data;
  final Function callBack;

  const Producto({Key? key, this.data, required this.callBack})
      : super(key: key);

  @override
  _Producto createState() => _Producto(this.data, this.callBack);
}

class _Producto extends State<Producto> {
  final data;
  final Function _callBack;

  _Producto(this.data, this._callBack);

  Map<String, bool> conf = {'CT': true, 'TG': true, 'CL': true, 'TL': true};

  List<String> color = [];
  // ignore: non_constant_identifier_names
  Map<String, bool> ColorsCheks = {};
  // ignore: non_constant_identifier_names
  Map<String, String> ColorsId = {};
  // ignore: non_constant_identifier_names
  Map<String, List<String>> Combs = {};

  List<String> tallas = [];
  Map<String, bool> tallasCheks = {};
  Map<String, String> tallasId = {};
  int counter = 0;
  List<String> categorias = [];
  Map<String, bool> categoriasCheks = {};
  Map<String, String> categoriasId = {};
  String colorKey = '';
  String tallasKey = '';

  TextEditingController precioController = TextEditingController();

  void actionCl() {
    setState(() {
      conf['CL'] = !(conf['CL'] ?? false);
    });
  }

  void actionTl() {
    setState(() {
      conf['TL'] = !(conf['TL'] ?? false);
    });
  }

  void updateCounter(bool acc) {
    setState(() {
      if (acc)
        // ignore: unnecessary_statements
        counter < data['stock'] ? counter++ : null;
      else
        // ignore: unnecessary_statements
        counter > 0 ? counter-- : null;
    });
  }

  void _modifyColor(item) {
    ColorsCheks.forEach((key, bool value) {
      if (key != item)
        setState(() {
          ColorsCheks[key] = value ? false : true;
        });
    });
    colorKey = colorKey == item ? '' : item;
  }

  void _modifyTalla(item) {
    tallasCheks.forEach((key, bool value) {
      if (key != item)
        setState(() {
          tallasCheks[key] = value ? false : true;
        });
    });
    tallasKey = tallasKey == item ? '' : item;
  }

  bool visi = true;
  var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    precioController.text = data['valor'].toString();
    data['tallaData'].forEach((item) {
      tallas.add(item['titulo']);
      tallasCheks[item['titulo']] = true;
      tallasId[item['titulo']] = item['_id'];
    });
    data['colorData'].forEach((item) {
      color.add(item['titulo']);
      ColorsCheks[item['titulo']] = true;
      Combs[item['titulo']] = [item['primario'], item['segundario']];
      ColorsId[item['titulo']] = item['_id'];
    });
  }

  void enviarACarrito(ctx) async {
    if (colorKey == '') {
      errorMsg(ctx, 'Error en el catalogo', 'Por favor seleccione un color.');
      return;
    }
    if (tallasKey == '') {
      errorMsg(ctx, 'Error en Catalogo', 'Por favor seleccione una talla.');
      return;
    }

    String tallaSelected = tallasId[tallasKey]!;
    String colorSelected = ColorsId[colorKey]!;

    bool flag = true;
    Map<String, String> dataSend = {
      "producto": data['_id'],
      "precio": precioController.text,
      "talla": tallaSelected,
      "color": colorSelected,
      'cantidad': counter.toString()
    };

    for (final key in dataSend.keys) {
      if (dataSend[key] == '' ||
          dataSend[key] == null ||
          dataSend[key] == '0') {
        flag = false;
        errorMsg(ctx, 'Error en Catalogo',
            'Verifique el campo ${key[0].toUpperCase()}${key.substring(1)}.');
        break;
      }
    }
    if (flag) {
      httpPost(ctx, 'carrito', dataSend, true).then((resp) {
        successMsg(ctx, 'Agregado Correctamente.').then((value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Catalogo()));
        });
      }).catchError((onError) {
        errorMsg(ctx, 'Error en Catalogo', 'Error al agregar');
      });
    }
  }

  void _alertQr(ctx, data) {
    if (colorKey == '' || tallasKey == '')
      errorMsg(ctx, 'Error', 'Debe seleccionar talla y color.');
    else {
      Map jsonAux = {
        '_id': data['_id'],
        'refVendedora': data['refVendedora'],
        'refInterna': data['refInterna'],
        'tallaData': tallasId[tallasKey],
        'colorData': ColorsId[colorKey],
      };
      print(jsonAux);
      alertQr(ctx, jsonAux);
    }
  }

  @override
  Widget build(BuildContext ctx) {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      setState(() {
        visi = false;
      });
    } else {
      setState(() {
        visi = true;
      });
    }
    return Container(
        height: mediaQuery(ctx, 'h', 1),
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                child: Container(
                    height: mediaQuery(ctx, 'h', .57),
                    width: mediaQuery(ctx, 'w', 1),
                    padding: EdgeInsets.only(
                        top: mediaQuery(ctx, 'h', .09), left: 30, right: 30),
                    margin: EdgeInsets.only(top: mediaQuery(ctx, 'h', .4)),
                    child: Scaffold(
                        floatingActionButton: FloatingActionButton(
                          onPressed: () => access('venta')
                              ? enviarACarrito(context)
                              : errorMsg(
                                  ctx, 'Error de Aceso', 'No tienes permisos.'),
                          child: Icon(CupertinoIcons.cart_badge_plus),
                        ),
                        body: Container(
                            child: Column(children: [
                          Row(children: [
                            Expanded(
                              flex: 8,
                              child: Text('${data['titulo']}',
                                  style: TextStyle(
                                      fontSize: mediaQuery(ctx, 'h', .030),
                                      fontFamily: 'Roboto-Light')),
                            ),
                            Expanded(
                                flex: 2,
                                child: IconButton(
                                  onPressed: () => _alertQr(ctx, this.data),
                                  icon: Icon(CupertinoIcons.qrcode),
                                ))
                          ]),
                          Divider(),
                          Container(
                              height: mediaQuery(ctx, 'h', .37),
                              child: Column(children: [
                                Container(
                                    height: mediaQuery(ctx, 'h', .08),
                                    child: Row(children: [
                                      Expanded(
                                          flex: 4,
                                          child: Container(
                                              child: Text('Cantidad: ',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Light',
                                                      fontSize: mediaQuery(
                                                          ctx, 'h', .022))))),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              child: IconButton(
                                            onPressed: () =>
                                                updateCounter(false),
                                            icon: Icon(Icons.remove_outlined,
                                                color: Color(0xFFff472f)
                                                    .withOpacity(.7)),
                                          ))),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text('$counter',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Light',
                                                      fontSize: mediaQuery(
                                                          ctx, 'h', .022))))),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              child: IconButton(
                                            onPressed: () =>
                                                updateCounter(true),
                                            icon: Icon(Icons.add_outlined,
                                                color: Color(0xFF05b071)
                                                    .withOpacity(.7)),
                                          ))),
                                    ])),
                                Container(
                                  height: mediaQuery(ctx, 'h', .08),
                                  child: Row(children: [
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                            child: Text('Precio: ',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto-Light',
                                                    fontSize: mediaQuery(
                                                        ctx, 'h', .022))))),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            child: Text('\$',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto-Light',
                                                    fontSize: mediaQuery(
                                                        ctx, 'h', .022))))),
                                    Expanded(
                                        flex: 6,
                                        child: Container(
                                            //margin:EdgeInsets.only(top:heightApp*.015),
                                            child: TextFormField(
                                                onFieldSubmitted: (val) =>
                                                    {focusNode.unfocus()},
                                                maxLength: 30,
                                                focusNode: focusNode,
                                                controller: precioController,
                                                autofocus: false,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(0),
                                                    counterText: "",
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide
                                                                    .none),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide
                                                                    .none),
                                                    hintText: 'Precio',
                                                    hintStyle: TextStyle(
                                                        color:
                                                            Color(0xFFAAAAAA)),
                                                    fillColor:
                                                        Color(0xFFEBEBEB))))),
                                  ]),
                                ),
                                Container(
                                  height: mediaQuery(ctx, 'h', .08),
                                  child: Row(children: [
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                            child: Text('Colores:',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto-Light',
                                                    fontSize: mediaQuery(
                                                        ctx, 'h', .022))))),
                                    Expanded(
                                        flex: 7,
                                        child: Container(
                                            width: mediaQuery(ctx, 'w', .7),
                                            child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: color.map((item) {
                                                  return Row(children: [
                                                    Container(
                                                        width: 30,
                                                        height: 30,
                                                        child: Visibility(
                                                          visible: (ColorsCheks[
                                                                  item] ??
                                                              false),
                                                          child: FloatingActionButton(
                                                              onPressed: () =>
                                                                  _modifyColor(
                                                                      item),
                                                              elevation: 2,
                                                              backgroundColor:
                                                                  Color(int.parse(
                                                                      '0xFF${Combs[item]![0]}')),
                                                              child: Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  decoration: BoxDecoration(
                                                                      color: Color(
                                                                          int.parse(
                                                                              '0xFF${(Combs[item]![1] == '') ? Combs[item]![0] : Combs[item]![1]}')),
                                                                      borderRadius:
                                                                          BorderRadius.circular(18)))),
                                                        ))
                                                  ]);
                                                }).toList())))
                                  ]),
                                ),
                                Container(
                                    height: mediaQuery(ctx, 'h', .08),
                                    child: Row(children: [
                                      Expanded(
                                          flex: 3,
                                          child: Container(
                                              child: Text('Tallas:',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Light',
                                                      fontSize: mediaQuery(
                                                          ctx, 'h', .022))))),
                                      Expanded(
                                          flex: 7,
                                          child: Container(
                                              width: mediaQuery(ctx, 'w', .7),
                                              child: ListView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: tallas.map((item) {
                                                    return Row(children: [
                                                      Container(
                                                          width: mediaQuery(
                                                              ctx, 'w', .15),
                                                          height: 30,
                                                          child: Visibility(
                                                              visible:
                                                                  (tallasCheks[item] ??
                                                                      false),
                                                              child: ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      onPrimary:
                                                                          Colors
                                                                              .black26,
                                                                      primary:
                                                                          Color(
                                                                              0xfffafbfd),
                                                                      side: BorderSide(
                                                                          width:
                                                                              1,
                                                                          color: Colors
                                                                              .black26)),
                                                                  onPressed: () =>
                                                                      _modifyTalla(item),
                                                                  child: Container(child: Text(item, style: TextStyle(color: Colors.black, fontFamily: 'Roboto-Light', fontSize: mediaQuery(ctx, 'h', .02)))))))
                                                    ]);
                                                  }).toList())))
                                    ]))
                              ]))
                        ]))),
                    decoration: BoxDecoration(
                        color: Color(0xfffafbfd),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )))),
            Visibility(
                visible: visi,
                child: Container(
                  height: mediaQuery(ctx, 'h', .6),
                  margin: EdgeInsets.only(top: mediaQuery(ctx, 'h', .15)),
                  alignment: Alignment.topCenter,
                  child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(15),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                              child: CachedNetworkImage(
                                  width: mediaQuery(ctx, 'w', .7),
                                  height: mediaQuery(ctx, 'w', .7),
                                  placeholder: (context, url) => Container(
                                      padding: EdgeInsets.all(20),
                                      child: CircularProgressIndicator()),
                                  imageUrl:
                                      'http://$urlDB/getimg/${data['_id']}')))),
                ))
          ],
        ));
  }
}

class AlertVoucher extends StatefulWidget {
  final String msg;
  AlertVoucher({Key? key, required this.msg}) : super(key: key);

  @override
  _AlertVoucher createState() => _AlertVoucher(this.msg);
}

class _AlertVoucher extends State<AlertVoucher> {
  final String _msg;

  _AlertVoucher(this._msg);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: mediaQuery(context, 'h', .07),
        child: Column(children: [
          Row(children: [
            Expanded(
                flex: 2,
                child: Icon(CupertinoIcons.question_circle,
                    color: Colors.orange.withOpacity(.75),
                    size: mediaQuery(context, 'h', .05))),
            Expanded(
                flex: 8,
                child: Text(this._msg,
                    style: TextStyle(
                        fontFamily: 'Roboto-Light',
                        fontSize: mediaQuery(context, 'h', .022))))
          ])
        ]));
  }
}

class DateFormat extends StatefulWidget {
  final BuildContext context;

  const DateFormat({Key? key, required this.context}) : super(key: key);

  @override
  _DateFormat createState() => _DateFormat(this.context);
}

class _DateFormat extends State<DateFormat> {
  final BuildContext _context;

  _DateFormat(this._context);

  void selectDate(String text, String fec) async {
    DateTime date = (await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          helpText: text,
        )) ??
        DateTime.now();
    if (fec == 'f')
      setState(() {
        fecFinal = date;
      });
    else
      setState(() {
        fecInit = date;
      });
  }

  void sendData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('mail');
    if (email == null)
      errorMsg(context, 'Error en App', 'Vuelva a inciar session');
    else if (fecFinal.isBefore(fecInit)) {
      errorMsg(context, 'Error Formato',
          'La fecha final debe ser mayor a la inicial.');
    } else {
      httpPost(
              context,
              'email',
              {
                'fecini': fecInit.toString().split(' ')[0],
                'fecfin': fecFinal.toString().split(' ')[0],
                'email': email
              },
              false)
          .then((value) {
        Navigator.pop(context);
        successMsg(context, 'Por favor revice su email.');
      }).catchError((onError) {
        Navigator.pop(context);
        errorMsg(context, 'Error Formato', 'Error en el servidor');
      });
    }
  }

  DateTime fecInit = DateTime.now();
  DateTime fecFinal = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Row(children: [
        Expanded(
            flex: 4,
            child: Text('Fecha Inicial:',
                style: TextStyle(
                    fontFamily: 'Roboto-Ligth',
                    fontSize: mediaQuery(context, 'h', .02)))),
        Expanded(
            flex: 5,
            child: Text('${fecInit.toString().split(' ')[0]}',
                style: TextStyle(
                    fontFamily: 'Roboto-Ligth',
                    fontSize: mediaQuery(context, 'h', .02)))),
        Expanded(
            flex: 1,
            child: IconButton(
                onPressed: () async {
                  selectDate('Seleccione la fecha inical', 'i');
                },
                icon: Icon(CupertinoIcons.calendar,
                    size: mediaQuery(context, 'h', .02))))
      ]),
      Row(
        children: [
          Expanded(
              flex: 4,
              child: Text('Fecha Final:',
                  style: TextStyle(
                      fontFamily: 'Roboto-Ligth',
                      fontSize: mediaQuery(context, 'h', .02)))),
          Expanded(
              flex: 5,
              child: Text('${fecFinal.toString().split(' ')[0]}',
                  style: TextStyle(
                      fontFamily: 'Roboto-Ligth',
                      fontSize: mediaQuery(context, 'h', .02)))),
          Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () async {
                    selectDate('Seleccione la fecha final', 'f');
                  },
                  icon: Icon(CupertinoIcons.calendar,
                      size: mediaQuery(context, 'h', .02))))
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
            margin: EdgeInsets.only(right: 5),
            height: mediaQuery(context, 'h', .04),
            child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar',
                    style: TextStyle(
                        fontFamily: 'Roboto-Regular',
                        fontSize: mediaQuery(context, 'h', .02))))),
        Container(
            height: mediaQuery(context, 'h', .04),
            child: TextButton(
                onPressed: () => sendData(),
                child: Text('Enviar',
                    style: TextStyle(
                        fontFamily: 'Roboto-Regular',
                        fontSize: mediaQuery(context, 'h', .02)))))
      ])
    ]));
  }
}
