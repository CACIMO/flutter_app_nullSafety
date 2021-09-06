import 'package:flutter/material.dart';
import 'package:flutter_app/model/drawer_fil_model.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:provider/provider.dart';

void btnFilterColor(BuildContext context) {
  Provider.of<DrawerFilterModel>(context, listen: false).changeColorFilter();
}

void btnFilterTalla(BuildContext context) {
  Provider.of<DrawerFilterModel>(context, listen: false).changeTallaFilter();
}

void btnFilterTag(BuildContext context) {
  Provider.of<DrawerFilterModel>(context, listen: false).changeTagFilter();
}

void btnFilterCategory(BuildContext context) {
  Provider.of<DrawerFilterModel>(context, listen: false).changeCategoryFilter();
}

void changeValueCheck(
    BuildContext context, String id, bool value, bool isColor, String type) {
  isColor
      ? Provider.of<DrawerFilterModel>(context, listen: false)
          .changeColorCheck(id, value)
      : Provider.of<DrawerFilterModel>(context, listen: false)
          .changeOtherCheck(id, value, type);

  if (value)
    Provider.of<DrawerFilterModel>(context, listen: false)
        .addItemToarry(type, id);
  else
    Provider.of<DrawerFilterModel>(context, listen: false)
        .removeItemToarry(type, id);
  findWhenChangeFilter(context);
}

void findWhenChangeFilter(BuildContext context) {
  Provider.of<ProductosModel>(context, listen: false).getList(context, true);
}
