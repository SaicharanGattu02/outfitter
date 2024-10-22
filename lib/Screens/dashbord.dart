import 'package:flutter/material.dart';
import 'package:outfitter/Screens/Cart.dart';
import 'package:outfitter/Screens/Category.dart';
import 'package:outfitter/Screens/DashHome.dart';
import 'package:outfitter/Screens/Orders.dart';
import 'package:outfitter/Screens/Profile.dart';
import 'package:outfitter/Screens/WishList.dart';

class Dashbord extends StatefulWidget {
  const Dashbord({super.key});

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Widget> _screens = [DashHome(), Cart(), Category()];
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

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[Container()],
        toolbarHeight: 50,
        backgroundColor: const Color(0xff110B0F),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              InkResponse(
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/menu.png",
                      color: Color(0xffE7C6A0),
                      width: 24,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 12),
                    Image.asset(
                      "assets/OutfiterText.png",
                      width: w * 0.35,
                      fit: BoxFit.contain,
                      color: Color(0xffE7C6A0),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                children: [

                  if (_selectedIndex == 1)
                    ...[InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Orders()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child:

                        Image.asset(
                          "assets/orders.png",
                          width: 28,
                          height: 28,
                          color: Color(0xffffffff),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),]
                  else ...[
                    InkWell(
                      onTap: () {
                        // Handle search icon tap
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/search.png",
                          width: 28,
                          height: 28,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],

                  SizedBox(width: w * 0.025),
                  if (_selectedIndex == 1)
                    ...[InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Wishlist()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/fav.png",
                          width: 28,
                          height: 28,
                          color: Color(0xffffffff),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),]
                  else ...[
                    InkWell(
                      onTap: () {
                        // Handle notifications icon tap
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/notification.png",
                          width: 28,
                          height: 28,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(width: w * 0.025),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: ClipOval(
                        child: CircleAvatar(
                          radius: w * 0.038,
                          child: Image.asset(
                            "assets/Passphoto.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: _screens,
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
                'assets/cart.png',
                width: 25,
                height: 25,
                color: _selectedIndex == 1
                    ? const Color(0xFFE7C6A0)
                    : const Color(0xFF617C9D),
              ),
              label: 'CART',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/shop.png',
                width: 25,
                height: 25,
                color: _selectedIndex == 2
                    ? const Color(0xFFE7C6A0)
                    : const Color(0xFF617C9D),
              ),
              label: 'SHOP',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/category.png',
                width: 25,
                height: 25,
                color: _selectedIndex == 3
                    ? const Color(0xFFE7C6A0)
                    : const Color(0xFF617C9D),
              ),
              label: 'CATEGORY',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: onTabTapped, // Change the selected tab
        ),
      ),
    );
  }
}
