import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart%20';
import 'package:get_storage/get_storage.dart';
import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
import 'package:wastenot/data/repositories/points/points_repo.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/model/user_point_model.dart';
import 'package:wastenot/utils/https/network_manager.dart';
import 'package:wastenot/utils/popups/loaders.dart';

class UserPointController extends GetxController {
  static UserPointController get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GetStorage _localStorage = GetStorage();

  final AuthenticationRepository _authRepo = Get.put(AuthenticationRepository());

  final PointRepository _pointsRepo = Get.put(PointRepository());

  final Rx<UserPoint?> userPoints = Rx<UserPoint?>(null);

  static const String _firstTimeClaimKey = 'first_time_claim';

  @override
  void onInit(){
    super.onInit();
    fetchUserPoint();
  }


  // Method to check if user has claimed points for the first time
  bool isFirstTimeUser() {
    try {
      // Get current user ID
      final userId = _authRepo.authUser?.uid;
      if (userId == null) return false;

      // Check if the user has claimed points before using local storage
      final key = _firstTimeClaimKey + userId;
      return !(_localStorage.read(key) ?? false);
    } catch (e) {
      // In case of error, assume not first time to avoid duplicate bonuses
      return false;
    }
  }

  // Mark user as having claimed points
  void markUserClaimedPoints() {
    final userId = _authRepo.authUser?.uid;
    if (userId != null) {
      final key = _firstTimeClaimKey + userId;
      _localStorage.write(key, true);
    }
  }


  // Method to update user points when claiming from QR scan
  Future<void> updateUserPoints(int pointsToAdd) async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        throw "No internet connection. Please try again when connected.";
      }

      // Get current user ID
      final userId = _authRepo.authUser?.uid;
      if (userId == null) {
        throw "User not authenticated";
      }

      // Check if this is the user's first time claiming points using local storage
      final firstTimeUser = isFirstTimeUser();

      // Apply first-time bonus if applicable
      final double bonusPoints = firstTimeUser ? 10 : 0;
      final double totalPointsToAdd = pointsToAdd + bonusPoints;

      // Get user's existing points data
      UserPoint? existingUserPoint;
      try {
        existingUserPoint = await _pointsRepo.getUserPoints(userId);
        print("printing exsiting Point ${existingUserPoint}");
      } catch (e) {
        // Handle error but continue execution
        print("Error fetching existing points: $e");
      }

      if (existingUserPoint == null) {
        // First time creating points record in database
        final newUserPoint = UserPoint(
          pointId: _db.collection("User Points").doc().id, // Generate new ID
          totalEarned: totalPointsToAdd,
          totalRedeemed: 0,
          availablePoints: totalPointsToAdd,
          lastUpdate: Timestamp.now(),
          userId: userId,
        );

        // Save new user point record
        await _pointsRepo.saveUserPoint(newUserPoint);
      } else {

        // User already has a points record, update it
        final updatedUserPoint = UserPoint(
          pointId: existingUserPoint.pointId,
          totalEarned: existingUserPoint.totalEarned + totalPointsToAdd,
          availablePoints: existingUserPoint.availablePoints + totalPointsToAdd,
          lastUpdate: Timestamp.now(),
          userId: userId
        );

        // Update existing user point record
        await _pointsRepo.updateUserPoint(updatedUserPoint);
      }

      // Mark that user has claimed points (for first-time check)
      if (firstTimeUser) {
        markUserClaimedPoints();
      }

      // Show different success message based on whether bonus was applied
      if (firstTimeUser) {
        WNLoaders.successSnackBar(
            title: 'First-time Bonus!',
            message: 'You earned $pointsToAdd points + 10 bonus points!'
        );
      } else {
        // WNLoaders.successSnackBar(
        //     title: 'Points Added',
        //     message: 'You earned $pointsToAdd points!'
        // );
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // Fetch user points
  Future<void> fetchUserPoint() async{
    try{
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        throw "No internet connection. Please try again when connected.";
      }

      // Get current user ID
      final userId = _authRepo.authUser?.uid;
      if (userId == null) {
        throw "User not authenticated";
      }

      final point = await _pointsRepo.getUserPoints(userId);
      userPoints.value = point;

    }catch(e){
      throw e.toString();
    }
  }

}