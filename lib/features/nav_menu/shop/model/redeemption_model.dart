import 'package:cloud_firestore/cloud_firestore.dart';

class RedeemptionModel {
  final String? id;
  final String expireAt;
  final DateTime purchaseAt;
  final bool isRedeemed;
  final String voucherId;
  final String userId;

  /// Constructor for VoucherInfoModel
  RedeemptionModel({
    required this.id,
    required this.expireAt,
    required this.purchaseAt,
    required this.isRedeemed,
    required this.voucherId,
    required this.userId,
  });

  /// Static function to create an empty voucher model
  static RedeemptionModel empty() =>
      RedeemptionModel(
        id: '',
        expireAt: '',
        purchaseAt: DateTime.now(),
        isRedeemed: false,
        voucherId: '',
        userId: '',
      );

  /// Convert model to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'expires_At': expireAt,
      'purchase_At': purchaseAt,
      'is_Redeemed': isRedeemed,
      'voucher_Id': voucherId,
      'user_Id': userId,
    };
  }

  /// Factory method to create a VoucherInfoModel from a Firestore document snapshot
  factory RedeemptionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return RedeemptionModel(
        id: document.id,
        expireAt: data['expires_At'] ?? '',
        purchaseAt: data['purchase_At'] ?? '',
        isRedeemed: data['is_Redeemed'] ?? false,
        voucherId: data['voucher_Id'] ?? '',
        userId: data['user_Id'] ?? '',
      );
    } else {
      return RedeemptionModel.empty();
    }
  }
}
