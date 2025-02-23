import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:wastenot/features/shop/controllers/scan/qrScan_controller.dart';

// class QRScanPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final QRController qrController = Get.put(QRController());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scan QR Code'),
//       ),
//       body: QRView(
//         key: GlobalKey(debugLabel: 'QR'),
//         onQRViewCreated: qrController.onQRViewCreated,
//         overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: 300,
//         ),
//       ),
//     );
//   }
// }

class QRScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final QRController qrController = Get.put(QRController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: QRView(
        key: qrController.qrKey,
        onQRViewCreated: qrController.onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 300,
        ),
      ),
    );
  }
}