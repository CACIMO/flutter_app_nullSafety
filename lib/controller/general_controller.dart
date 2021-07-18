import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/view/alert_component.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String urlDB = '3.141.11.180:3000';

double mQ(BuildContext ctx, String type, double factor) {
  Map query = {
    'w': MediaQuery.of(ctx).size.width,
    'h': MediaQuery.of(ctx).size.height,
    'o': MediaQuery.of(ctx).orientation.index,
  };
  return query[type] * factor;
}

Future getRequest(urlRoute) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  var urlData = Uri.http(urlDB, urlRoute);
  var response = await http.get(urlData, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'access-token': token,
    'device-id': 'deviceInfo'
  });
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return Future.error(jsonDecode(response.body));
  }
}

Future postRequest(String urlRoute, Map<String, String>? data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  var urlData = Uri.http(urlDB, urlRoute);
  var response = await http.post(urlData,
      headers: <String, String>{
        'access-token': token,
        'device-id': 'deviceInfo'
      },
      body: data);
  if (response.statusCode == 200)
    return jsonDecode(response.body);
  else
    return Future.error(jsonDecode(response.body));
}

Future putrequest(BuildContext ctx, urlRoute, Map<String, String>? data,
    bool loadDialog) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  var urlData = Uri.http(urlDB, urlRoute);
  var response = await http.put(urlData,
      headers: <String, String>{'access-token': token}, body: data);
  if (loadDialog) Navigator.of(ctx, rootNavigator: true).pop();
  if (response.statusCode == 200)
    return jsonDecode(response.body);
  else
    return Future.error(jsonDecode(response.body));
}

Future<void> alertMessage(
    BuildContext ctx, String type, String titulo, String mensaje) {
  return showDialog<void>(
      context: ctx,
      builder: (BuildContext context) {
        return new AlertDialog(
            title: Text(titulo,
                style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: mQ(context, 'h', .025))),
            content: Container(
                height: mQ(context, 'h', .08),
                child: AlertComponent(msg: mensaje, type: type)));
      });
}

Future<bool> exitApp(context) async {
  /* actionMsg(context, 'Desea cerrar sesion?', () {
    cleanSessions();
    SystemNavigator.pop();
  }); */
  return false;
}
