import 'package:flutter/material.dart';
import 'package:outfitter/Screens/Home.dart';

class Dashbord extends StatefulWidget {
  const Dashbord({super.key});

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> grid = [
    {"image": 'assets/hoodie.png', 'name': 'HOODIE'},
    {"image": 'assets/jeans.png', 'name': 'JEANS'},
    {"image": 'assets/sleaves.png', 'name': 'HALF SLEEVES'},
    {"image": 'assets/cargo.png', 'name': 'CARGO'},
    {"image": 'assets/shirt.png', 'name': 'SHIRT'},
    {"image": 'assets/formals.png', 'name': 'FORMALS'},
    {"image": 'assets/polo.png', 'name': 'POLO'},
    {"image": 'assets/trousar.png', 'name': 'TROUSERS'},
  ];

  final List<Map<String, String>> gridmore = [
    {"color": "0xff4CA8D9", "price": "299"},
    {"color": "0xffE98839", "price": "499"},
    {"color": "0xff84B538", "price": "799"},
    {"color": "0xffB9356F", "price": "999"},
  ];

  final List<Map<String, String>> gridList = [
    {"image": 'assets/hoodie.png'},
    {"image": 'assets/hoodie.png'},
    {"image": 'assets/hoodie.png'},
    {"image": 'assets/hoodie.png'},
    {"image": 'assets/hoodie.png'},
  ];

  int _selectedIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,

