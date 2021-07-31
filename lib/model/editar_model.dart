import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/productos_model.dart';

class EditarModel extends ChangeNotifier {
  String producto = '';
  List combinaciones = [];
  bool newCombi = false;
  bool imgSelec = false;
  File imgFile = File('');
  Map<String, TextEditingController> controllers = {
    'titulo': TextEditingController(),
    'valor': TextEditingController(),
    'costo': TextEditingController(),
    'nombre': TextEditingController(),
    'descripcion': TextEditingController(),
    'rfInt': TextEditingController(),
    'rfVend': TextEditingController()
  };

  Future getProductInfo() async {
    Map response = {};
    try {
      response = await postRequest('producto', {
        'prod_id': '$producto',
        'init': '0',
        'last': '1',
        'busqueda': '',
        'col': jsonEncode([]),
        'cat': jsonEncode([]),
        'tag': jsonEncode([]),
        'tal': jsonEncode([])
      });

      List prods = response['data'];
      var prod = prods[0];
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
      combinaciones = prod['combinacion'];
      setDataView(Item(
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
      return;
    } catch (e) {
      return Future.error(e);
    }
  }

  void setDataView(Item producto) {
    controllers['titulo']!.text = producto.titulo;
    controllers['valor']!.text = producto.valor;
    controllers['costo']!.text = producto.costo;
    controllers['descripcion']!.text = producto.descripcion;
    controllers['rfInt']!.text = producto.refInterna;
    controllers['rfVend']!.text = producto.refVendedora;
    notifyListeners();
  }
}
