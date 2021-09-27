import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:image_picker/image_picker.dart';

class ModificarProdModel extends ChangeNotifier {
  String colorSelect = 'none';
  String tallaSelect = 'none';
  bool newCombi = false;
  bool imgSelec = false;
  File imgFile = File('');
  String producto = '';
  bool isEdit = true;
  TextEditingController stock = new TextEditingController();
  TextEditingController stockAux = new TextEditingController();
  List combiList = [];
  Map<String, TextEditingController> controllers = {
    'titulo': TextEditingController(),
    'valor': TextEditingController(),
    'costo': TextEditingController(),
    'nombre': TextEditingController(),
    'descripcion': TextEditingController(),
    'rfInt': TextEditingController(),
    'rfVend': TextEditingController()
  };

  void changeTalla(idTalla) {
    tallaSelect = idTalla;
    notifyListeners();
  }

  void setFile(XFile? img) {
    imgFile = File(img!.path);
    if (imgFile.path != '') imgSelec = true;
    notifyListeners();
  }

  void changeColor(idColor) {
    colorSelect = idColor;
    notifyListeners();
  }

  void cleanModal() {
    resetVars();
    imgFile = File('');
    stock = new TextEditingController();
    notifyListeners();
  }

  void resetVars() {
    colorSelect = 'none';
    tallaSelect = 'none';
  }

  void clear() {
    newCombi = false;
    imgSelec = false;
    stock = new TextEditingController();
    combiList = [];
    resetVars();
  }

  void removeLast() {
    newCombi = false;
    imgSelec = false;
    imgFile = File('');
    stock = stock = new TextEditingController();
    resetVars();
    notifyListeners();
  }

  void addNewCombi() {
    removeLast();
    newCombi = true;
    notifyListeners();
  }

  Future saveCombi() async {
    Map<String, String> dataToSave = {
      'idProd': producto,
      'talla': tallaSelect,
      'color': colorSelect,
      'stock': stock.text
    };
    if (tallaSelect == 'none' ||
        colorSelect == 'none' ||
        imgFile.path == '' ||
        stock.text == '')
      return Future.error('');
    else {
      newCombi = false;
      imgSelec = false;
      try {
        await postFileRequest(
            'updateproducto/combi', dataToSave, [File(imgFile.path)]);
        notifyListeners();
        return;
      } catch (e) {
        return Future.error(e);
      }
    }
  }

  void removeCombiByIndex(int index) {
    combiList.removeAt(index);
    notifyListeners();
  }

  void saveNewProd(Map<String, String> data) {
    data['combinaciones'] = jsonEncode(combiList);
  }

  void cleanCamps() {
    combiList = [];
    controllers.keys.forEach((key) {
      controllers[key]!.text = '';
    });
    notifyListeners();
  }

  Future<dynamic> saveProd(Map<String, String> data) async {
    try {
      await putRequest('updateproducto', data);
    } catch (e) {
      return Future.error(e);
    }
  }

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
      combiList = prod['combinacion'];
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

  Future removePostCombi(String idCombi) async {
    try {
      await postRequest('updateproducto/combi', {
        'idCombi': '$idCombi',
        'idProd': '$producto',
      });
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

  void resetView() {
    combiList = [];
    //controllers.keys.forEach((key) => controllers[key]!.text = '');
    colorSelect = 'none';
    tallaSelect = 'none';
    newCombi = false;
    imgSelec = false;
    imgFile = File('');
    producto = '';
    stock = new TextEditingController();
    //notifyListeners();
  }

  void resetView2() {
    combiList = [];
    controllers.keys.forEach((key) => controllers[key]!.text = '');
    colorSelect = 'none';
    tallaSelect = 'none';
    newCombi = false;
    imgSelec = false;
    imgFile = File('');
    producto = '';
    stock = new TextEditingController();
    notifyListeners();
  }
}
