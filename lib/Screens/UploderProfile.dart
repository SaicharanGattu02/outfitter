import 'package:flutter/material.dart';

class UploaderProfile extends StatefulWidget {
  const UploaderProfile({super.key});

  @override
  State<UploaderProfile> createState() => _UploaderProfileState();
}

class _UploaderProfileState extends State<UploaderProfile> {
  final List<Map<String, String>> grid = [
    {"image": 'assets/hoodie.png'},
    {"image": 'assets/jeans.png'},
    {"image": 'assets/sleaves.png'},
    {"image": 'assets/cargo.png'},
    {"image": 'assets/shirt.png'},
    {"image": 'assets/formals.png'},
    {"image": 'assets/polo.png'},
    {"image": 'assets/trousar.png'},
  ];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff110B0F),
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_outlined,
          color: Color(0xffffffff),
          size: 18,
        ),
        title: Text(
          "Back",
          style: TextStyle(
            color: Color(0xffFFFFFF),
            fontFamily: 'RozhaOne',
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset(
              "assets/share.png",
              width: 24,
              height: 24,
              color: Color(0xffE7C6A0),
            ),
          ),
        ],
        backgroundColor: Color(0xff110B0F),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/postedBY.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: w * 0.03),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shravya-098",
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontFamily: 'RozhaOne',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "shravya.g@gmail.com",
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontFamily: 'RozhaOne',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0x4DFFFFFF),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.asset(
                          "assets/youtube.png",
                          color: Color(0xffffffff),
                          width: 24,
                          height: 24,
                        ),
                      ),
                      SizedBox(width: w * 0.02),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0x4DFFFFFF),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.asset(
                          "assets/insta.png",
                          color: Color(0xffffffff),
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            '726',
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontFamily: 'RozhaOne',
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Designs',
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontFamily: 'RozhaOne',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: h * 0.06,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xffF8F8F8), width: 0.1)),
                      ),
                      Column(
                        children: [
                          Text(
                            '564',
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontFamily: 'RozhaOne',
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Following',
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontFamily: 'RozhaOne',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: h * 0.06,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xffF8F8F8), width: 0.1)),
                      ),
                      Column(
                        children: [
                          Text(
                            '1208',
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontFamily: 'RozhaOne',
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'follower',
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontFamily: 'RozhaOne',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: w * 0.08),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color(0xffE7C6A0),
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                          child: Text(
                            "FOLLOW",
                            style: TextStyle(
                              color: Color(0xff110B0F),
                              fontFamily: 'RozhaOne',
                              fontSize: 16,
                              height: 21.06 / 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: h * 0.7,
              width: w,
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Gallery(726)",
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'RozhaOne',
                      fontSize: 24,
                      height: 32 / 24,
                      fontWeight: FontWeight.w400,
                    ),

                  ),
                  Expanded(
                    child: GridView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: grid.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Stack(
                              children: [
                                InkResponse(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => Home(),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xffEEF2F6),
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Container(
                                            child: Image.asset(
                                              grid[index]['image']!,
                                              fit: BoxFit.contain,
                                              width: w * 0.3,
                                              height: h * 0.2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Color(0xffFFE5E6),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Image.asset(
                                      "assets/favLove.png",
                                      width: 18,
                                      height: 18,
                                      fit: BoxFit.contain,
                                      color: Color(0xffFF3B30),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
