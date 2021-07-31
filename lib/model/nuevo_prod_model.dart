import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:image_picker/image_picker.dart';

class NuevoProdModel extends ChangeNotifier {
  String colorSelect = 'none';
  String tallaSelect = 'none';
  bool newCombi = false;
  bool imgSelec = false;
  File imgFile = File('');
  TextEditingController stock = new TextEditingController();
  List<Map<String, dynamic>> combiList = [];
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

  void resetVars() {
    colorSelect = 'none';
    tallaSelect = 'none';
    //notifyListeners();
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
    Map<String, dynamic> dataToSave = {
      'talla': tallaSelect,
      'color': colorSelect,
      'img': imgFile,
      'cantidad': stock.text
    };
    if (tallaSelect == 'none' ||
        colorSelect == 'none' ||
        imgFile.path == '' ||
        stock.text == '')
      return Future.error('');
    else {
      combiList.add(dataToSave);
      newCombi = false;
      imgSelec = false;
      notifyListeners();
      return;
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

  Future<dynamic> saveProd(
      Map<String, String> data, List<File> arrayFiles) async {
    await postFileRequest('producto', data, arrayFiles).then((value) {
      return;
    }).onError((onError, strace) {
      return Future.error('');
    });
  }
}
