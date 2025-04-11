import 'package:get/get.dart';
import 'package:wastenot/data/repositories/redeemption/redeemption_repo.dart';
import 'package:wastenot/features/redeemption/model/voucher_info.dart';

class VoucherPageController extends GetxController{
  static VoucherPageController get instance => Get.find();

  final _redeemptionRepo = Get.put(RedeemptionRepo());

  final RxBool isLoading = false.obs;
  final RxList<VoucherInfoModel> availableVouchers = <VoucherInfoModel>[].obs;
  final RxString error = ''.obs;

  @override
  void onInit(){
    fetchAllVouchers();
    super.onInit();
  }

  Future<void> fetchAllVouchers() async{
    try {
      isLoading.value = true;
      error.value = '';

      final vouchers = await _redeemptionRepo.fetchVoucherInfoDetails();
      availableVouchers.assignAll(vouchers);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }


}