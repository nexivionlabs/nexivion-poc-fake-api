import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

/// Service for checking network connectivity
@lazySingleton
class NetworkChecker {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<bool>? _connectivitySubscription;

  /// Check if device has internet connection
  Future<bool> get hasConnection async {
    try {
      final result = await _connectivity.checkConnectivity();
      log('NetworkChecker: Current connectivity: $result');

      // Connectivity result is a list in newer versions
      return result.isNotEmpty &&
             !result.contains(ConnectivityResult.none);
    } catch (e) {
      log('NetworkChecker: Error checking connectivity - $e');
      return false;
    }
  }

  /// Listen to connectivity changes
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map((results) {
      final isConnected = results.isNotEmpty &&
                         !results.contains(ConnectivityResult.none);
      log('NetworkChecker: Connectivity changed - Connected: $isConnected');
      return isConnected;
    });
  }

  /// Start listening to connectivity changes
  void startListening(Function(bool isConnected) onChanged) {
    _connectivitySubscription = onConnectivityChanged.listen(onChanged);
  }

  /// Stop listening to connectivity changes
  void dispose() {
    _connectivitySubscription?.cancel();
  }
}
