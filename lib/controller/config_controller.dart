import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/config_model.dart';
import 'package:flutter_app/model/productos_model.dart';
import 'package:provider/provider.dart';

void getColor(BuildContext context) {
  Provider.of<ConfigModel>(context, listen: false)
      .getColor()
      .then((value) => null);
}

void getUsers(BuildContext context) {
  Provider.of<ConfigModel>(context, listen: false)
      .getUser()
      .then((value) => null);
}

void createColor(
    BuildContext context, String? prim, String? seg, String? titulo) {
  if (prim != '' && prim != null && titulo != '' && titulo != null) {
    bool flag = true;
    try {
      Color(int.parse('0xFF$prim'));
    } catch (e) {
      flag = !flag;
      alertMessage(context, 'w', 'Error Hexa', 'Color primario invalido.');
    }

    if (flag && seg != null && seg != '')
      try {
        Color(int.parse('0xFF$seg'));
      } catch (e) {
        flag = !flag;
        alertMessage(context, 'w', 'Error Hexa', 'Color Segundario invalido.');
      }
    else
      seg = prim;

    if (flag) {
      Map<String, String> data = {
        'titulo': titulo,
        'active': 'true',
        'primario': prim,
        'segundario': seg
      };
      Provider.of<ConfigModel>(context, listen: false)
          .createItem('color/null', data)
          .then((value) {
        getColor(context);
        Navigator.pop(context);
      }).catchError((onError) {
        alertMessage(context, 'e', 'Alerta!', 'Error al crear nuevo valor.');
      });
    }
  } else {
    alertMessage(context, 'w', 'Atencion!', 'Verifique la informacion.');
  }
}

void updColor(BuildContext context, ColorD item) {
  Map<String, String> data = {
    'titulo': item.titulo,
    'active': (!item.active).toString()
  };

  Provider.of<ConfigModel>(context, listen: false)
      .updateItem('color/null', data)
      .then((value) => getColor(context));
}

void getCat(BuildContext context) {
  Provider.of<ConfigModel>(context, listen: false)
      .getCategoria()
      .then((value) => null);
}

void createCat(BuildContext context, String? name) {
  if (name != '' || name != null) {
    Map<String, String> data = {'titulo': name!, 'active': 'true'};
    Provider.of<ConfigModel>(context, listen: false)
        .createItem('categoria/null', data)
        .then((value) {
      getCat(context);
      Navigator.pop(context);
    }).catchError((onError) {
      alertMessage(context, 'e', 'Alerta!', 'Error al crear nuevo valor.');
    });
  } else {
    alertMessage(context, 'w', 'Atencion!', 'Debe ingresar un valor.');
  }
}

void updCat(BuildContext context, ItemCheck item) {
  Map<String, String> data = {
    'titulo': item.titulo,
    'active': (!item.active).toString()
  };
  Provider.of<ConfigModel>(context, listen: false)
      .updateItem('categoria/null', data)
      .then((value) => getCat(context));
}

void getTalla(BuildContext context) {
  Provider.of<ConfigModel>(context, listen: false)
      .getTalla()
      .then((value) => null);
}

void createTalla(BuildContext context, String? name) {
  if (name != '' || name != null) {
    Map<String, String> data = {'titulo': name!, 'active': 'true'};
    Provider.of<ConfigModel>(context, listen: false)
        .createItem('talla/null', data)
        .then((value) {
      getTalla(context);
      Navigator.pop(context);
    }).catchError((onError) {
      alertMessage(context, 'e', 'Alerta!', 'Error al crear nuevo valor.');
    });
  } else {
    alertMessage(context, 'w', 'Atencion!', 'Debe ingresar un valor.');
  }
}

void updTalla(BuildContext context, ItemCheck item) {
  Map<String, String> data = {
    'titulo': item.titulo,
    'active': (!item.active).toString()
  };
  Provider.of<ConfigModel>(context, listen: false)
      .updateItem('talla/null', data)
      .then((value) => getTalla(context));
}

void getTag(BuildContext context) {
  Provider.of<ConfigModel>(context, listen: false)
      .getTag()
      .then((value) => null);
}

void createTag(BuildContext context, String? name) {
  if (name != '' || name != null) {
    Map<String, String> data = {'titulo': name!, 'active': 'true'};
    Provider.of<ConfigModel>(context, listen: false)
        .createItem('tag/null', data)
        .then((value) {
      getTag(context);
      Navigator.pop(context);
    }).catchError((onError) {
      alertMessage(context, 'e', 'Alerta!', 'Error al crear nuevo valor.');
    });
  } else {
    alertMessage(context, 'w', 'Atencion!', 'Debe ingresar un valor.');
  }
}

void updTag(BuildContext context, ItemCheck item) {
  Map<String, String> data = {
    'titulo': item.titulo,
    'active': (!item.active).toString()
  };
  Provider.of<ConfigModel>(context, listen: false)
      .updateItem('tag/null', data)
      .then((value) => getTag(context));
}

Future<void> saveDataP(
    BuildContext context, String type, String permiso, String id) async {
  Map<String, String> data = {'type': type, 'data': permiso, 'userId': id};
  Provider.of<ConfigModel>(context, listen: false)
      .updateItem('usuario', data)
      .then((value) {
    Navigator.pop(context);
    alertMessage(
        context, 's', 'Proceso Exitoso', 'El permiso se ha actualizado');
  });
}
