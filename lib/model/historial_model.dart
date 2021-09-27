import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:image_picker/image_picker.dart';

class HistorialModel extends ChangeNotifier {
  List<Formato> formatos = [];
  late Formato selected;

  String codeScan = '';

  Future<void> refrescarHistorial() async {
    String formato = selected.formato;
    getRequest('getForm/$formato').then((response) {
      List<HistorialProd> prods = [];
      var formato = response['data'][0];

      formato['Productos'].forEach((producto) {
        String titulo = formato['Prods']
            .singleWhere((e) => e['_id'] == producto['id'])['titulo']
            .toString();
        String talla = formato['Tallas']
            .singleWhere((e) => e['_id'] == producto['talla'])['titulo']
            .toString();
        Map color = formato['Colores']
            .singleWhere((e) => e['_id'] == producto['color']);

        prods.add(new HistorialProd(
            producto['id'],
            titulo,
            double.parse(producto['valor'].toString()),
            int.parse(producto['restante'].toString()),
            int.parse(producto['cantidad'].toString()),
            ColorD(color['primario'], color['segundario'], color['titulo'],
                color['_id'], true),
            talla));
      });

      String etapa = formato['Etapa'].length > 0
          ? formato['Etapa'][0]['titulo']
          : 'Indefinida';

      String fpago = formato['FPago'].length > 0
          ? formato['FPago'][0]['titulo']
          : 'Indefinida';
      String vendedor = formato['Vendedor'].length > 0
          ? '${formato['Vendedor'][0]['nombre']} ${formato['Vendedor'][0]['apellido']}'
          : 'Indefinido';
      selected = (new Formato(
          formato['_id'],
          DateTime.parse(formato['fecha']),
          etapa,
          formato['fac'].toString(),
          double.parse(formato['envio'].toString()),
          formato['formato'],
          formato['documento'].toString(),
          formato['barrio'],
          formato['ciudad'],
          double.parse(formato['total'].toString()),
          formato['direccion'],
          formato['nombre'],
          formato['telefono'].toString(),
          fpago,
          vendedor,
          prods,
          formato['observacion'] ?? ''));
      notifyListeners();
    });
  }

  Future<void> getHistorial(User userInfo, bool acceso) async {
    postRequest(
            'getForm/${acceso ? 'true' : 'false'}', {'vendedor': userInfo.id})
        .then((response) {
      formatos = [];
      List<HistorialProd> prods = [];
      response['data'].forEach((formato) {
        prods = [];

        formato['Productos'].forEach((producto) {
          String titulo = formato['Prods']
              .singleWhere((e) => e['_id'] == producto['id'])['titulo']
              .toString();
          String talla = formato['Tallas']
              .singleWhere((e) => e['_id'] == producto['talla'])['titulo']
              .toString();
          Map color = formato['Colores']
              .singleWhere((e) => e['_id'] == producto['color']);

          prods.add(new HistorialProd(
              producto['id'],
              titulo,
              double.parse(producto['valor'].toString()),
              int.parse(producto['restante'].toString()),
              int.parse(producto['cantidad'].toString()),
              ColorD(color['primario'], color['segundario'], color['titulo'],
                  color['_id'], true),
              talla));
        });

        String etapa = formato['Etapa'].length > 0
            ? formato['Etapa'][0]['titulo']
            : 'Indefinida';

        String fpago = formato['FPago'].length > 0
            ? formato['FPago'][0]['titulo']
            : 'Indefinida';
        String vendedor = formato['Vendedor'].length > 0
            ? '${formato['Vendedor'][0]['nombre']} ${formato['Vendedor'][0]['apellido']}'
            : 'Indefinido';
        formatos.add(new Formato(
          formato['_id'],
          DateTime.parse(formato['fecha']),
          etapa,
          formato['fac'].toString(),
          double.parse(formato['envio'].toString()),
          formato['formato'],
          formato['documento'].toString(),
          formato['barrio'],
          formato['ciudad'],
          double.parse(formato['total'].toString()),
          formato['direccion'],
          formato['nombre'],
          formato['telefono'].toString(),
          fpago,
          vendedor,
          prods,
          formato['observacion'] ?? '',
        ));
      });
      notifyListeners();
    });
  }

  void setFormato(Formato formato) {
    selected = formato;
    notifyListeners();
  }

  Future<void> addFactura(XFile img) async {
    File factuaImg = File(img.path);
    Map<String, String> datax = {
      'id': selected.id,
      'formato': selected.formato,
    };
    try {
      await postFileRequest('formato/img/null', datax, [factuaImg]);
      return;
    } catch (e) {
      return Future.error(e);
    }
  }
}

@immutable
class Formato {
  final String id;
  final String vendedor;
  final DateTime fecha;
  final String etapa;
  final String fac;
  final double envio;
  final String formato;
  final String documento;
  final String barrio;
  final String ciudad;
  final double total;
  final String direccion;
  final String cliente;
  final String telefono;
  final String formaPago;
  final List<HistorialProd> prods;
  final String observacion;

  Formato(
      this.id,
      this.fecha,
      this.etapa,
      this.fac,
      this.envio,
      this.formato,
      this.documento,
      this.barrio,
      this.ciudad,
      this.total,
      this.direccion,
      this.cliente,
      this.telefono,
      this.formaPago,
      this.vendedor,
      this.prods,
      this.observacion);
}

@immutable
class HistorialProd {
  final String id;
  final String titulo;
  final double valor;
  final int restante;
  final int cantidad;
  final ColorD color;
  final String talla;

  HistorialProd(this.id, this.titulo, this.valor, this.restante, this.cantidad,
      this.color, this.talla);
}
