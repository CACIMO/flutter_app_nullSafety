import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/modificar_prod_model.dart';
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
