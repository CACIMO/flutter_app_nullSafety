import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/productos_model.dart';

class CarritoModel extends ChangeNotifier {
  List<Item> carritoList = [];
  String carritoId = '';

  Future getCarrito(BuildContext context, String cc) async {
    Map response = {};
    try {
      carritoList = [];
      response = await getRequest(
        'carrito/$cc',
      );
      if (response['data'].length > 0) {
        Map<String, dynamic> carritoInfo = response['data'][0];
        carritoId = carritoInfo['_id'];
        List carrito = carritoInfo['producto'];
        List productos = carritoInfo['Productos'];
        List colorList = carritoInfo['Colores'];
        List tallaList = carritoInfo['Tallas'];
        carrito.forEach((prod) {
          Map<String, dynamic> itemInfo = productos
              .where((carEle) => carEle['_id'] == prod['id'])
              .toList()[0];
          Map<String, dynamic> colorInfo = colorList
              .where((colorEle) => colorEle['_id'] == prod['color'])
              .toList()[0];
          Map<String, dynamic> tallaInfo = tallaList
              .where((tallaEle) => tallaEle['_id'] == prod['talla'])
              .toList()[0];
          Map<String, dynamic> combiInfo = itemInfo['combinacion']
              .where((combiImg) => combiImg['_id'] == prod['combinacion'])
              .toList()[0];
          List auxCombix = [];
          auxCombix.add(combiInfo);
          ColorD colorData = new ColorD(
              colorInfo['primario'],
              colorInfo['segundario'] ?? '',
              colorInfo['titulo'],
              colorInfo['_id'],
              false);

          Talla tallaData = new Talla(tallaInfo['titulo'], tallaInfo['_id']);
          print(combiInfo);
          addCarrito(new Item(
            itemInfo['_id'],
            itemInfo['titulo'],
            'http://$urlDB/getimg/preview/${combiInfo['img']}',
            prod['valor'].toString(),
            '',
            '',
            prod['cantidad'].toString(),
            [tallaData],
            [colorData],
            prod['_id'],
            auxCombix,
            '',
            '',
          ));
        });
      }
      return;
    } catch (e) {
      return Future.error(e);
    }
  }

  void addCarrito(Item item) {
    carritoList.add(item);
    notifyListeners();
  }
}
