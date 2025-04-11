import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:wastenot/utils/popups/loaders.dart';

/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final RxList<ConnectivityResult> _connectionStatus = <ConnectivityResult>[].obs;
  Timer? _periodicCheckTimer;
  bool _isConnected = true;

  /// Initialize the network manager and set up a stream to continually check the connection status.
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    startPeriodicCheck();
  }

  /// Update the connection status based on changes in connectivity and show a relevant popup for no internet connection.
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus.value = result;
    if (result.contains(ConnectivityResult.none)) {
      _isConnected = false;
      showNoInternetSnackbar();
    } else if (!_isConnected) {
      _isConnected = true;
      hideNoInternetSnackbar();
    }
  }

  /// Start a periodic check for internet connectivity every 10 seconds.
  void startPeriodicCheck() {
    _periodicCheckTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      final hasInternet = await isConnected(); // Renamed the local variable
      if (!hasInternet && _isConnected) {
        _isConnected = false;
        showNoInternetSnackbar();
      } else if (hasInternet && !_isConnected) {
        _isConnected = true;
        hideNoInternetSnackbar();
      }
    });
  }

  /// Show a persistent snackbar when there's no internet connection.
  void showNoInternetSnackbar() {
    Get.rawSnackbar(
      message: 'No Internet Connection',
      isDismissible: false,
      duration: const Duration(days: 1), // Keep it visible until internet is restored
      backgroundColor: Colors.red,
      icon: const Icon(Icons.wifi_off, color: Colors.white),
      snackPosition: SnackPosition.TOP,
    );
  }

  /// Hide the no internet snackbar when the connection is restored.
  void hideNoInternetSnackbar() {
    Get.closeCurrentSnackbar();
  }

  /// Check the internet connection status.
  /// Returns `true` if connected, `false` otherwise.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return !result.contains(ConnectivityResult.none);
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Dispose or close the active connectivity stream and cancel the timer.
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
    _periodicCheckTimer?.cancel();
  }
}