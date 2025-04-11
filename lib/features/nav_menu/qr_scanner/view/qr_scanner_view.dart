// File: lib/features/nav_menu/qr_scanner/view/qr_scanner_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:wastenot/common/widgets/appbar/appbar.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/view/widgets/gallery_button.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/view/widgets/scan_instruction_card.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/sizes.dart';
import '../controller/qr_scanner_controller.dart';


class QRScannerPage extends StatelessWidget {
  const QRScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final QRScannerController controller = Get.put(QRScannerController());

    return Scaffold(
      appBar: WNAppBar(
        title: const Text('QR Scanner'),
        showBackArrow: true,
      ),
      body: Column(
        children: [
          // "Choose from Gallery" button at the top
          GalleryButton(
            onPressed: controller.pickImageFromGallery,
            backgroundColor: WNColors.primary,
            icon: Icons.photo_library,
          ),

          // QR scanner section in the middle
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                QRView(
                  key: controller.qrKey,
                  onQRViewCreated: controller.onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: WNColors.primary,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: MediaQuery.of(context).size.width * 0.7,
                  ),
                ),
                Obx(() => controller.isProcessing.value
                    ? Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: WNColors.primary,
                    ),
                  ),
                )
                    : const SizedBox.shrink()),
              ],
            ),
          ),

          // Instructions section at bottom
          Expanded(
            flex: 2,
            child: Obx(() => !controller.isScanned.value
                ? const ScanInstructionCard()
                : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

