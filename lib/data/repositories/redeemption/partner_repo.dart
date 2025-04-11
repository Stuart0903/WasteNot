import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wastenot/features/nav_menu/Dashboard/model/partner_model.dart';
import 'package:wastenot/utils/exceptions/firebase_exceptions.dart';
import 'package:wastenot/utils/exceptions/format_exceptions.dart';
import 'package:wastenot/utils/exceptions/platform_exceptions.dart';

class PartnerRepo extends GetxController {
  static PartnerRepo get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to fetch **only active partners** details
  Future<List<PartnerModel>> fetchPartnerDetails() async {
    try {
      // Only fetch documents where `is_active` is true
      final querySnapshot = await _db
          .collection("wastenot_partners")
          .where("is_active", isEqualTo: true) // <-- Filter here
          .get();

      if (querySnapshot.docs.isEmpty) {
        print("No active partner data found in Firestore.");
        return [];
      }

      // Map documents to PartnerModel
      var partnerDetails = querySnapshot.docs.map((doc) {
        print("Processing Document: ${doc.id}, Data: ${doc.data()}"); // Debugging
        return PartnerModel.fromSnapshot(doc);
      }).toList();

      print("Fetched Active Partners: ${partnerDetails.length}");
      return partnerDetails;
    } on FirebaseException catch (e) {
      print("Firebase Error: ${e.code} - ${e.message}");
      throw WNFirebaseException(e.code).message;
    } on FormatException catch (_) {
      print("Format Error");
      throw const WNFormatException();
    } on PlatformException catch (e) {
      print("Platform Error: ${e.message}");
      throw WNPlatformException(e.code).message;
    } catch (e) {
      print("Unexpected Error: $e");
      throw 'Something went wrong. Please try again';
    }
  }
}