import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

import 'package:wechat_redesign_app/resources/colors.dart';
import 'package:wechat_redesign_app/resources/dimens.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  String? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(borderColor: Colors.white),
        ),
        Positioned(
          top: 56,
          left: 23,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 109,
          left: 30,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 48),
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 91,
              width: 280,
              decoration: BoxDecoration(
                color: SCANNER_NOTICE_COLOR,
                borderRadius: BorderRadius.circular(MARGIN_MEDIUM_X),
              ),
              child: Column(
                children: [
                  Text(
                    result?? "",
                    style: TextStyle(
                      color: PRIMARY_COLOR_1,
                      fontWeight: FontWeight.w700,
                      fontSize: TEXT_REGULAR_2LX,
                    ),
                  ),
                  const SizedBox(
                    height: MARGIN_SMALLX,
                  ),
                  Text(
                    "Scan the QR code to add your frined in contact.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 0.4,
                      color: PRIMARY_COLOR_1,
                      fontWeight: FontWeight.w400,
                      fontSize: TEXT_REGULAR,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 750,
          left: 30,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 48),
              padding: EdgeInsets.symmetric(
                  vertical: MARGIN_CARD_MEDIUM_2, horizontal: MARGIN_XLARGE),
              decoration: BoxDecoration(
                color: CHAT_DETAIL_APP_BAR_COLOR,
                borderRadius: BorderRadius.circular(
                  MARGIN_SMALLX,
                ),
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/gallery.png"),
                  const SizedBox(
                    width: MARGIN_CARD_MEDIUM_2,
                  ),
                  Text(
                    result?? "",
                    style: TextStyle(
                        color: PRIMARY_COLOR_1,
                        fontSize: TEXT_REGULAR,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  // Column(
  // children: <Widget>[
  // Expanded(flex: 4, child: _buildQrView(context)),
  // Container(
  // child: Row(
  // children: [
  // Image.asset("assets/images/gallery.png"),
  // Text("Select Image for QR Scan",style: TextStyle(color: PRIMARY_COLOR_1,fontSize: TEXT_REGULAR,fontWeight: FontWeight.w500),)
  // ],
  // ),
  // )
  // ],
  // ),
  // Widget _buildQrView(BuildContext context) {
  //   // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
  //   var scanArea = (MediaQuery.of(context).size.width < 400 ||
  //           MediaQuery.of(context).size.height < 400)
  //       ? 150.0
  //       : 300.0;
  //   // To ensure the Scanner view is properly sizes after rotation
  //   // we need to listen for Flutter SizeChanged notification and update controller
  //   return QRView(
  //     key: qrKey,
  //     onQRViewCreated: _onQRViewCreated,
  //     overlay:
  //         QrScannerOverlayShape(borderColor: Colors.white, cutOutSize: scanArea
  //             // borderRadius: 10,
  //             //borderLength: 30,
  //             // borderWidth: 10,
  //             //cutOutSize: scanArea
  //             ),
  //     onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
  //   );
  // }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code;
        debugPrint("Result==>$result");
      });
    });
  }

  // void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
  //   log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
  //   if (!p) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('no Permission')),
  //     );
  //   }
  // }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