    // Add more colors as needed
  ];

  List<Color> selectedColors = [];

  void _toggleColorSelection(Color color) {
    setState(() {
      selectedColors.clear();
      selectedColors.add(color);
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null, // Hides the leading icon (for drawer)
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
                  SizedBox(width: w * 0.025),
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
                  SizedBox(width: w * 0.025),
                  InkWell(
                    onTap: () {},
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.asset(
                "assets/SplashSuit.png", // Your image path
                fit: BoxFit.fill,
                width: w,
              ),
            ),
            SizedBox(height: h * 0.05),
            Center(
              child: Text(
                "Shop by Categories",
                style: TextStyle(
                  color: Color(0xff110B0F),
                  fontFamily: 'RozhaOne',
                  fontSize: 24,
                  height: 32 / 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: h * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.55,
                ),
                itemCount: grid.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff110B0F),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Image.asset(
                            grid[index]['image']!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          grid[index]['name']!,
                          style: TextStyle(
                            color: Color(0xff110B0F),
                            fontFamily: 'RozhaOne',
                            fontSize: 14,
                            height: 20 / 14,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: h * 0.02),
            Center(
              child: Text(
                "Best Sellers",
                style: TextStyle(
                  color: Color(0xff110B0F),
                  fontFamily: 'RozhaOne',
                  fontSize: 24,
                  height: 32 / 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: h * 0.02),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.47,
              ),
              itemCount: gridList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        InkResponse(onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffEEF2F6),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.asset(gridList[index]['image']!),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 12,
                                      child: ClipOval(
                                        child: Image.asset(
                                          "assets/postedBY.png",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: w * 0.03,
                                    ),
                                    Text(
                                      "POSTED BY",
                                      style: TextStyle(
                                        color: Color(0xff617C9D),
                                        fontFamily: 'RozhaOne',
                                        fontSize: 14,
                                        height: 19.36 / 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Straight Regular Jeans",
                                  style: TextStyle(
                                    color: Color(0xff121926),
                                    fontFamily: 'RozhaOne',
                                    fontSize: 16,
                                    height: 24 / 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "₹2340.00",
                                      style: TextStyle(
                                        color: Color(0xff121926),
                                        fontFamily: 'RozhaOne',
                                        fontSize: 16,
                                        height: 24 / 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      width: w * 0.03,
                                    ),
                                    Text(
                                      "₹2340.00",
                                      style: TextStyle(
                                        color: Color(0xff617C9D),
                                        fontFamily: 'RozhaOne',
                                        fontSize: 16,
                                        height: 24 / 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: h * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: colors.map((color) {
                                    return GestureDetector(
                                      onTap: () => _toggleColorSelection(color),
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: selectedColors.contains(color)
                                                ? Colors.black
                                                : Colors.transparent,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color:
                                                // selectedColors.contains(color)
                                                //     ?
                                                color,
                                            // : Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xffFFE5E6),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              "assets/fav.png",
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: h * 0.01),
            Center(
              child: Container(
                width: w * 0.35,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Color(0xff110B0F),
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                  child: Text(
                    "SHOW MORE",
                    style: TextStyle(
                      color: Color(0xffE7C6A0),
                      fontFamily: 'RozhaOne',
                      fontSize: 16,
                      height: 21.06 / 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: h * 0.04),
            Center(
              child: Text(
                "Shop by Price",
                style: TextStyle(
                  color: Color(0xff110B0F),
                  fontFamily: 'RozhaOne',
                  fontSize: 24,
                  height: 32 / 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: h * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.6,
                ),
                itemCount: gridmore.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(int.parse(gridmore[index]['color']!)),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Column(
                          children: [
                            Text(
                              "Under",
                              style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontFamily: 'RozhaOne',
                                fontSize: 14,
                                height: 20 / 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 8),
                            Center(
                              child: Text(
                                gridmore[index]['price']!,
                                style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontFamily: 'RozhaOne',
                                  fontSize: 32,
                                  height: 34 / 32,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: h * 0.01),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: Image.asset(
                "assets/Promotional_Banners Mobile.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: h * 0.04),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(top: 24, bottom: 24),
              decoration: BoxDecoration(color: Color(0xffF6F6F6),borderRadius: BorderRadius.circular(6)),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/shipping.png",width: w*0.1,height: h*0.1,),

                  Text(
                    "Fast Shipping",
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'RozhaOne',
                      fontSize: 18,
                      height: 28 / 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: w*0.002,),
                  Text(
                    "We offer Rush and Expedited options if you need it fast",
                    style: TextStyle(
                      color: Color(0xff697586),
                      fontFamily: 'RozhaOne',
                      fontSize: 15,
                      height: 24 / 15,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Image.asset("assets/support.png",width: w*0.1,height: h*0.1,),

                  Text(
                    "24x7 SUPPORT",
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'RozhaOne',
                      fontSize: 18,
                      height: 28 / 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: w*0.002,),
                  Text(
                    "24 hours a day, 7 days a week",
                    style: TextStyle(
                      color: Color(0xff697586),
                      fontFamily: 'RozhaOne',
                      fontSize: 15,
                      height: 24 / 15,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset("assets/card.png",width: w*0.1,height: h*0.1,),

                  Text(
                    "Flexible Payments",
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'RozhaOne',
                      fontSize: 18,
                      height: 28 / 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: w*0.002,),
                  Text(
                    "Pay in a variety of ways",
                    style: TextStyle(
                      color: Color(0xff697586),
                      fontFamily: 'RozhaOne',
                      fontSize: 15,
                      height: 24 / 15,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Image.asset("assets/doller.png",width: w*0.1,height: h*0.1,),

                  Text(
                    "Flexible Returns & Replacements",
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'RozhaOne',
                      fontSize: 18,
                      height: 28 / 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: w*0.002,),
                  Text(
                    "Your satisfaction is important to us",
                    style: TextStyle(
                      color: Color(0xff697586),
                      fontFamily: 'RozhaOne',
                      fontSize: 15,
                      height: 24 / 15,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(right: 8),

                        decoration: BoxDecoration(
                          color: Color(0xffFFE5E6),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.asset(
                          "assets/arrow-sm-up.png",
                          width: 18,
                          height: 18,
                          fit: BoxFit.contain,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),






                ],),

            )
          ],
        ),
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
          selectedItemColor: const Color(0xFFE7C6A0), // Active color
          unselectedItemColor: const Color(0xFF617C9D), // Inactive color
          selectedFontSize: 12.0,
          unselectedFontSize: 9.0,
          showSelectedLabels: true, // Show labels for selected
          showUnselectedLabels: true, // Show labels for unselected
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
                    ? const Color(0xFFE7C6A0) // Active color
                    : const Color(0xFF617C9D), // Inactive color
              ),
              label: 'CART',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/shop.png',
                width: 25,
                height: 25,
                color: _selectedIndex == 2
                    ? const Color(0xFFE7C6A0) // Active color
                    : const Color(0xFF617C9D), // Inactive color
              ),
              label: 'SHOP',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/category.png',
                width: 25,
                height: 25,
                color: _selectedIndex == 3
                    ? const Color(0xFFE7C6A0) // Active color
                    : const Color(0xFF617C9D), // Inactive color
              ),
              label: 'CATEGORY',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: onTabTapped,
        ),
      ),
    );
  }
}
