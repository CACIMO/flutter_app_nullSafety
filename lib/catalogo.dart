import 'newprod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'utils.dart';
import 'models.dart';

class Catalogo extends StatefulWidget {
  @override
  _Catalogo createState() => new _Catalogo();
}

class _Catalogo extends State<Catalogo> {
  final TextEditingController controllerBusq = TextEditingController();

  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();

  GlobalKey filterKey = GlobalKey();

  ScrollController controllerScroll = new ScrollController();

  Map<String, bool> conf = {'CT': true, 'TG': true, 'CL': true, 'TL': true};

  List<String> color = [];
  // ignore: non_constant_identifier_names
  Map<String, bool> ColorsCheks = {};
  // ignore: non_constant_identifier_names
  Map<String, String> ColorsId = {};
  // ignore: non_constant_identifier_names
  Map<String, List<String>> Combs = {};
  // ignore: non_constant_identifier_names
  List ColorsIdSelect = [];
  // ignore: non_constant_identifier_names
  List<String> tallas = [];
  // ignore: non_constant_identifier_names
  Map<String, bool> tallasCheks = {};
  // ignore: non_constant_identifier_names
  Map<String, String> tallasId = {};
  List tallasIdSelect = [];

  bool habilitarEdicion = true;

  List<String> categorias = [];
  Map<String, bool> categoriasCheks = {};
  Map<String, String> categoriasId = {};
  List categoriasIdSelect = [];

  List<String> tags = [];
  Map<String, bool> tagCheks = {};
  Map<String, String> tagId = {};
  List tagIdSelect = [];

  List<dynamic> productos = [];

  List<Widget> items = [];

  int init = 0;
  int last = 0;

  void getInitialData() async {
    getCategory();
    getColor();
    getTag();
    getTalla();
  }

  void actionTg() {
    setState(() {
      conf['TG'] = !(conf['TG'] ?? true);
    });
  }

  void actionCt() {
    setState(() {
      conf['CT'] = !(conf['CT'] ?? true);
    });
  }

  void actionCl() {
    setState(() {
      conf['CL'] = !(conf['CL'] ?? true);
    });
  }

  void actionTl() {
    setState(() {
      conf['TL'] = !(conf['TL'] ?? true);
    });
  }

  void getCategory() {
    categorias = [];
    categoriasCheks = {};
    categoriasId = {};
    httpGet(this.context, 'categoria', false).then((resp) {
      setState(() {
        List data = resp['data'];
        data.forEach((item) {
          categorias.add(item['titulo']);
          categoriasCheks[item['titulo']] = false;
          categoriasId[item['titulo']] = item['_id'];
        });
      });
    });
  }

  void getTalla() {
    tallas = [];
    tallasCheks = {};
    tallasId = {};
    httpGet(this.context, 'talla', false).then((resp) {
      setState(() {
        List data = resp['data'];
        data.forEach((item) {
          tallas.add(item['titulo']);
          tallasCheks[item['titulo']] = false;
          tallasId[item['titulo']] = item['_id'];
        });
      });
    });
  }

  void getTag() {
    tags = [];
    tagCheks = {};
    tagId = {};
    httpGet(this.context, 'tag', false).then((resp) {
      setState(() {
        List data = resp['data'];
        data.forEach((item) {
          tags.add(item['titulo']);
          tagCheks[item['titulo']] = false;
          tagId[item['titulo']] = item['_id'];
        });
      });
    }).catchError((error) {
      print('Esto Fallo $error');
    });
  }

  void getColor() {
    color = [];
    ColorsCheks = {};
    Combs = {};
    ColorsId = {};
    httpGet(this.context, 'color', false).then((resp) {
      setState(() {
        List data = resp['data'];
        data.forEach((item) {
          color.add(item['titulo']);
          ColorsCheks[item['titulo']] = false;
          Combs[item['titulo']] = [item['primario'], item['segundario']];
          ColorsId[item['titulo']] = item['_id'];
        });
      });
    });
  }

