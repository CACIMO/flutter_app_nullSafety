import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/drawer_fil_model.dart';
import 'package:provider/provider.dart';

class ProductosModel extends ChangeNotifier {
  //ProductCatalogo
  List<Item> listProds = [];
  int init = 0;
  int last = 10;
  String busqueda = '';
  bool finder = false;
  Item? prodSelected;
  List<Talla> arryTallas = [];
  List<ColorD> arrayColors = [];
  int maxStock = 0;
  int cant = 0;
  String imgProd = '';
  //Product View
  int counter = 1;
  String colorSelect = 'none';
  String tallaSelect = 'none';
  FocusNode focusNode = FocusNode();

  Future getList(BuildContext context) async {
    List<String> auxColor =
        Provider.of<DrawerFilterModel>(context, listen: false).colorsIds;
    List<String> auxCateg =
        Provider.of<DrawerFilterModel>(context, listen: false).categoriasIds;
    List<String> auxTalla =
        Provider.of<DrawerFilterModel>(context, listen: false).tallasIds;
    List<String> auxTag =
        Provider.of<DrawerFilterModel>(context, listen: false).tagsIds;
    Map response = {};
    try {
      response = await postRequest('producto', {
        'prod_id': 'null',
        'init': init.toString(),
        'last': last.toString(),
        'busqueda': busqueda,
        'col': jsonEncode(auxColor),
        'cat': jsonEncode(auxCateg),
        'tag': jsonEncode(auxTag),
        'tal': jsonEncode(auxTalla)
      });
      if (finder) {
        cleanFinder();
        finder = false;
      }
      List prods = response['data'];
      prods.forEach((prod) {
        List<ColorD> colorData = [];
        List<Talla> tallaData = [];
        List colorsTemp = prod['colorData'];
        List tallasTemp = prod['tallaData'];
        colorsTemp.forEach((cl) {
          colorData.add(new ColorD(cl['primario'], cl['segundario'] ?? '',
              cl['titulo'], cl['_id'], false));
        });
        tallasTemp.forEach((tl) {
          tallaData.add(new Talla(tl['titulo'], tl['_id']));
        });
        addProd(new Item(
            prod['_id'],
            prod['titulo'],
            'http://$urlDB/getimg/preview/${prod['fileName']}',
            prod['valor'].toString(),
            prod['refVendedora'],
            prod['refInterna'],
            '',
            tallaData,
            colorData,
            '',
            prod['combinacion'],
            prod['costo'].toString(),
            prod['descripcion']));
      });
      init += 10;
      last += 10;
      return;
    } catch (e) {
      return Future.error(e);
    }
  }

  void addProd(Item item) {
    listProds.add(item);
    notifyListeners();
  }

  void setProd(Item prod) {
    prodSelected = prod;
    setProperties();
    notifyListeners();
  }

  void setProperties() {
    if (prodSelected != null) counter = 0;
  }

  void addCounter() {
    if (prodSelected != null) {
      counter += (counter < maxStock) ? 1 : 0;
      notifyListeners();
    }
  }

  void lessCounter() {
    if (prodSelected != null) {
      counter -= (counter > 1) ? 1 : 0;
      notifyListeners();
    }
  }

  void addColorViewProd(ColorD color) {
    arrayColors.add(color);
    notifyListeners();
  }

  void addTallaViewProd(Talla talla) {
    arryTallas.add(talla);
    notifyListeners();
  }

  void removeProd() {}

  void setSelectColor(String idcolor) {
    colorSelect = idcolor;
    notifyListeners();
  }

  void setSelectTalla(String idtalla) {
    tallaSelect = idtalla;
    notifyListeners();
  }

  void cleanFinder() {
    init = 0;
    last = 10;
    listProds = [];
    notifyListeners();
  }

  void changeDropDown() {
    counter = 0;
    if (tallaSelect != 'none' && colorSelect != 'none') {
      List<dynamic> combi = prodSelected!.combinaciones
          .where((combi) =>
              (combi['color'] == colorSelect && combi['talla'] == tallaSelect))
          .toList();
      print(combi);
      maxStock = (combi[0]['stock']);
      imgProd = (combi[0]['img']);
    } else
      maxStock = 0;
    notifyListeners();
  }

  Future addToCarrito(String precio) async {
    Map<String, String> dataRequest = {
      'precio': precio,
      'talla': tallaSelect,
      'color': colorSelect,
      'producto': prodSelected!.id,
      'cantidad': counter.toString()
    };
    try {
      await postRequest('carrito', dataRequest);
      return;
    } catch (e) {
      Future.error(e);
    }
  }

  void cleanProdInfo() {
    colorSelect = 'none';
    tallaSelect = 'none';
    arryTallas = [];
    arrayColors = [];
    counter = 0;
    notifyListeners();
  }

  void removeItemList(String id) {
    int index = listProds.indexWhere((Item prod) => prod.id == id);
    listProds.removeAt(index);
    notifyListeners();
  }
}

@immutable
class Item {
  final String id;
  final String titulo;
  final String urlImg;
  final String valor;
  final String refVendedora;
  final String refInterna;
  final String cantidad;
  final List<Talla> tallas;
  final List<ColorD> colores;
  final String idCarritoItem;
  final String costo;
  final String descripcion;
  final List<dynamic> combinaciones;

  Item(
      this.id,
      this.titulo,
      this.urlImg,
      this.valor,
      this.refVendedora,
      this.refInterna,
      this.cantidad,
      this.tallas,
      this.colores,
      this.idCarritoItem,
      this.combinaciones,
      this.costo,
      this.descripcion);
}

class ColorD {
  final String titulo;
  final String id;
  final String primario;
  final String segundario;
  bool active;

  set activeSet(bool value) {
    this.active = value;
  }

  ColorD(this.primario, this.segundario, this.titulo, this.id, this.active);
}

class ItemCheck {
  final String titulo;
  final String id;
  bool active;

  ItemCheck(this.titulo, this.id, this.active);

  set activeSet(bool value) {
    this.active = value;
  }
}

@immutable
class Talla {
  final String titulo;
  final String id;

  Talla(this.titulo, this.id);
}

Future removeProdCarrito(Item prod, String carritoId) async {
  Map<String, String> data = {
    'idCarrito': carritoId,
    'iditem': prod.idCarritoItem,
    'idProducto': prod.id,
    'cantidad': prod.cantidad
  };
  Map<String, dynamic> request = {};
  try {
    request = await putRequest('carrito', data);
    if (request['err'] != null) throw 'Error de datos contacte a soporte.';
    return;
  } catch (e) {
    return Future.error(e.toString());
  }
}

Future removeProdCatalogo(Item prod) async {
  Map<String, dynamic> request = {};
  try {
    request = await deleteRequest('producto', {'prod_id': prod.id});
    if (request['err'] != null) throw 'Error de datos contacte a soporte.';
    print(request);
    return;
  } catch (e) {
    return Future.error(e.toString());
  }
}
