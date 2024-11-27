import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outfitter/Authentication/Login.dart';
import 'package:outfitter/Authentication/Register.dart';
import 'package:outfitter/Screens/dashbord.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;
import '../providers/ConnectivityService.dart';
import '../Services/otherservices.dart';
import '../utils/Preferances.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String token = "";
  // List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  // var isDeviceConnected = "";

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityService>(context, listen: false).initConnectivity();
    // initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    fetchDetails();
  }

  @override
  void dispose() {
    Provider.of<ConnectivityService>(context, listen: false).dispose();
    super.dispose();
  }

  // Future<void> initConnectivity() async {
  //   List<ConnectivityResult> result;
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     developer.log('Couldn\'t check connectivity status', error: e);
  //     return;
  //   }
  //
  //   if (!mounted) {
  //     return Future.value(null);
  //   }
  //
  //
  //   return _updateConnectionStatus(result);
  // }
  //
  // Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
  //   setState(() {
  //     _connectionStatus = result;
  //     for (int i = 0; i < _connectionStatus.length; i++) {
  //       setState(() {
  //         isDeviceConnected = _connectionStatus[i].toString();
  //         // print("isDeviceConnected:${isDeviceConnected}");
  //       });
  //     }
  //   });
  //   // print('Connectivity changed: $_connectionStatus');
  // }



  fetchDetails() async {
    final Token = await PreferenceService().getString("token") ?? "";
    print("Token>>>${Token}");
    setState(() {
      token = Token;
    });

    // Wait for 2 seconds before navigating
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => (token.isEmpty) ? Login() : Dashbord(),
        ),
      );
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => Register(),
      //   ),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final _connectivityService = Provider.of<ConnectivityService>(context);
    return    (_connectivityService.isDeviceConnected == "ConnectivityResult.wifi" ||
        _connectivityService.isDeviceConnected == "ConnectivityResult.mobile")
        ?
      Scaffold(

      body: Center(
        child: Container(

          width: w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/SplashSuit.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Image.asset(
              "assets/OutfiterText.png",color: Color(0xffE7C6A033),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    ): NoInternetWidget();
  }
}
