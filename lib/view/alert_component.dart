import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/controller/modificar_prod_controller.dart';
import 'package:flutter_app/controller/nuevo_prod_controller.dart';
import 'package:flutter_app/model/drawer_fil_model.dart';
import 'package:flutter_app/model/modificar_prod_model.dart';
import 'package:flutter_app/model/nuevo_prod_model.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:flutter_app/view/dropdown_view.dart';
import 'package:provider/provider.dart';

class AlertComponent extends StatelessWidget {
  final String type;
  final String msg;
  const AlertComponent({Key? key, required this.type, required this.msg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Icon> iconos = {
      'e': Icon(CupertinoIcons.multiply_circle,
          color: Colors.red.withOpacity(.75)),
      'w': Icon(CupertinoIcons.multiply_circle,
          color: Colors.yellow.withOpacity(.75)),
      's': Icon(CupertinoIcons.check_mark_circled,
          color: Colors.green.withOpacity(.75))
    };
    return Container(
        child: Column(children: [
      Row(children: [
        Expanded(flex: 2, child: iconos[type]!),
        Expanded(
            flex: 8,
            child: Text(this.msg,
                style: TextStyle(
                    fontFamily: 'Roboto-Light',
                    fontSize: mQ(context, 'h', .022))))
      ])
    ]));
  }
}

class StockAlert extends StatelessWidget {
  final dynamic data;
  final Function funcion;
  const StockAlert({Key? key, this.data, required this.funcion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ModificarProdModel>(context).stockAux.text =
        data['stock'].toString();
    return Container(
        child: Column(children: [
      Row(children: [
        Expanded(
            child: Container(
                margin: EdgeInsets.only(bottom: mQ(context, 'h', .012)),
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    controller:
                        Provider.of<ModificarProdModel>(context).stockAux,
                    maxLength: 7,
                    decoration: InputDecoration(
                        counterText: '',
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                        hintText: 'Stock',
                        labelText: 'Stock',
                        hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                        fillColor: Color(0xFFEBEBEB)))))
      ]),
      ElevatedButton(
        onPressed: () {
          saveStock(
                  context,
                  data['_id'],
                  Provider.of<ModificarProdModel>(context, listen: false)
                      .stockAux
                      .text)
              .then((value) => funcion());
        },
        child: Container(
          height: 52,
          child: Center(
              child: Text(
            'Guardar',
            style: TextStyle(fontSize: 15),
          )),
        ),
      )
    ]));
  }
}

class AlertCombi extends StatelessWidget {
  final bool edit;
  const AlertCombi({Key? key, required this.edit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic prov = edit
        ? Provider.of<ModificarProdModel>(context)
        : Provider.of<NuevoProdModel>(context);
    bool isEdit = prov.isEdit;
    return Container(
      height: 450,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              child: Container(
                  child: Column(children: [
                Center(
                  child: Container(
                      height: 200,
                      width: 200,
                      child: (prov.imgFile.path == '')
                          ? IconButton(
                              onPressed: () => isEdit
                                  ? addImgNewMod(context, false, {})
                                  : addImgNew(context),
                              icon: Icon(CupertinoIcons.add_circled),
                            )
                          : Image.file(prov.imgFile)),
                ),
                Center(
                  child: DropDownColor(
                      onChange: (String? idColor) => isEdit
                          ? changeColorProMod(context, idColor.toString())
                          : changeColorPro(context, idColor.toString()),
                      idSelec: prov.colorSelect,
                      list: Provider.of<DrawerFilterModel>(context).colorList),
                ),
                Center(
                  child: DropDownTalla(
                      onChange: (String? idTalla) => isEdit
                          ? changeTallaProdMod(context, idTalla.toString())
                          : changeTallaProd(context, idTalla.toString()),
                      idSelec: prov.tallaSelect,
                      list: Provider.of<DrawerFilterModel>(context)
                          .tallaList
                          .map((e) => Talla(e.titulo, e.id))
                          .toList()),
                ),
                Container(
                    width: mQ(context, 'w', .4),
                    child: TextFormField(
                        controller: prov.stock,
                        textAlign: TextAlign.center,
                        maxLength: 3,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            counterText: "",
                            hintText: 'Stock',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFEBEBEB), width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFEBEBEB), width: 1)),
                            hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                            fillColor: Color(0xFFEBEBEB)))),
                ElevatedButton(
                    onPressed: () {
                      isEdit
                          ? addCombiToArrayMod(context)
                          : addCombiToArray(context);
                    },
                    child: Container(
                        child: Text('Agregar',
                            style: TextStyle(
                                fontFamily: 'Roboto-Light',
                                fontSize: mQ(context, 'w', .05)))))
              ]))),
        ],
      ),
    );
  }
}

class NewAlert extends StatelessWidget {
  final String type;
  final Function funcion;
  const NewAlert({Key? key, required this.type, required this.funcion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController itemAux = new TextEditingController();
    return Container(
        child: Column(children: [
      Row(children: [
        Expanded(
            child: Container(
                margin: EdgeInsets.only(bottom: mQ(context, 'h', .012)),
                child: TextFormField(
                    autofocus: false,
                    controller: itemAux,
                    decoration: InputDecoration(
                        counterText: '',
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                        hintText: '$type',
                        labelText: '$type',
                        hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                        fillColor: Color(0xFFEBEBEB)))))
      ]),
      ElevatedButton(
        onPressed: () => funcion(itemAux.text),
        child: Container(
          height: 52,
          child: Center(
              child: Text(
            'Guardar',
            style: TextStyle(fontSize: 15),
          )),
        ),
      )
    ]));
  }
}

class NewColorAlert extends StatelessWidget {
  final String type;
  final Function funcion;
  const NewColorAlert({Key? key, required this.type, required this.funcion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController primario = new TextEditingController();
    TextEditingController segundario = new TextEditingController();
    TextEditingController titulo = new TextEditingController();
    return Container(
        child: Column(children: [
      Row(children: [
        Expanded(
            child: Container(
                margin: EdgeInsets.only(bottom: mQ(context, 'h', .012)),
                child: TextFormField(
                    autofocus: false,
                    controller: titulo,
                    decoration: InputDecoration(
                        counterText: '',
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                        hintText: 'Nombre $type',
                        labelText: 'Nombre $type',
                        hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                        fillColor: Color(0xFFEBEBEB)))))
      ]),
      Row(children: [
        Expanded(
            child: Container(
                margin: EdgeInsets.only(bottom: mQ(context, 'h', .012)),
                child: TextFormField(
                    autofocus: false,
                    controller: primario,
                    decoration: InputDecoration(
                        counterText: '',
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                        hintText: 'Color Primario',
                        labelText: 'Color Primario',
                        hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                        fillColor: Color(0xFFEBEBEB)))))
      ]),
      Row(children: [
        Expanded(
            child: Container(
                margin: EdgeInsets.only(bottom: mQ(context, 'h', .012)),
                child: TextFormField(
                    autofocus: false,
                    controller: segundario,
                    decoration: InputDecoration(
                        counterText: '',
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                        hintText: 'Color Segundario',
                        labelText: 'Color Segundario',
                        hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                        fillColor: Color(0xFFEBEBEB)))))
      ]),
      ElevatedButton(
          onPressed: () => funcion(titulo.text, primario.text, segundario.text),
          child: Container(
              height: 52,
              child: Center(
                  child: Text('Guardar', style: TextStyle(fontSize: 15)))))
    ]));
  }
}
