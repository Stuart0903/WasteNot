import 'package:get/get.dart';
import 'package:wastenot/data/repositories/authentication/auth_repo.dart';
import 'package:wastenot/utils/https/network_manager.dart';
import 'package:wastenot/utils/popups/full_screenLoader.dart';
import 'package:wastenot/utils/popups/loaders.dart';

/// Controller to manage settings and related functionality
class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  final _authRepo = AuthenticationRepository.instance;

  /// Logout user - using the existing logout method in AuthRepository
  Future<void> logout() async {
    try {
      // Show loading indicator
      // WNFullScreenLoader.openLoadingDialog('Logging out...', 'logout_animation');

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove loader
        WNFullScreenLoader.stopLoading();
        // Show error message
        WNLoaders.errorSnackBar(
          title: 'No Internet Connection',
          message: 'Check your internet connection and try again.',
        );
        return;
      }

      // Call logout from auth repository
      // Note: The existing implementation already handles navigation to LoginView
      await _authRepo.logout();

      // Remove loader
      WNFullScreenLoader.stopLoading();

      // Note: We don't need to navigate again since AuthRepo.logout() already does this
      // Also don't need success message as the user will already be on the login screen

    } catch (e) {
      // Remove loader
      WNFullScreenLoader.stopLoading();

      // Show error message
      WNLoaders.errorSnackBar(
        title: 'Logout Failed',
        message: e.toString(),
      );
    }
  }
}