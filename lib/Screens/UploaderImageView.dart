import 'package:flutter/material.dart';

import 'Profile.dart';

class UploaderImageView extends StatefulWidget {
  const UploaderImageView({super.key});

  @override
  State<UploaderImageView> createState() => _UploaderImageViewState();
}

class _UploaderImageViewState extends State<UploaderImageView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
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
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(color: Color(0xff110B0F)),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Color(
                    0xffffffff,
                  ),
                ),
                CircleAvatar(
                  radius: 18,
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
                )
              ],
            ),
          ),
          Stack(
            children: [
              InkResponse(
                onTap: () {
                  // Handle tap event
                },
                child: Container(
                  height: h * 0.72,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(color: Color(0xffF2F2F2)),
                  child: Center(
                    child: Image.asset(
                      'assets/shirt.png',
                      fit: BoxFit.contain,
                      height: h * 0.46,
                      width: w * 15,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: h * 0.3,
                left: 8,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    // Handle left arrow tap
                  },
                ),
              ),
              Positioned(
                top: h * 0.3,
                right: 8,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    // Handle right arrow tap
                  },
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xff34C759).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Image.asset(
                        "assets/chat-alt-2.png",
                        width: 22,
                        height: 22,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 12,
                left: w*0.3,
                child: Center(
                  child: Row(

                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              "assets/fav.png",
                              width: 22,
                              height: 22,
                              color: Color(0xff121926),
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: h * 0.001,
                          ),
                          Text(
                            "2.3k",
                            style: TextStyle(
                              color: Color(0xff4B5565),
                              fontFamily: 'RozhaOne',
                              fontSize: 14,
                              height: 19 / 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: w * 0.04,
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              "assets/cmnt.png",
                              width: 22,
                              height: 22,
                              color: Color(0xff121926),
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: h * 0.001,
                          ),
                          Text(
                            "1.2k",
                            style: TextStyle(
                              color: Color(0xff4B5565),
                              fontFamily: 'RozhaOne',
                              fontSize: 16,
                              height: 21.06 / 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: w * 0.04,
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              "assets/share.png",
                              width: 22,
                              height: 22,
                              color: Color(0xff121926),
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: h * 0.001,
                          ),
                          Text(
                            "849",
                            style: TextStyle(
                              color: Color(0xff4B5565),
                              fontFamily: 'RozhaOne',
                              fontSize: 16,
                              height: 21.06 / 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: h * 0.05,
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xff110B0F),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            "SHOP",
            style: TextStyle(
              color: Color(0xffCAA16C),
              fontFamily: 'RozhaOne',
              fontSize: 16,
              height: 21.06 / 16,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
