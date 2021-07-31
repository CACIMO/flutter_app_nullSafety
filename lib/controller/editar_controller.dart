import 'package:flutter/material.dart';
import 'package:flutter_app/model/editar_model.dart';
import 'package:provider/provider.dart';

getProducto(BuildContext context) {
  Provider.of<EditarModel>(context, listen: false)
      .getProductInfo()
      .then((value) {
    print('acabo');
  });
}