  void changeCheck(ctx, type, titulo, bool value, Function callback) {
    callback();
    ColorsIdSelect = [];
    categoriasIdSelect = [];
    tagIdSelect = [];
    tallasIdSelect = [];

    ColorsCheks.forEach((key, value) {
      if (value) ColorsIdSelect.add(ColorsId[key]);
    });
    categoriasCheks.forEach((key, value) {
      if (value) categoriasIdSelect.add(categoriasId[key]);
    });

    tallasCheks.forEach((key, value) {
      if (value) tallasIdSelect.add(tallasId[key]);
    });

    tagCheks.forEach((key, value) {
      if (value) tagIdSelect.add(tagId[key]);
    });

    getProduct(context, controllerBusq.text);
/* 
    Toast.show("${value ? 'Activado' : 'Desactivado'} Correctamente", ctx,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM); */
  }

  void getProduct(ctx, prod) {
    Map<String, String> params = {
      'cat': jsonEncode(categoriasIdSelect),
      'col': jsonEncode(ColorsIdSelect),
      'tag': jsonEncode(tagIdSelect),
      'tal': jsonEncode(tallasIdSelect),
    };
    httpPut(
            this.context,
            'producto/${(prod == null || prod == '') ? 'null' : prod}',
            params,
            false)
        .then((resp) {
      setState(() {
        items = convertOnList(resp['data']);
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  List<Widget> convertOnList(List prods) {
    List<Widget> auxList = [];
    prods.forEach((item) {
      //print(ItemList(product: item));
      auxList.add(ItemList(
          product: item,
          ctx: this.context,
          voidCallBack: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Catalogo()));
          }));
      auxList.add(Divider());
    });
    return auxList;
  }

  void _scrollListener() {
    /*  if (controllerScroll.position.extentAfter.round() == 0) {
      setState(() {
        items.addAll(new List.generate(42, (index) => Text('Inserted $index')));
      });
    } */
    print('');
  }

  @override
  void initState() {
    controllerScroll..addListener(_scrollListener);
    super.initState();
    getInitialData();
    getProduct(context, null);
  }

  @override
  void dispose() {
    controllerScroll..removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        key: scafoldKey,
        drawer: Container(
            width: mediaQuery(ctx, 'w', .70), child: menuOptions(ctx)),
        endDrawer: Container(
            width: mediaQuery(ctx, 'w', .70),
            child: Drawer(
                child: Container(
                    padding: EdgeInsets.only(
                        top: mediaQuery(ctx, 'h', .08),
                        left: mediaQuery(ctx, 'w', .05),
                        right: mediaQuery(ctx, 'w', .05)),
                    child: Column(children: [
                      Row(children: [
                        Expanded(
                            child: Container(
                                child: Text('Filtros de Busqueda',
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Light',
                                        fontSize: mediaQuery(ctx, 'h', .03)))))
                      ]),
                      Container(
                          height: mediaQuery(ctx, 'h', .8),
                          child: ListView(children: [
                            Row(children: [
                              Expanded(
                                  flex: 8,
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          top: mediaQuery(ctx, 'w', .01),
                                          bottom: mediaQuery(ctx, 'w', .03)),
                                      child: Text('Colores',
                                          style: TextStyle(
                                              fontFamily: 'Roboto-Light',
                                              fontSize: mediaQuery(
                                                  ctx, 'h', .022))))),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          top: mediaQuery(ctx, 'w', .01),
                                          bottom: mediaQuery(ctx, 'w', .03)),
                                      child: IconButton(
                                          icon: Icon((conf['CL'] ?? true)
                                              ? Icons.arrow_drop_down
                                              : Icons.arrow_drop_up),
                                          onPressed: () => actionCl()))),
                            ]),
                            Row(children: [
                              Expanded(
                                  child: Visibility(
                                      visible: !(conf['CL'] ?? true),
                                      child: Container(
                                          child: Column(
                                              children: color.map((item) {
                                        return Row(children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Checkbox(
                                                onChanged: (val) {
                                                  changeCheck(
                                                      ctx,
                                                      'CL',
                                                      item,
                                                      !(ColorsCheks[item] ??
                                                          false), () {
                                                    setState(() {
                                                      ColorsCheks[item] =
                                                          !(ColorsCheks[item] ??
                                                              false);
                                                    });
                                                  });
                                                },
                                                value: ColorsCheks[item]),
                                          ),
                                          /* Expanded(
                                              flex: 6,
                                              child: Text(item,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Light',
                                                      fontSize:  mediaQuery(ctx, 'h', .02))))，*/
                                          Container(
                                            width: 34,
                                            height: 34,
                                            child: Card(
                                                child: Container(
                                                    width: 34,
                                                    height: 34,
                                                    padding: EdgeInsets.all(7),
                                                    decoration: BoxDecoration(
                                                        color: Color(int.parse(
                                                            '0xFF${Combs[item]![0]}')),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Color(int.parse(
                                                                '0xFF${(Combs[item]![1] == '') ? Combs[item]![0] : Combs[item]![1]}')),
                                                            borderRadius:
                                                                BorderRadius.circular(20)))),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                          )
                                        ]);
                                      }).toList()))))
                            ]),
                            Row(children: [
                              Expanded(
                                  flex: 8,
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          top: mediaQuery(ctx, 'w', .01),
                                          bottom: mediaQuery(ctx, 'w', .03)),
                                      child: Text('Talla',
                                          style: TextStyle(
                                              fontFamily: 'Roboto-Light',
                                              fontSize: mediaQuery(
                                                  ctx, 'h', .022))))),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          top: mediaQuery(ctx, 'w', .01),
                                          bottom: mediaQuery(ctx, 'w', .03)),
                                      child: IconButton(
                                          icon: Icon((conf['TL'] ?? true)
                                              ? Icons.arrow_drop_down
                                              : Icons.arrow_drop_up),
                                          onPressed: () => actionTl()))),
                            ]),
                            Row(children: [
                              Expanded(
                                  child: Visibility(
                                      visible: !(conf['TL'] ?? true),
                                      child: Container(
                                          child: Column(
                                              children: tallas.map((item) {
                                        return Row(children: [
                                          Expanded(
                                              flex: 2,
                                              child: Checkbox(
                                                  onChanged: (val) {
                                                    changeCheck(
                                                        ctx,
                                                        'TL',
                                                        item,
                                                        !(tallasCheks[item] ??
                                                            false), () {
                                                      setState(() {
                                                        tallasCheks[item] =
                                                            !(tallasCheks[
                                                                    item] ??
                                                                false);
                                                      });
                                                    });
                                                  },
                                                  value: tallasCheks[item])),
                                          Expanded(
                                              flex: 8,
                                              child: Text(item,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Light',
                                                      fontSize: mediaQuery(
                                                          ctx, 'h', .02))))
                                        ]);
                                      }).toList()))))
                            ]),
                            Row(children: [
                              Expanded(
                                  flex: 8,
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          top: mediaQuery(ctx, 'w', .01),
                                          bottom: mediaQuery(ctx, 'w', .03)),
                                      child: Text('Categorias',
                                          style: TextStyle(
                                              fontFamily: 'Roboto-Light',
                                              fontSize: mediaQuery(
                                                  ctx, 'h', .022))))),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          top: mediaQuery(ctx, 'w', .01),
                                          bottom: mediaQuery(ctx, 'w', .03)),
                                      child: IconButton(
                                          icon: Icon((conf['CT'] ?? false)
                                              ? Icons.arrow_drop_down
                                              : Icons.arrow_drop_up),
                                          onPressed: () => actionCt()))),
                            ]),
                            Row(children: [
                              Expanded(
                                  child: Visibility(
                                      visible: !(conf['CT'] ?? false),
                                      child: Container(
                                          child: Column(
                                              children: categorias.map((item) {
                                        return Row(children: [
                                          Expanded(
                                              flex: 2,
                                              child: Checkbox(
                                                  onChanged: (val) {
                                                    changeCheck(
                                                        ctx,
                                                        'CT',
                                                        item,
                                                        !(categoriasCheks[
                                                                item] ??
                                                            false), () {
                                                      setState(() {
                                                        categoriasCheks[item] =
                                                            !(categoriasCheks[
                                                                    item] ??
                                                                false);
                                                      });
                                                    });
                                                  },
                                                  value:
                                                      categoriasCheks[item])),
                                          Expanded(
                                              flex: 8,
                                              child: Text(item,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Light',
                                                      fontSize: mediaQuery(
                                                          ctx, 'h', .02))))
                                        ]);
                                      }).toList()))))
                            ]),
                            Row(children: [
                              Expanded(
                                  flex: 8,
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          top: mediaQuery(ctx, 'w', .01),
                                          bottom: mediaQuery(ctx, 'w', .03)),
                                      child: Text('Tags',
                                          style: TextStyle(
                                              fontFamily: 'Roboto-Light',
                                              fontSize: mediaQuery(
                                                  ctx, 'h', .022))))),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          top: mediaQuery(ctx, 'w', .01),
                                          bottom: mediaQuery(ctx, 'w', .03)),
                                      child: IconButton(
                                          icon: Icon((conf['TG'] ?? false)
                                              ? Icons.arrow_drop_down
                                              : Icons.arrow_drop_up),
                                          onPressed: () => actionTg()))),
                            ]),
                            Row(children: [
                              Expanded(
                                  child: Visibility(
                                      visible: !(conf['TG'] ?? false),
                                      child: Container(
                                          child: Column(
                                              children: tags.map((item) {
                                        return Row(children: [
                                          Expanded(
                                              flex: 2,
                                              child: Checkbox(
                                                  onChanged: (val) {
                                                    changeCheck(
                                                        ctx,
                                                        'TG',
                                                        item,
                                                        !(tagCheks[item] ??
                                                            false), () {
                                                      setState(() {
                                                        tagCheks[item] =
                                                            !(tagCheks[item] ??
                                                                false);
                                                      });
                                                    });
                                                  },
                                                  value: tagCheks[item])),
                                          Expanded(
                                              flex: 8,
                                              child: Text(item,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Light',
                                                      fontSize: mediaQuery(
                                                          ctx, 'h', .02))))
                                        ]);
                                      }).toList()))))
                            ])
                          ]))
                    ])))),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    top: mediaQuery(ctx, 'h', .05),
                    left: mediaQuery(ctx, 'w', .05),
                    right: mediaQuery(ctx, 'w', .05)),
                child: Column(
                  children: [
                    Container(
                        //padding: EdgeInsets.only(top: ScQuery(ctx)['h'] * .05),
                        height: mediaQuery(ctx, 'h', .26),
                        child: Column(children: [
                          Row(children: [
                            Expanded(
                                flex: 7,
                                child: Container(
                                    child: Text('Catalogo',
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Light',
                                            fontSize:
                                                mediaQuery(ctx, 'h', .05))))),
                            Expanded(
                                flex: 2,
                                child: Container(
                                    child: IconButton(
                                        onPressed: () => scafoldKey
                                            .currentState!
                                            .openEndDrawer(),
                                        icon: Icon(
                                          CupertinoIcons.slider_horizontal_3,
                                          size: 18,
                                        )))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    child: IconButton(
                                        onPressed: () {
                                          scafoldKey.currentState!.openDrawer();
                                        },
                                        icon: Icon(
                                          CupertinoIcons.sidebar_left,
                                          size: 18,
                                        ))))
                          ]),
                          Row(children: [
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(
                                        top: mediaQuery(ctx, 'w', .01)),
                                    child: Text('Categorias',
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Thin',
                                            fontSize:
                                                mediaQuery(ctx, 'h', .03)))))
                          ]),
                          Divider(),
                          Container(
                            //height: mediaQuery(ctx, 'h', .0),
                            child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 3,
                                child: Container(
                                    width: mediaQuery(ctx, 'w', .9),
                                    child: TextFormField(
                                        autofocus: false,
                                        maxLength: 100,
                                        controller: controllerBusq,
                                        onChanged: (val) {
                                          getProduct(
                                              context, controllerBusq.text);
                                        },
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                                Icons.search_outlined,
                                                color: Color(0xFFAAAAAA),
                                                size: 20),
                                            counterText: '',
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1)),
                                            hintText: 'Busqueda',
                                            hintStyle: TextStyle(
                                                color: Color(0xFFAAAAAA)),
                                            fillColor: Color(0xFFEBEBEB))))),
                          ),
                          Row(children: [
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(
                                        top: mediaQuery(ctx, 'h', .02)),
                                    child: Text('PRODUCTOS',
                                        style: TextStyle(
                                            fontSize:
                                                mediaQuery(ctx, 'h', .015),
                                            fontFamily: 'Roboto-Light'))))
                          ]),
                          Divider(),
                        ])),
                    Container(
                      height: mediaQuery(ctx, 'h', .65),
                      child: ListView(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        primary: false,
                        controller: controllerScroll,
                        children: items,
                      ),
                    )
                  ],
                ))));
  }
}
