import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  final Function callBack;
  QrScanner({Key? key, required this.callBack}) : super(key: key);

  @override
  _QrScanner createState() => _QrScanner(this.callBack);
}

class _QrScanner extends State<QrScanner> {
  final Function _callBack;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  int cont = 0;

  _QrScanner(this._callBack);

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Expanded(
        flex: 5,
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          //overlayMargin: EdgeInsets.all(30),
          overlay: QrScannerOverlayShape(borderLength: 100),
        ),
      ),
      Row(
        children: [
          Expanded(
              flex: 5,
              child: Center(
                  child: IconButton(
                      icon: Icon(CupertinoIcons.lightbulb),
                      onPressed: () async => await controller!.toggleFlash()))),
          Expanded(
              flex: 5,
              child: Center(
                  child: IconButton(
                      icon: Icon(CupertinoIcons.arrow_2_circlepath),
                      onPressed: () async => await controller!.flipCamera()))),
        ],
      )
    ]));
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    Stream suscription = controller.scannedDataStream;

    suscription.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      await controller.stopCamera();
      _callBack(scanData.code);
    });
  }
  //_callBack(data.code);

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
