import 'package:get/get.dart';
import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
import 'package:wastenot/data/repositories/points/points_repo.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/model/user_point_model.dart';

class UserPointsController extends GetxController {
  static UserPointsController get instance => Get.find();

  final _userPointsRepo = Get.put(PointRepository());
  final AuthenticationRepository _authRepo = Get.put(AuthenticationRepository());

  final Rx<UserPoint?> userPoints = Rx<UserPoint?>(null);
  final RxString error = ''.obs;
  final RxBool isLoading = false.obs;


  Future<void> fetchUserPoints(String userId) async {
    try {
      isLoading.value = true;
      error.value = '';

      final points = await _userPointsRepo.getUserPoints(userId);
      userPoints.value = points;

      if (points == null) {
        error.value = 'No points data found';
      }
    } catch (e) {
      error.value = e.toString();
      userPoints.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshUserPoints(String userId) async {
    await fetchUserPoints(userId);
  }

  double get currentPoints => userPoints.value?.availablePoints ?? 0;
}