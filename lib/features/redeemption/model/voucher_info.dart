import 'package:cloud_firestore/cloud_firestore.dart';

class VoucherInfoModel {
  final String id;
  String category;
  String description;
  String name;
  String partnerId;
  int pointsRequired;
  String status;
  String usageRules;
  String validFrom;
  String validUntil;

  /// Constructor for RewardModel
  VoucherInfoModel({
    required this.id,
    required this.category,
    required this.description,
    required this.name,
    required this.partnerId,
    required this.pointsRequired,
    required this.status,
    required this.usageRules,
    required this.validFrom,
    required this.validUntil,
  });

  /// Static function to create an empty reward model
  static VoucherInfoModel empty() => VoucherInfoModel(
    id: '',
    category: '',
    description: '',
    name: '',
    partnerId: '',
    pointsRequired: 0,
    status: '',
    usageRules: '',
    validFrom: '',
    validUntil: '',
  );

  /// Convert model to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'name': name,
      'partner_id': partnerId,
      'points_required': pointsRequired,
      'status': status,
      'usage_rules': usageRules,
      'valid_from': validFrom,
      'valid_until': validUntil,
    };
  }

  /// Factory method to create a RewardModel from a Firestore document snapshot
  factory VoucherInfoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return VoucherInfoModel(
        id: document.id,
        category: data['category'] ?? '',
        description: data['description'] ?? '',
        name: data['name'] ?? '',
        partnerId: data['partner_id'] ?? '',
        pointsRequired: data['points_required'] ?? 0,
        status: data['status'] ?? '',
        usageRules: data['usage_rules'] ?? '',
        validFrom: data['valid_from'] ?? '',
        validUntil: data['valid_until'] ?? '',
      );
    } else {
      return VoucherInfoModel.empty();
    }
  }

  /// Helper method to check if the reward is currently active
  bool get isActive => status.toLowerCase() == 'active';

  /// Helper method to check if the reward is expired
  bool get isExpired {
    if (validUntil.isEmpty) return false;
    final expiryDate = DateTime.tryParse(validUntil);
    return expiryDate != null && expiryDate.isBefore(DateTime.now());
  }

  /// Helper method to check if the reward is valid (active and not expired)
  bool get isValid => isActive && !isExpired;
}