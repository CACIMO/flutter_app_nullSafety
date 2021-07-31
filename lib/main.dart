import 'package:flutter_app/model/carrito_model.dart';
import 'package:flutter_app/model/drawer_fil_model.dart';
import 'package:flutter_app/model/editar_model.dart';
import 'package:flutter_app/model/nuevo_prod_model.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:flutter_app/view/carrito_view.dart';
import 'package:flutter_app/view/catalogo_view.dart';
import 'package:flutter_app/model/menu_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/view/editar_prod_view.dart';
import 'package:flutter_app/view/home_view.dart';
import 'package:flutter_app/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/view/nuevo_prod_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserModel()),
    ChangeNotifierProvider(create: (context) => MenuController()),
    ChangeNotifierProvider(create: (context) => ProductosModel()),
    ChangeNotifierProvider(create: (context) => DrawerFilterModel()),
    ChangeNotifierProvider(create: (context) => CarritoModel()),
    ChangeNotifierProvider(create: (context) => NuevoProdModel()),
    ChangeNotifierProvider(create: (context) => EditarModel())
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
          '/carrito': (context) => Carrito(),
          '/nueprod': (context) => NuevoProducto(),
          '/editprod': (context) => EditarProducto()
        },
        theme: ThemeData(
          fontFamily: 'Roboto-Regular',
          primarySwatch: Colors.blue,
        ));
  }
}
