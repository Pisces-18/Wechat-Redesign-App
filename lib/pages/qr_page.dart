import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../blocs/qr_bloc.dart';
import 'contacts_page.dart';
import 'home_page.dart';

class QrPage extends StatefulWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

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
    return ChangeNotifierProvider(
      create: (context)=>QrBloc(),
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Consumer<QrBloc>(
              builder: (context,bloc,child)=> Expanded(
                flex: 5,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: (QRViewController controller) {
                    this.controller = controller;
                    controller.scannedDataStream.listen((scanData) {
                      setState(() {
                        result = scanData;
                        bloc.scannedQr(result?.code ?? "").then((value)async{
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactsPage()));
                          //Navigator.pop(context);
                        }).catchError((error){
                          debugPrint("QrScanner Error====>$error");
                        });
                      });
                    });
                  },
                  //overlay: QrScannerOverlayShape(borderColor: Colors.white),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (result != null)
                    ? Text(
                    'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                    : Text('Scan a code'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
