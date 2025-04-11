import 'package:cloud_firestore/cloud_firestore.dart';

class QRDetailModel {
  final String? uuid;
  final String? user_id;
  final DateTime scanned_at;

  QRDetailModel({
    required this.uuid,
    required this.user_id,
    required this.scanned_at,
  });

  /// Static function to create an empty model
  static QRDetailModel empty() => QRDetailModel(
    uuid: '',
    user_id: '',
    scanned_at: DateTime.now(),
  );

  /// Convert model to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'user_id': user_id,
      'scanned_at': Timestamp.fromDate(scanned_at),
    };
  }

  /// Factory constructor to create a model from Firestore snapshot
  factory QRDetailModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return QRDetailModel(
        uuid: data['uuid'] ?? '',
        user_id: data['user_id'] ?? '',
        scanned_at: (data['scanned_at'] as Timestamp).toDate(),
      );
    } else {
      return QRDetailModel.empty();
    }
  }
}
