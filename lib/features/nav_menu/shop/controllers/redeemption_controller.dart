
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart%20';
import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
import 'package:wastenot/data/repositories/redeemption/redeemption_repo.dart';
import 'package:wastenot/features/nav_menu/shop/model/redeemption_model.dart';
import 'package:wastenot/features/redeemption/model/voucher_info.dart';
import 'package:wastenot/utils/https/network_manager.dart';

class RedeemptionController extends GetxController{
  static RedeemptionController get instance => Get.find();

  final RedeemptionRepo _redeemRepo = Get.put(RedeemptionRepo());
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final AuthenticationRepository _authRepo = Get.put(AuthenticationRepository());

  Rx<List<RedeemptionModel>> redemptions = Rx<List<RedeemptionModel>>([]);

  RxList<VoucherInfoModel> userVouchers = <VoucherInfoModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserVoucherData();
  }

  Future<void> saveRedeemptionData({
    required String voucherId,
    required String expiredAt
}) async {
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

      final redeemId =  _db.collection("redemption").doc().id;

      final redeem = RedeemptionModel(
          id: redeemId,
          expireAt: expiredAt,
          purchaseAt: DateTime.now(),
          isRedeemed: false,
          voucherId: voucherId,
          userId: userId);
      await _redeemRepo.saveRedeemption(redeem);

    }catch(e){
      throw e.toString();
    }
  }

  Future<void> updateVoucherStatus(String voucherId) async {
    try {
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        throw "No internet connection. Please try again when connected.";
      }

      await _redeemRepo.updateVoucherStatus(voucherId);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void>getUserVoucherData()async{
    try {
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        throw "No internet connection. Please try again when connected.";
      }

      final userId = _authRepo.authUser?.uid;
      if (userId == null) {
        throw "User not authenticated";
      }

      final fetched = await _redeemRepo.getUserVoucherInfo(userId);
      userVouchers.assignAll(fetched);

    }catch(e){
      throw e.toString();
    }

  }

}