// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class VoucherDetailsModel {
//   final String id;
//   final String categoryId;
//   final String createdAt;
//   final String description;
//   final bool isActive;
//   final String partnerId;
//   final int pointsCost;
//   final String termsConditions;
//   final String title;
//   final String validFrom;
//   final String validUntil;
//
//   /// Constructor for VoucherInfoModel
//   VoucherDetailsModel({
//     required this.id,
//     required this.categoryId,
//     required this.createdAt,
//     required this.description,
//     required this.isActive,
//     required this.partnerId,
//     required this.pointsCost,
//     required this.termsConditions,
//     required this.title,
//     required this.validFrom,
//     required this.validUntil,
//   });
//
//   /// Static function to create an empty voucher model
//   static VoucherDetailsModel empty() => VoucherDetailsModel(
//     id: '',
//     categoryId: '',
//     createdAt: '',
//     description: '',
//     isActive: false,
//     partnerId: '',
//     pointsCost: 0,
//     termsConditions: '',
//     title: '',
//     validFrom: '',
//     validUntil: '',
//   );
//
//   /// Convert model to JSON for Firestore
//   Map<String, dynamic> toJson() {
//     return {
//       'category_id': categoryId,
//       'created_at': createdAt,
//       'description': description,
//       'is_active': isActive,
//       'partner_id': partnerId,
//       'points_cost': pointsCost,
//       'terms_conditions': termsConditions,
//       'title': title,
//       'valid_from': validFrom,
//       'valid_until': validUntil,
//     };
//   }
//
//   /// Factory method to create a VoucherInfoModel from a Firestore document snapshot
//   factory VoucherDetailsModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
//     if (document.data() != null) {
//       final data = document.data()!;
//       return VoucherDetailsModel(
//         id: document.id,
//         categoryId: data['category_id'] ?? '',
//         createdAt: data['created_at'] ?? '',
//         description: data['description'] ?? '',
//         isActive: data['is_active'] ?? false,
//         partnerId: data['partner_id'] ?? '',
//         pointsCost: data['points_cost'] ?? 0,
//         termsConditions: data['terms_conditions'] ?? '',
//         title: data['title'] ?? '',
//         validFrom: data['valid_from'] ?? '',
//         validUntil: data['valid_until'] ?? '',
//       );
//     } else {
//       return VoucherDetailsModel.empty();
//     }
//   }
//
//   /// Helper method to check if the voucher is currently active
//   bool get isinActive => isActive;
//
//   /// Helper method to check if the voucher is expired
//   bool get isExpired {
//     if (validUntil.isEmpty) return false;
//     final expiryDate = DateTime.tryParse(validUntil);
//     return expiryDate != null && expiryDate.isBefore(DateTime.now());
//   }
//
//   /// Helper method to check if the voucher is valid (active and not expired)
//   bool get isValid => isActive && !isExpired;
// }
