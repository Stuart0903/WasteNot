import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
import 'package:wastenot/data/repositories/points/points_repo.dart';
import 'package:wastenot/data/repositories/redeemption/redeemption_repo.dart';
import 'package:wastenot/features/redeemption/model/voucher_info.dart';
import '../../nav_menu/qr_scanner/model/user_point_model.dart';
import '../../nav_menu/shop/views/voucher_detail_page.dart';

class VoucherCategory {
  final String name;
  final IconData icon;

  VoucherCategory({required this.name, required this.icon});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is VoucherCategory &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class VoucherController extends GetxController {
  static VoucherController get instance => Get.find();

  // Repositories
  final _redeemptionRepo = Get.put(RedeemptionRepo());
  final _userPointsRepo = Get.put(PointRepository());

  // Voucher-related observables
  final RxBool isLoading = false.obs;
  final RxList<VoucherInfoModel> availableVouchers = <VoucherInfoModel>[].obs;
  final RxList<VoucherCategory> categories = <VoucherCategory>[].obs;
  final RxInt selectedCategoryIndex = 0.obs;
  final RxString error = ''.obs;

  // User points observables
  final Rx<UserPoint?> userPoints = Rx<UserPoint?>(null);
  final RxBool isPointsLoading = false.obs;
  final RxString pointsError = ''.obs;

  @override
  void onInit() {
    fetchInitialData();
    super.onInit();
  }

  // Data fetching
  Future<void> fetchInitialData() async {
    await Future.wait([
      fetchAllVouchers(),
      fetchUserPoints(),
    ]);
  }

  Future<void> fetchAllVouchers() async {
    try {
      isLoading.value = true;
      error.value = '';

      final vouchers = await _redeemptionRepo.fetchVoucherInfoDetails();
      availableVouchers.assignAll(vouchers);
      _updateCategoriesFromVouchers(vouchers);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserPoints() async {
    try {
      isPointsLoading.value = true;
      pointsError.value = '';

      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) {
        pointsError.value = 'User not authenticated';
        return;
      }

      final points = await _userPointsRepo.getUserPoints(userId);
      userPoints.value = points;

      if (points == null) {
        pointsError.value = 'No points data found';
      }
    } catch (e) {
      pointsError.value = e.toString();
      userPoints.value = null;
    } finally {
      isPointsLoading.value = false;
    }
  }

  // Category management
  void _updateCategoriesFromVouchers(List<VoucherInfoModel> vouchers) {
    final categorySet = <VoucherCategory>{};

    for (final voucher in vouchers.where((v) => v.isValid && v.category.isNotEmpty)) {
      categorySet.add(VoucherCategory(
        name: voucher.category,
        icon: _getIconForCategory(voucher.category)),
      );
          }

          final categoryList = <VoucherCategory>[
          VoucherCategory(name: 'All', icon: Iconsax.category),
    ];

    categoryList.addAll(
    categorySet.toList()..sort((a, b) => a.name.compareTo(b.name))
    );

    categories.assignAll(categoryList);
  }

  void selectCategory(int index) {
    if (index >= 0 && index < categories.length) {
      selectedCategoryIndex.value = index;
    }
  }

  // Voucher filtering
  List<VoucherInfoModel> get filteredVouchers {
    if (selectedCategoryIndex.value == 0 || categories.isEmpty) {
      return validVouchers;
    }

    final selectedCategory = categories[selectedCategoryIndex.value].name;
    return validVouchers.where((v) =>
        v.category.equalsIgnoreCase(selectedCategory)
    ).toList();
  }

  // Voucher accessors
  List<VoucherInfoModel> get validVouchers =>
      availableVouchers.where((v) => v.isValid).toList();

  List<VoucherInfoModel> get expiredVouchers =>
      availableVouchers.where((v) => v.isExpired).toList();

  VoucherInfoModel? findVoucherById(String voucherId) {
    try {
      return availableVouchers.firstWhere((v) => v.id == voucherId);
    } catch (_) {
      return null;
    }
  }

  // Actions
  Future<void> refreshData() async {
    await Future.wait([
      fetchAllVouchers(),
      fetchUserPoints(),
    ]);
  }

  void navigateToVoucherDetail(VoucherInfoModel voucher) {
    Get.to(() => VoucherDetailView(voucherInfo: voucher));
  }

  // Helpers
  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'food': return Iconsax.cake;
      case 'drinks': return Iconsax.coffee;
      case 'shopping': return Iconsax.shopping_bag;
      case 'entertainment': return Iconsax.game;
      case 'travel': return Iconsax.airplane;
      case 'health': return Iconsax.heart;
      case 'beauty': return Iconsax.brush_1;
      case 'education': return Iconsax.book_1;
      case 'fitness': return Iconsax.weight;
      case 'electronics': return Iconsax.mobile;
      default: return Iconsax.gift;
    }
  }

  // User points getters
  double get currentPoints => userPoints.value?.availablePoints ?? 0;
  bool get hasPointsError => pointsError.value.isNotEmpty;
}

extension StringExtensions on String {
  bool equalsIgnoreCase(String other) =>
      toLowerCase() == other.toLowerCase();
}