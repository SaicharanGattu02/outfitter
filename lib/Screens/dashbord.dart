import 'package:flutter/material.dart';

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

  final List<Map<String, String>> gridList = [
    {"image": 'assets/hoodie.png', 'name': 'HOODIE'},
  ];

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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.5,
                ),
                itemCount: gridList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xffEEF2F6), width: 1)),
                            child: Center(
                              child: Image.asset(gridList[index]['image']!),
                            ),
                          ),
                          Positioned(
                              child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Color(0xffFFE5E6),
                                borderRadius: BorderRadius.circular(100)),
                            child: Image.asset(
                              "assets/fav.png",
                              fit: BoxFit.contain,
                              color: Color(0xff000000),
                            ),
                          ))
                        ],
                      )
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
