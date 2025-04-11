// import 'package:flutter_test/flutter_test.dart';
// import 'package:wastenot/utils/exceptions/format_exceptions.dart';
// import '../helpers/qr_test_helper.dart';
//
// void main() {
//   group('QR Code Processing Tests', () {
//     test('Valid QR data is processed correctly', () {
//       const validData = '''
//       [{
//         "qr_id": "12345",
//         "items": [
//           {"class": "plastic", "count": 5},
//           {"class": "paper", "count": 3}
//         ]
//       }]
//       ''';
//
//       print('\n=== TEST 1: Valid QR Data ===');
//       final result = QRTestHelper.processQRData(validData);
//
//       print('Expected QR ID: 12345 | Received: ${result.qrId}');
//       print('Expected 2 items | Received: ${result.jsonData?.length} items');
//       print('Plastic count should be 5 | Received: ${result.jsonData?['plastic']?['count']}');
//       print('Paper count should be 3 | Received: ${result.jsonData?['paper']?['count']}');
//
//       expect(result.qrId, equals("12345"));
//       expect(result.jsonData?.length, equals(2));
//       expect(result.jsonData?['plastic']?['count'], equals(5));
//       expect(result.jsonData?['paper']?['count'], equals(3));
//       expect(result.isScanned, isTrue);
//     });
//
//     test('Empty QR data throws FormatException', () {
//       print('\n=== TEST 2: Empty Data ===');
//       expect(
//             () => QRTestHelper.processQRData(''),
//         throwsA(isA<WNFormatException>()),
//       );
//       print('✓ Correctly threw FormatException for empty data');
//     });
//
//   });
// }