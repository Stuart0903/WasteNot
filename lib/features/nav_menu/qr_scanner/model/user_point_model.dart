import 'package:cloud_firestore/cloud_firestore.dart';

class UserPoint {
  final String? pointId;
  final double totalEarned;
  final double? totalRedeemed;
  final double availablePoints;
  final Timestamp lastUpdate;
  final String? userId;

  ///Constructor for User Point
  UserPoint({
    this.pointId,
    required this.totalEarned,
    this.totalRedeemed,
    required this.availablePoints,
    required this.lastUpdate,
    this.userId,
  });

  /// Static function to create an empty model
  static UserPoint empty() => UserPoint(
    pointId: '',
    totalEarned: 0,
    totalRedeemed: 0,
    availablePoints: 0,
    lastUpdate: Timestamp.now(),
    userId: '',
  );

  // Convert  model to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'point_id': pointId,
      'total_earned': totalEarned,
      'total_redeemed': totalRedeemed,
      'available_points': availablePoints,
      'last_update': lastUpdate,
      'user_id': userId,
    };
  }

factory UserPoint.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if(document.data()!= null){
      final data = document.data()!;
      return UserPoint(
        pointId: document.id,
        totalEarned: data['total_earned'] ?? 0,
        totalRedeemed: data['total_redeemed'] ?? 0,
        availablePoints: data['available_points'] ?? 0,
        lastUpdate: data['last_update'] ?? Timestamp.now(),
        userId: data['user_id'] ?? '',
      );
    }else{
      return UserPoint.empty();
    }
}

}