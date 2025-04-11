import 'package:flutter_test/flutter_test.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/controller/qr_scanner_controller.dart';
import '../helpers/qr_test_helper.dart';

void main() {
  group('QR Processing Speed Tests', () {
    late QRScannerController qrController;

    setUp(() {
      qrController = QRScannerController();
    });

    test('Measure basic QR processing speed', () async {
      const testData = '''
      [{
        "qr_id": "test123",
        "items": [
          {"class": "plastic", "count": 5},
          {"class": "paper", "count": 3}
        ]
      }]
      ''';

      final duration = await QRTestHelper.measureQRProcessingSpeed(testData);

      print('Basic QR processing time: ${duration.inMilliseconds}ms');
      expect(duration.inMilliseconds, lessThan(50));
    });

    test('Measure processing speed with varying item counts', () async {
      final smallQrData = QRTestHelper.generateTestQRData(itemCount: 3);
      final mediumQrData = QRTestHelper.generateTestQRData(itemCount: 10);
      final largeQrData = QRTestHelper.generateTestQRData(itemCount: 50);

      final smallTime = await QRTestHelper.measureQRProcessingSpeed(smallQrData);
      final mediumTime = await QRTestHelper.measureQRProcessingSpeed(mediumQrData);
      final largeTime = await QRTestHelper.measureQRProcessingSpeed(largeQrData);

      print('\nQR Processing Speed Comparison:');
      print('3 items: ${smallTime.inMilliseconds}ms');
      print('10 items: ${mediumTime.inMilliseconds}ms');
      print('50 items: ${largeTime.inMilliseconds}ms');

      expect(smallTime.inMilliseconds, lessThan(mediumTime.inMilliseconds));
      expect(mediumTime.inMilliseconds, lessThan(largeTime.inMilliseconds));
    });

    test('Test full controller processing speed', () async {
      final testData = QRTestHelper.generateTestQRData();
      final stopwatch = Stopwatch()..start();

      qrController.processQRData(testData);
      stopwatch.stop();

      print('Full controller processing time: ${stopwatch.elapsedMilliseconds}ms');
      expect(stopwatch.elapsedMilliseconds, lessThan(100));
    });
  });

  group('QR Scanning Integration Tests', () {
    test('Measure complete scan-to-process workflow', () async {
      final qrController = QRScannerController();
      const testData = '''
      [{
        "qr_id": "perf_test",
        "items": [
          {"class": "plastic", "count": 2},
          {"class": "aluminum", "count": 4}
        ]
      }]
      ''';

      final stopwatch = Stopwatch()..start();
      qrController.processQRData(testData);
      stopwatch.stop();

      print('Complete workflow time: ${stopwatch.elapsedMilliseconds}ms');
      expect(stopwatch.elapsedMilliseconds, lessThan(150));
      expect(qrController.jsonData.length, 2);
      expect(qrController.totalPoints, 14); // (2*3) + (4*2)
    });
  });
}