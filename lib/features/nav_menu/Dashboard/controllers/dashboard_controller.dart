import 'dart:convert';
import 'package:get/get.dart';
import 'package:wastenot/data/repositories/redeemption/partner_repo.dart';
import 'package:wastenot/features/nav_menu/Dashboard/model/partner_model.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  RxList<PartnerModel> partners = <PartnerModel>[].obs; // Store the full list

  final PartnerRepo partnerRepository = Get.put(PartnerRepo());

  @override
  void onInit() {
    super.onInit();
    fetchPartnerRecord();
  }

  /// Fetch Partners Record
  Future<void> fetchPartnerRecord() async {
    try {
      final partnerList = await partnerRepository.fetchPartnerDetails();
      print("Partner List: $partnerList");

      if (partnerList.isNotEmpty) {
        partners.assignAll(partnerList); // Store all partners in observable list
      } else {
        partners.clear();
      }
    } catch (e) {
      partners.clear();
      print("Error fetching partners: $e");
    }
  }

  // /// Print partners as JSON
  // void printPartnersAsJson() {
  //   final jsonString = jsonEncode(partners.map((p) => p.toJson()).toList());
  //   print(jsonString);
  // }
}
