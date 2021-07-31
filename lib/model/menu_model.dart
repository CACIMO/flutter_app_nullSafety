import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';

class MenuController extends ChangeNotifier {
  Map<String, Map<String, dynamic>> menuOption = {
    '604f9cf5aaa8ce91e788e217': {
      'title': 'Catalogo',
      'icono': Icon(CupertinoIcons.book),
      'route': 'catalogo',
      'active': false
    },
    '604f9cf5aaa8ce91e788e218': {
      'title': 'Carrito',
      'icono': Icon(CupertinoIcons.cart),
      'route': 'carrito',
      'active': false
    },
    '604f9cf5aaa8ce91e788e219': {
      'title': 'Nuevo Producto',
      'icono': Icon(CupertinoIcons.tag),
      'route': 'nueprod',
      'active': false
    },
    '604f9cf5aaa8ce91e788e21a': {
      'title': 'Historial de Ventas',
      'icono': Icon(CupertinoIcons.tickets),
      'route': 'historial',
      'active': false
    },
    '604f9cf5aaa8ce91e788e21d': {
      'title': 'Configuracion',
      'icono': Icon(CupertinoIcons.settings),
      'route': 'configuracion',
      'active': false
    },
    '604f9cf5aaa8ce91e788e21e': {
      'title': 'Cerrar Sesión',
      'icono': Icon(CupertinoIcons.square_arrow_left),
      'route': 'logout',
      'active': true
    }
  };

  Future getMenu() async {
    Map response = {};
    try {
      response = await getRequest('menuTk');
      List menuData = response['data'][0]['MenuData'];
      menuData.forEach((option) {
        menuOption[option['_id']]!['active'] = option['active'];
      });
      notifyListeners();
      return;
    } catch (e) {
      return Future.error(e);
    }
  }
}
