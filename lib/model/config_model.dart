import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/productos_model.dart';

class ConfigModel extends ChangeNotifier {
  List<ColorD> colores = [];
  List<ItemCheck> tallas = [];
  List<ItemCheck> tags = [];
  List<ItemCheck> categorias = [];

  Future<void> getTalla() async {
    try {
      var request = await getRequest('talla/null');
      tallas = [];
      List aux = request['data'];
      tallas = aux
          .map((e) => ItemCheck(e['titulo'], e['_id'], e['active']))
          .toList();
      notifyListeners();
      return request;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> getTag() async {
    try {
      var request = await getRequest('tag/null');
      tags = [];
      List aux = request['data'];
      tags = aux
          .map((e) => ItemCheck(e['titulo'], e['_id'], e['active']))
          .toList();
      notifyListeners();
      return request;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> getCategoria() async {
    try {
      var request = await getRequest('categoria/null');
      categorias = [];
      List aux = request['data'];
      categorias = aux
          .map((e) => ItemCheck(e['titulo'], e['_id'], e['active']))
          .toList();
      notifyListeners();
      return request;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> getColor() async {
    try {
      var request = await getRequest('color/null');
      colores = [];
      List aux = request['data'];
      colores = aux
          .map((e) => ColorD(e['primario'], e['segundario'], e['titulo'],
              e['_id'], e['active']))
          .toList();
      notifyListeners();
      return request;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> updateItem(String type, Map<String, String> data) async {
    try {
      await putRequest('$type', data);
      return;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> createItem(String type, Map<String, String> data) async {
    try {
      await postRequest('$type', data);
      print('El type $type la data ${data}');
      return;
    } catch (e) {
      return Future.error(e);
    }
  }
}
