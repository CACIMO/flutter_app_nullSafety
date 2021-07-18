import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';

class ProductosModel extends ChangeNotifier {
  List<Item> listProds = [];
  int init = 0;
  int last = 0;
  Future getList() async {
    Map response = {};
    try {
      response = await postRequest('producto',
          {'prod_id': 'null', 'init': '0', 'last': '0', 'nombre': ''});
      List prods = response['data'];
      prods.forEach((prod) {
        List<ColorD> colorData = [];
        List<Talla> tallaData = [];
        List colorsTemp = prod['colorData'];
        print(colorsTemp);
        List tallasTemp = prod['tallaData'];
        colorsTemp.forEach((cl) {
          colorData.add(new ColorD(
              cl['primario'], cl['segundario'] ?? '', cl['titulo'], cl['_id']));
        });
        tallasTemp.forEach((tl) {
          tallaData.add(new Talla(tl['titulo'], tl['_id']));
        });
        addProd(new Item(
            prod['_id'],
            prod['titulo'],
            'http://$urlDB/getimg/${prod['_id']}',
            prod['valor'].toString(),
            prod['refVendedora'],
            prod['refInterna'],
            prod['stock'].toString(),
            tallaData,
            colorData));
      });
      return;
    } catch (e) {
      return Future.error(e);
    }
  }

  void addProd(Item item) {
    listProds.add(item);
    notifyListeners();
  }

  void removeProd() {}
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

  Item(this.id, this.titulo, this.urlImg, this.valor, this.refVendedora,
      this.refInterna, this.cantidad, this.tallas, this.colores);
}

@immutable
class ColorD {
  final String titulo;
  final String id;
  final String primario;
  final String segundario;

  ColorD(this.primario, this.segundario, this.titulo, this.id);
}

@immutable
class Talla {
  final String titulo;
  final String id;

  Talla(this.titulo, this.id);
}
