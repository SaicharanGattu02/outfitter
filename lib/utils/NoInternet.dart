// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
//
// class ConnectivityService {
//   static ConnectivityService? _instance;
//   Connectivity? _connectivity;
//   bool _isConnected = true;
//   final ValueNotifier<bool> connectivityNotifier = ValueNotifier(true);
//
//   // Singleton pattern to ensure only one instance of ConnectivityService exists.
//   ConnectivityService._internal() {
//     _connectivity = Connectivity();
//     // Listen to connectivity changes (single ConnectivityResult, not a List)
//     _connectivity!.onConnectivityChanged.listen(_updateConnectivityStatus);
//   }
//
//   factory ConnectivityService() {
//     _instance ??= ConnectivityService._internal();
//     return _instance!;
//   }
//
//   // Method to check the initial connectivity status when the app starts
//   Future<void> checkConnectivity() async {
//     ConnectivityResult result = await _connectivity!.checkConnectivity();
//     _updateConnectivityStatus(result);
//   }
//
//   // Callback method to handle connectivity changes
//   void _updateConnectivityStatus(ConnectivityResult result) {
//     bool isConnected = result != ConnectivityResult.none;
//
//     // If connectivity status has changed, update the notifier
//     if (_isConnected != isConnected) {
//       _isConnected = isConnected;
//       connectivityNotifier.value = isConnected;
//     }
//   }
//
//   bool get isConnected => _isConnected;
// }
