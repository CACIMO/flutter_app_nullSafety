import 'dart:io';

import 'package:flutter/material.dart';

class CombiModel extends ChangeNotifier {}

class CombiItem {
  final String id;
  String color;
  String talla;
  int stock;
  File _img = File('');

  File get imgGet => _img;

  set imgSet(File img) {
    _img = img;
  }

  int setStock(int val) => stock = val;
  String setColor(String col) => color = col;
  String setTalla(String tall) => talla = tall;

  CombiItem(this.id, this.color, this.talla, this.stock);
}
