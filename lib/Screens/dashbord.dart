import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outfitter/Screens/Cart.dart';
import 'package:outfitter/Screens/Category.dart';
import 'package:outfitter/Screens/DashHome.dart';
import 'package:outfitter/Screens/Profile.dart';
import 'package:outfitter/Screens/WishList.dart';
import 'dart:developer' as developer;

import '../Services/otherservices.dart';
import 'ProdcutListScreen.dart';


class Dashbord extends StatefulWidget {
  const Dashbord({super.key});

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  // final ConnectivityService connectivityService = ConnectivityService();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Widget> _screens = [DashHome(), WishlistScreen(),Category(), Profile()];
  final PageController _pageController = PageController();

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController
        .dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }



  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
 @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }


  var isDeviceConnected = "";

  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();

  Future<void> initConnectivity() async {
    List<ConnectivityResult> result;
    try {

      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }


    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
      for (int i = 0; i < _connectionStatus.length; i++) {
        setState(() {
          isDeviceConnected = _connectionStatus[i].toString();
          print("isDeviceConnected:${isDeviceConnected}");
        });
      }
    });
    print('Connectivity changed: $_connectionStatus');
  }



  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return  WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return Future.value(false); // Return false to prevent the default back navigation
      },
      child: (isDeviceConnected == "ConnectivityResult.wifi" ||
          isDeviceConnected == "ConnectivityResult.mobile")
          ?
      Scaffold(
        key: _scaffoldKey,
        body: PageView(
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: _screens,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -1),
                blurRadius: 10,
                color: (_selectedIndex != 0)
                    ? Colors.grey.withOpacity(0.5)
                    : Colors.grey.withOpacity(0),
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFFE7C6A0),
            unselectedItemColor: const Color(0xFF617C9D),
            selectedFontSize: 12.0,
            unselectedFontSize: 9.0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/home.png',
                  width: 25,
                  height: 25,
                  color: _selectedIndex == 0
                      ? const Color(0xFFE7C6A0)
                      : const Color(0xFF617C9D),
                ),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/fav.png',
                  width: 25,
                  height: 25,
                  color: _selectedIndex == 1
                      ? const Color(0xFFE7C6A0)
                      : const Color(0xFF617C9D),
                ),
                label: 'WISH LIST',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/category.png',
                  width: 25,
                  height: 25,
                  color: _selectedIndex == 2
                      ? const Color(0xFFE7C6A0)
                      : const Color(0xFF617C9D),
                ),
                label: 'CATEGORY',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.person_outline_rounded,
                  size: 25,
                    color: _selectedIndex == 3
                        ? const Color(0xFFE7C6A0)
                        : const Color(0xFF617C9D),),

                label: 'PROFILE',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: onTabTapped, // Change the selected tab
          ),
        ),
      ): NoInternetWidget(),
    );
  }
}
