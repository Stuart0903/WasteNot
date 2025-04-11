import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/view/qr_scanner_view.dart';

class MockQRScannerController extends Mock {
  void processQRData(String data);
}

void main() {
  testWidgets('QR Scanner Page renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: QRScannerPage()));
    expect(find.text('Scan QR Code'), findsOneWidget);
  });

  // Add more widget tests as needed, mocking the controller if necessary
}