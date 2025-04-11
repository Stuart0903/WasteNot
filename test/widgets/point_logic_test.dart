import 'package:flutter_test/flutter_test.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/model/qr_scanner_model.dart';

void main() {
  group('RecyclingData Model Tests', () {
    test('Points calculation for plastic items', () {
      print('\n=== Testing Plastic Items ===');
      final data = RecyclingData(itemType: 'plastic', count: 5);
      print('Expected points: 15 (5 items × 3 points)');
      print('Calculated points: ${data.points}');
      expect(data.points, equals(15));
    });

    test('Points calculation for aluminum items', () {
      print('\n=== Testing Aluminum Items ===');
      final data = RecyclingData(itemType: 'aluminum', count: 3);
      print('Expected points: 6 (3 items × 2 points)');
      print('Calculated points: ${data.points}');
      expect(data.points, equals(6));
    });
  //
  //   // test('Points calculation for glass items', () {
  //   //   print('\n=== Testing Glass Items ===');
  //   //   final data = RecyclingData(itemType: 'glass', count: 4);
  //   //   print('Expected points: 8 (4 items × 2 points)');
  //   //   print('Calculated points: ${data.points}');
  //   //   expect(data.points, equals(8));
  //   // });
  //
  //   // test('Points calculation for paper items', () {
  //   //   print('\n=== Testing Paper Items ===');
  //   //   final data = RecyclingData(itemType: 'paper', count: 10);
  //   //   print('Expected points: 10 (10 items × 1 point)');
  //   //   print('Calculated points: ${data.points}');
  //   //   expect(data.points, equals(10));
  //   // });
  //
  //   test('Points calculation for unknown item type', () {
  //     print('\n=== Testing Unknown Item Type ===');
  //     final data = RecyclingData(itemType: 'unknown', count: 7);
  //     print('Expected points: 7 (7 items × 1 default point)');
  //     print('Calculated points: ${data.points}');
  //     expect(data.points, equals(7));
  //   });
  //
  //   test('Case insensitivity test', () {
  //     print('\n=== Testing Case Insensitivity ===');
  //     final data1 = RecyclingData(itemType: 'PLASTIC', count: 2);
  //     final data2 = RecyclingData(itemType: 'PlAsTiC', count: 2);
  //     final data3 = RecyclingData(itemType: 'plastic', count: 2);
  //
  //     print('All variations should return 6 points (2 items × 3 points)');
  //     print('UPPERCASE: ${data1.points}');
  //     print('MixedCase: ${data2.points}');
  //     print('lowercase: ${data3.points}');
  //
  //     expect(data1.points, equals(6));
  //     expect(data2.points, equals(6));
  //     expect(data3.points, equals(6));
  //   });
  //
  //   test('Zero count returns zero points', () {
  //     print('\n=== Testing Zero Count ===');
  //     final data = RecyclingData(itemType: 'plastic', count: 0);
  //     print('Expected points: 0 (0 items × any points)');
  //     print('Calculated points: ${data.points}');
  //     expect(data.points, equals(0));
  //   });
  //
  //   test('Negative count throws assertion error', () {
  //     print('\n=== Testing Negative Count ===');
  //     expect(
  //           () => RecyclingData(itemType: 'plastic', count: -1),
  //       throwsA(isA<AssertionError>()),
  //     );
  //     print('✓ Correctly throws AssertionError for negative count');
  //   });
  // });
  //
  // group('getPointsPerItem Static Method Tests', () {
  //   test('Returns correct points for plastic', () {
  //     expect(RecyclingData.getPointsPerItem('plastic'), equals(3));
  //   });
  //
  //   test('Returns correct points for aluminum', () {
  //     expect(RecyclingData.getPointsPerItem('aluminum'), equals(2));
  //   });
  //
  //   test('Returns correct points for glass', () {
  //     expect(RecyclingData.getPointsPerItem('glass'), equals(2));
  //   });
  //
  //   test('Returns correct points for paper', () {
  //     expect(RecyclingData.getPointsPerItem('paper'), equals(1));
  //   });
  //
  //   test('Returns default points for unknown types', () {
  //     expect(RecyclingData.getPointsPerItem('unknown'), equals(1));
  //   });
  //
  //   test('Is case insensitive', () {
  //     expect(RecyclingData.getPointsPerItem('PLASTIC'), equals(3));
  //     expect(RecyclingData.getPointsPerItem('Glass'), equals(2));
  //   });
  });
}