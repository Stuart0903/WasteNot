import 'package:cloud_firestore/cloud_firestore.dart';

class DepositModel{
  final String? depositId;
  final String? userId;
  final DateTime depositTime;
  final double totalPoints;
  final String status;

  ///Constructor for DepositModel
  DepositModel({
    this.depositId,
    this.userId,
    required this.depositTime,
    required this.totalPoints,
    required this.status,
  });

  ///Static function to create an empty model
  static DepositModel empty() => DepositModel(
    depositId: '',
    userId: '',
    depositTime: DateTime.now(),
    totalPoints: 0,
    status: '',
  );

  ///Convert model to JSON for Firestore
  Map<String, dynamic> toJson(){
    return{
      'deposit_id': depositId,
      'user_id': userId,
      'deposit_time': depositTime,
      'total_points': totalPoints,
      'status': status,
    };
  }

  ///Convert JSON to model
  factory DepositModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if(document.data()!=null){
      final data = document.data()!;
      return DepositModel(
        depositId: document.id,
        userId: data['user_id'] ?? '',
        depositTime: data['deposit_time']?.toDate() ?? DateTime.now(),
        totalPoints: data['total_points'] ?? 0,
        status: data['status']?? '',
      );
    }else{
      return DepositModel.empty();
    }
  }


}