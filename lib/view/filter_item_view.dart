import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/drawer_fil_controller.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/drawer_fil_model.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:flutter_app/view/item_view.dart';
import 'package:provider/provider.dart';

class FilterItem extends StatelessWidget {
  final String titulo;
  final Function onPress;
  const FilterItem({Key? key, required this.onPress, required this.titulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool shower = false;
    List<ColorD> auxColorList = [];
    List<Widget> wigetList = [];
    bool colorShow = Provider.of<DrawerFilterModel>(context).colorFilter;
    bool tallaShow = Provider.of<DrawerFilterModel>(context).tallaFilter;
    bool tagShow = Provider.of<DrawerFilterModel>(context).tagFilter;
    bool categShow = Provider.of<DrawerFilterModel>(context).categFilter;

    if (titulo == 'Categoria') {
      shower = categShow;
      List<ItemCheck> auxCat =
          Provider.of<DrawerFilterModel>(context).categoriaList;
      wigetList = auxCat.map((catInfo) {
        return CheckItem(isColor: false, textInfo: catInfo, type: titulo);
      }).toList();
    } else if (titulo == 'Color') {
      shower = colorShow;
      auxColorList = Provider.of<DrawerFilterModel>(context).colorList;
      wigetList = auxColorList.map((colorInfo) {
        return CheckItem(isColor: true, colorData: colorInfo, type: titulo);
      }).toList();
    } else if (titulo == 'Talla') {
      shower = tallaShow;
      List<ItemCheck> auxTalla =
          Provider.of<DrawerFilterModel>(context).tallaList;
      wigetList = auxTalla.map((tallaInfo) {
        return CheckItem(isColor: false, textInfo: tallaInfo, type: titulo);
      }).toList();
    } else if (titulo == 'Tag') {
      shower = tagShow;
      List<ItemCheck> auxTag = Provider.of<DrawerFilterModel>(context).tagList;
      wigetList = auxTag.map((tagInfo) {
        return CheckItem(isColor: false, textInfo: tagInfo, type: titulo);
      }).toList();
    }
    return Column(children: [
      Row(children: [
        Container(
            width: mQ(context, 'w', .75),
            alignment: Alignment.center,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: mQ(context, 'h', .06),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                      flex: 8,
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(titulo,
                            style: TextStyle(
                                fontFamily: 'Roboto-Light',
                                fontSize: mQ(context, 'w', .05))),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                          alignment: Alignment.center,
                          child: IconButton(
                              onPressed: () => onPress(),
                              icon: Icon(
                                  shower
                                      ? CupertinoIcons.arrowtriangle_up_circle
                                      : CupertinoIcons
                                          .arrowtriangle_down_circle,
                                  size: 20))))
                ]),
              ),
              Visibility(visible: !shower, child: Divider()),
              Visibility(
                visible: shower,
                child: Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Column(
                      children: wigetList,
                    )),
              )
            ]))
      ])
    ]);
  }
}

class CheckItem extends StatelessWidget {
  final bool isColor;
  final String type;
  final ColorD? colorData;
  final ItemCheck? textInfo;
  const CheckItem(
      {Key? key,
      required this.isColor,
      this.colorData,
      this.textInfo,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(
          value: isColor ? (colorData!.active) : textInfo!.active,
          onChanged: (val) {
            changeValueCheck(context, isColor ? colorData!.id : textInfo!.id,
                val!, isColor, type);
          }),
      if (isColor)
        Container(
          padding: EdgeInsets.only(right: 5),
          child: ColorItem(
              primario: colorData!.primario, segundario: colorData!.segundario),
        ),
      Text(isColor ? colorData!.titulo : textInfo!.titulo,
          style: TextStyle(
              fontFamily: 'Roboto-Light', fontSize: mQ(context, 'w', .05)))
    ]);
  }
}
