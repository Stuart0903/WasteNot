import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';


import '../../views/scan/qrScanResult.dart';
import '../../views/testPraser.dart';

class QRController extends GetxController {
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        controller.pauseCamera();
        Map<String, dynamic> data = parseQRData(scanData.code!);
        Get.to(() => QRResultPage(qrData: data));
      }
    });
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
