

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
import 'package:wastenot/data/repositories/points/deposit_repo.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/model/deposit_item_model.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/model/deposit_model.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/model/qr_scanner_model.dart';
import 'package:wastenot/utils/https/network_manager.dart';

class DepositController extends GetxController{
  static DepositController get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final AuthenticationRepository _authRepo = Get.put(AuthenticationRepository());

  final DepositRepository _depositRepo = Get.put(DepositRepository());

  // Reactive variables
  Rx<List<DepositModel>> deposits = Rx<List<DepositModel>>([]);
  Rx<Map<String, int>> itemQuantities = Rx<Map<String, int>>({
    'plastic': 0,
    'glass': 0,
    'can': 0,
  }.obs);

  @override
  void onInit() {
    super.onInit();
    fetchUserDeposits();
    fetchItemQuantities();
  }

  /// Fetch all deposits for the current user
  Future<void> fetchUserDeposits() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId != null) {
        final depositsList = await _depositRepo.fetchUserDeposits(userId);
        deposits(depositsList);
      }
    } catch (e) {
      deposits([]);
    }
  }

  /// Fetch quantities of items by material type for the current user
  Future<void> fetchItemQuantities() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId != null) {
        final quantities = await _depositRepo.fetchItemQuantities(userId);
        itemQuantities(quantities);
      }
    } catch (e) {
      itemQuantities({
        'plastic': 0,
        'glass': 0,
        'can': 0,
      });
    }
  }

  //Method to add data in deposit table
  Future<void> createDeposit(Map<String, Map<String, dynamic>> scannedData, double totalPoints) async {
    try{
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        throw "No internet connection. Please try again when connected.";
      }
      //Get current user ID
      final userId = _authRepo.authUser?.uid;
      if (userId == null) {
        throw "User not authenticated";
      }

      final depositId =  _db.collection("Deposits").doc().id;

      //Create deposit model
      final deposit = DepositModel(
        depositId: depositId,
        status: 'Completed',
        depositTime: DateTime.now(),
        totalPoints: totalPoints,
        userId: userId
      );

      await _depositRepo.addDeposit(deposit);


      for (var entry in scannedData.entries) {
        final materialType = entry.key;
        final count = entry.value['count'] as int;
        final pointsPerItem = RecyclingData.getPointsPerItem(materialType);
        final itemPoints = count * pointsPerItem.toDouble();

        final depositItem = DepositItem(
           itemId: _db.collection("deposit_items").doc().id,
          materialType: materialType,
          depositId: depositId,
          quantity: count,
          points: itemPoints,
          scannedAt: DateTime.now(),
        );

        // Add deposit item to Firestore
        await _depositRepo.addDepositItem(depositItem);
      }

    }catch(e){
      throw e.toString();
    }
  }

}