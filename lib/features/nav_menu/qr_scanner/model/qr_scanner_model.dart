// File: lib/features/nav_menu/qr_scanner/model/qr_scanner_model.dart

class RecyclingData {
  final String itemType;
  final int count;

  RecyclingData({
    required this.itemType,
    required this.count,
  });

  int get points => count * RecyclingData.getPointsPerItem(itemType);

  static int getPointsPerItem(String objectType) {
    switch (objectType.toLowerCase()) {
      case 'plastic':
        return 3;
      case 'aluminum':
        return 2;
      case 'glass':
        return 2;
      case 'paper':
        return 1;
      default:
        return 1;
    }
  }
}