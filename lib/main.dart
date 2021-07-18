import 'package:flutter_app/model/productos_model.dart';
import 'package:flutter_app/view/catalogo_view.dart';
import 'package:flutter_app/model/menu_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/view/home_view.dart';
import 'package:flutter_app/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserModel()),
    ChangeNotifierProvider(create: (context) => MenuController()),
    ChangeNotifierProvider(create: (context) => ProductosModel())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/login',
        routes: {
          '/': (context) => MyHomePage(),
          '/login': (context) => Login(),
          '/catalogo': (context) => Catalogo(),
        },
        theme: ThemeData(
          fontFamily: 'Roboto-Regular',
          primarySwatch: Colors.blue,
        ));
  }
}
