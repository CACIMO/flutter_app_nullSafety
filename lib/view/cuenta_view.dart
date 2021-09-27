import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/controller/cuenta_controller.dart';
import 'package:flutter_app/model/cuenta_model.dart';
import 'package:provider/provider.dart';

class Cuenta extends StatefulWidget {
  @override
  _Cuenta createState() => new _Cuenta();
}

class _Cuenta extends State<Cuenta> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthApp = MediaQuery.of(context).size.width;
    double heightApp = MediaQuery.of(context).size.height;
    Map<String, TextEditingController> controllers =
        Provider.of<CuentaModel>(context).controllers;
    return Scaffold(
        body: SingleChildScrollView(
            padding:
                EdgeInsets.only(left: widthApp * .12, right: widthApp * .12),
            child: Column(children: [
              Container(
                  margin: EdgeInsets.only(top: heightApp * .03),
                  child: Image.asset('images/logo.png')),
              Container(
                  child: TextFormField(
                      maxLength: 30,
                      controller: controllers['usuario'],
                      autofocus: false,
                      decoration: InputDecoration(
                          counterText: "",
                          labelText: 'Usuario',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFEBEBEB), width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFEBEBEB), width: 1)),
                          hintText: 'Usuario',
                          hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                          fillColor: Color(0xFFEBEBEB)))),
              Container(
                margin: EdgeInsets.only(top: heightApp * .015),
                child: TextFormField(
                  maxLength: 40,
                  controller: controllers['nombre'],
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    counterText: "",
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    hintText: 'Nombres',
                    hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    fillColor: Color(0xFFEBEBEB),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: heightApp * .015),
                child: TextFormField(
                  maxLength: 40,
                  controller: controllers['apellido'],
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Apellido',
                    counterText: "",
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    hintText: 'Apellidos',
                    hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    fillColor: Color(0xFFEBEBEB),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: heightApp * .015),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controllers['cedula'],
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Documento',
                    counterText: "",
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    hintText: 'Documento',
                    hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    fillColor: Color(0xFFEBEBEB),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: heightApp * .015),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: controllers['telefono'],
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Telefono',
                    counterText: "",
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    hintText: 'Telefono',
                    hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    fillColor: Color(0xFFEBEBEB),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: heightApp * .015),
                child: TextFormField(
                  maxLength: 100,
                  controller: controllers['correo'],
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    counterText: "",
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    hintText: 'Correo',
                    hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    fillColor: Color(0xFFEBEBEB),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: heightApp * .015),
                child: TextFormField(
                  obscureText: true,
                  maxLength: 100,
                  autofocus: false,
                  controller: controllers['password'],
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    counterText: "",
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFEBEBEB), width: 1)),
                    hintText: 'Contraseña',
                    hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    fillColor: Color(0xFFEBEBEB),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: heightApp * .015, bottom: heightApp * .05),
                  child: Row(children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () => createCuenta(context),
                            child: Container(
                                height: 52,
                                child: Center(
                                    child: Text('Crear cuenta',
                                        style: TextStyle(fontSize: 15))))))
                  ]))
            ])));
  }
}
