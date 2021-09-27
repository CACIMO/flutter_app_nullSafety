import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends ChangeNotifier {
  late User user;
  Future loginUser(Map<String, String> userData) async {
    Map response = {};
    try {
      response = await postRequest('login', userData);
      String token = response['data']['token'];
      Map<String, dynamic> userInfo = response['data']['usuario'][0];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      prefs.setString('user', userData['usuario']!);
      prefs.setString('pass', userData['password']!);

      user = new User(
          userInfo['_id'],
          userInfo['Permiso'],
          userInfo['usuario'],
          userInfo['cedula'].toString(),
          userInfo['nombre'],
          userInfo['apellido'],
          userInfo['correo'],
          int.parse(userInfo['telefono']),
          token);
      notifyListeners();
      return;
    } catch (error) {
      return Future.error(error);
    }
  }
}

@immutable
class User {
  final String id;
  final String permiso;
  final String usuario;
  final String cedula;
  final String nombre;
  final String apellido;
  final String correo;
  final int telefono;
  final String token;

  User(this.id, this.permiso, this.usuario, this.cedula, this.nombre,
      this.apellido, this.correo, this.telefono, this.token);
}
