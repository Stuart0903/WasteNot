import 'package:cloud_firestore/cloud_firestore.dart';

class PartnerModel {
  final String? id;
  final String address;
  final String companyCategory;
  final String companyName;
  final String contactEmail;
  final String contactNo;
  final bool isActive;
  final String partnershipSince;

  /// Constructor for PartnerModel
  PartnerModel({
    this.id,
    required this.address,
    required this.companyCategory,
    required this.companyName,
    required this.contactEmail,
    required this.contactNo,
    required this.isActive,
    required this.partnershipSince,
  });

  /// Static function to create an empty model
  static PartnerModel empty() => PartnerModel(
    id: '',
    address: '',
    companyCategory: '',
    companyName: '',
    contactEmail: '',
    contactNo: '',
    isActive: false,
    partnershipSince: '',
  );

  /// Convert model to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'company_category': companyCategory,
      'company_name': companyName,
      'contact_email': contactEmail,
      'contact_no': contactNo,
      'is_active': isActive,
      'partnership_since': partnershipSince,
    };
  }

  /// Factory constructor to create a model from Firestore snapshot
  factory PartnerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return PartnerModel(
        id: document.id,
        address: data['address'] ?? '',
        companyCategory: data['company_category'] ?? '',
        companyName: data['company_name'] ?? '',
        contactEmail: data['contact_email'] ?? '',
        contactNo: data['contact_no'] ?? '',
        isActive: data['is_active'] ?? false,
        partnershipSince: data['partnership_since'] ?? '',
      );
    } else {
      return PartnerModel.empty();
    }
  }
}