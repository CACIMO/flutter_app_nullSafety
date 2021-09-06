import 'package:flutter/material.dart';
import 'package:flutter_app/controller/general_controller.dart';
import 'package:flutter_app/model/datos_cliente_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:provider/provider.dart';

void changeFPago(BuildContext context, String value) {
  Provider.of<FormatoModel>(context, listen: false).changeFPago(value);
}

Future<void> saveData(BuildContext context) async {
  bool flag = false;
  Map<String, String> data = {};
  Provider.of<FormatoModel>(context, listen: false)
      .controllers
      .keys
      .forEach((key) {
    TextEditingController controller =
        Provider.of<FormatoModel>(context, listen: false).controllers[key]!;
    if (controller.text == '') {
      flag = true;
      return;
    } else {
      data.addAll({key: controller.text});
      data.addAll(
          {'vendedor': Provider.of<UserModel>(context, listen: false).user.id});
      data.addAll(
          {'pago': Provider.of<FormatoModel>(context, listen: false).idSelect});
    }
  });

  if (flag)
    alertMessage(context, 'w', 'Alerta', 'Por favor llene todos los campos.');
  else {
    alertLoad(context);
    Map<String, dynamic> response = {};
    try {
      response = await postRequest('formato', data);
      Navigator.pop(context);
      alertMessage(context, 's', 'Proceso Exitoso',
              'Formato nuevo ${response['data']['msg']}')
          .then((value) => clearData(context));

      return;
    } catch (e) {
      Navigator.pop(context);
      return Future.error(e);
    }
  }
}

void clearData(BuildContext context) {
  Provider.of<FormatoModel>(context, listen: false).clearData();
}
