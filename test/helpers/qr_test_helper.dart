import 'dart:async';
import 'dart:convert';
import 'package:wastenot/features/nav_menu/qr_scanner/model/qr_scanner_model.dart';

class QRTestHelper {
  static Future<Duration> measureQRProcessingSpeed(String data) async {
    final stopwatch = Stopwatch()..start();

    try {
      // Simulate the processing logic
      final decodedData = jsonDecode(data);
      if (decodedData is! List || decodedData.length != 1) {
        throw FormatException('Invalid format');
      }

      final qrObject = decodedData.first as Map<String, dynamic>;
      final items = qrObject['items'] as List;

      for (var item in items.cast<Map<String, dynamic>>()) {
        RecyclingData(
          itemType: item['class'].toString(),
          count: item['count'] is int ? item['count'] as int :
          (item['count'] as double).toInt(),
        ).points;
      }

      stopwatch.stop();
      return stopwatch.elapsed;
    } catch (e) {
      stopwatch.stop();
      rethrow;
    }
  }

  static String generateTestQRData({int itemCount = 3}) {
    final items = List.generate(itemCount, (i) => {
      'class': ['plastic', 'paper', 'aluminum'][i % 3],
      'count': (i + 1) * 2
    });

    return jsonEncode([{
      'qr_id': 'test_${DateTime.now().millisecondsSinceEpoch}',
      'items': items
    }]);
  }
}