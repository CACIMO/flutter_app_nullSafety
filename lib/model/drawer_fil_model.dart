import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/productos_model.dart';

class DrawerFilterModel extends ChangeNotifier {
  bool colorFilter = false;
  bool tallaFilter = false;
  bool tagFilter = false;
  bool categFilter = false;
  List<String> colorsIds = [];
  List<String> tallasIds = [];
  List<String> categoriasIds = [];
  List<String> tagsIds = [];

  List<ColorD> colorList = [];
  List<ItemCheck> tallaList = [];
  List<ItemCheck> categoriaList = [];
  List<ItemCheck> tagList = [];

  void changeColorFilter() {
    colorFilter = !colorFilter;
    notifyListeners();
  }

  void changeTallaFilter() {
    tallaFilter = !tallaFilter;
    notifyListeners();
  }

  void changeTagFilter() {
    tagFilter = !tagFilter;
    notifyListeners();
  }

  void changeCategoryFilter() {
    categFilter = !categFilter;
    notifyListeners();
  }

  void getColorFilter() async {
    var response;

    try {
      colorList = [];
      response = await getRequest('color');
      List auxList = response['data'];
      if (auxList.length > 0) {
        auxList.forEach((color) {
          ColorD auxColor = ColorD(color['primario'], color['segundario'],
              color['titulo'], color['_id'], false);
          colorList.add(auxColor);
        });
      }
      notifyListeners();
    } catch (error) {}
  }

  void getTallaFilter() async {
    var response;

    try {
      tallaList = [];
      response = await getRequest('talla');
      List auxTalla = response['data'];
      if (auxTalla.length > 0) {
        auxTalla.forEach((talla) {
          tallaList.add(ItemCheck(talla['titulo'], talla['_id'], false));
        });
      }
      notifyListeners();
    } catch (error) {}
  }

  void getCategoryFilter() async {
    var response;

    try {
      categoriaList = [];
      response = await getRequest('categoria');
      List auxCat = response['data'];
      if (auxCat.length > 0) {
        auxCat.forEach((cat) {
          categoriaList.add(ItemCheck(cat['titulo'], cat['_id'], false));
        });
      }
      notifyListeners();
    } catch (error) {}
  }

  void getTagFilter() async {
    var response;

    try {
      tagList = [];
      response = await getRequest('tag');
      List auxTag = response['data'];
      if (auxTag.length > 0) {
        auxTag.forEach((tag) {
          tagList.add(ItemCheck(tag['titulo'], tag['_id'], false));
        });
      }
      notifyListeners();
    } catch (error) {}
  }

  void addItemToarry(String type, String id) {
    if (type == 'Color')
      colorsIds.add(id);
    else if (type == 'Talla')
      tallasIds.add(id);
    else if (type == 'Tag')
      tagsIds.add(id);
    else if (type == 'Categoria') categoriasIds.add(id);
    notifyListeners();
  }

  void removeItemToarry(String type, String id) {
    if (type == 'Color') {
      int index = colorsIds.indexOf(id);
      colorsIds.removeAt(index);
    } else if (type == 'Talla') {
      int index = tallasIds.indexOf(id);
      tallasIds.removeAt(index);
    } else if (type == 'Tag') {
      int index = tagsIds.indexOf(id);
      tagsIds.removeAt(index);
    } else if (type == 'Categoria') {
      int index = categoriasIds.indexOf(id);
      categoriasIds.removeAt(index);
    }
    notifyListeners();
  }

  void changeColorCheck(String colorId, bool value) {
    int index = colorList.indexWhere((ColorD color) => color.id == colorId);
    colorList[index].activeSet = value;
    notifyListeners();
  }

  void changeOtherCheck(String tallaId, bool value, type) {
    if (type == 'Talla') {
      int index = tallaList.indexWhere((ItemCheck item) => item.id == tallaId);
      tallaList[index].activeSet = value;
    } else if (type == 'Categoria') {
      int index =
          categoriaList.indexWhere((ItemCheck item) => item.id == tallaId);
      categoriaList[index].activeSet = value;
    } else if (type == 'Tag') {
      int index = tagList.indexWhere((ItemCheck item) => item.id == tallaId);
      tagList[index].activeSet = value;
    }
    notifyListeners();
  }
}
