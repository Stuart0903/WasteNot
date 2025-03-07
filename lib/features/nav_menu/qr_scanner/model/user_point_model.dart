import 'package:cloud_firestore/cloud_firestore.dart';

class UserPoint {
  String pointId;
  int totalEarned;
  int totalRedeemed;
  int availablePoints;
  Timestamp lastUpdate;
  String userId;

  UserPoint({
    required this.pointId,
    required this.totalEarned,
    required this.totalRedeemed,
    required this.availablePoints,
    required this.lastUpdate,
    required this.userId,
  });

  ///Static function to create an empty model
  static UserPoint empty() => UserPoint(
    pointId: '',
    totalEarned: 0,
    totalRedeemed: 0,
    availablePoints: 0,
    lastUpdate: Timestamp.now(),
    userId: '',
  );

  // Convert a UserPoint object to a Map
  Map<String, dynamic> toMap() {
    return {
      'point_id': pointId,
      'total_earned': totalEarned,
      'total_redeemed': totalRedeemed,
      'available_points': availablePoints,
      'last_update': lastUpdate,
      'user_id': userId,
    };
  }



  // Create a UserPoint object from a Map
  factory UserPoint.fromMap(Map<String, dynamic> map) {
    return UserPoint(
      pointId: map['point_id'] ?? '',
      totalEarned: map['total_earned'] ?? 0,
      totalRedeemed: map['total_redeemed'] ?? 0,
      availablePoints: map['available_points'] ?? 0,
      lastUpdate: map['last_update'] ?? Timestamp.now(),
      userId: map['user_id'] ?? '',
    );
  }

  // Convert Firestore DocumentSnapshot to UserPoint object
  factory UserPoint.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    if(doc.data()!=null){
      return UserPoint.fromMap(data);
    }else{
      return UserPoint.empty();
    }

  }

  // Helper functions
  void earnPoints(int points) {
    totalEarned += points;
    availablePoints += points;
    lastUpdate = Timestamp.now();
  }

  void redeemPoints(int points) {
    if (points <= availablePoints) {
      totalRedeemed += points;
      availablePoints -= points;
      lastUpdate = Timestamp.now();
    } else {
      throw Exception("Not enough available points to redeem");
    }
  }

  int getAvailablePoints() {
    return availablePoints;
  }

  int getTotalEarnedPoints() {
    return totalEarned;
  }

  int getTotalRedeemedPoints() {
    return totalRedeemed;
  }
}
