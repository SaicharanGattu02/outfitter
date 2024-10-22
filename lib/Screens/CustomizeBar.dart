import 'package:flutter/material.dart';
import 'package:outfitter/Screens/BackBodyCustomize.dart';
import 'package:outfitter/Screens/CollerTypeCustomize.dart';
import 'package:outfitter/Screens/CuffTypeCustomize.dart';
import 'package:outfitter/Screens/PocketTypeCustomize.dart';
import 'package:outfitter/utils/CustomAppBar.dart';

class CustomizeProductBar extends StatefulWidget {
  const CustomizeProductBar({super.key});

  @override
  State<CustomizeProductBar> createState() => _CustomizeProductBarState();
}

class _CustomizeProductBarState extends State<CustomizeProductBar>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  late PageController _pageController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey, w: w),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            height: h * 0.04,
            decoration: BoxDecoration(color: Color(0xffE7C6A0)),
            child: Center(
              child: Text(
                "Available until 10hrs 30mins 20secs",
                style: TextStyle(
                  color: Color(0xff110B0F),
                  fontFamily: 'RozhaOne',
                  fontSize: 16,
                  height: 20 / 16,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            height: h * 0.14,
            decoration: BoxDecoration(color: Color(0xffFCFCFD)),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(onTap:(){
                      Navigator.pop(context);
    },
                        child: Icon(Icons.arrow_back_outlined, size: 24)),
                    SizedBox(width: w * 0.02),
                    Text(
                      "Regular Fit Poplin shirt",
                      style: TextStyle(
                        color: Color(0xff110B0F),
                        fontFamily: 'RozhaOne',
                        fontSize: 24,
                        height: 32 / 24,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: h * 0.02),
                Row(
                  children: [
                    Text(
                      "₹17.65",
                      style: TextStyle(
                        color: Color(0xffF04438),
                        fontFamily: 'RozhaOne',
                        fontSize: 16,
                        height: 24 / 16,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Color(0xffF04438),
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: w * 0.01),
                    Text(
                      "₹7.65",
                      style: TextStyle(
                        color: Color(0xff4B5565),
                        fontFamily: 'RozhaOne',
                        fontSize: 16,
                        height: 28 / 16,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(index < 4 ? Icons.star : Icons.star_border,
                            color: Color(0xffF79009), size: 20);
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: w,
            decoration: BoxDecoration(color: Color(0xffffffff)),
            child: TabBar(
              indicatorColor: Color(0xffffffff),
              indicatorWeight: 0.1,
              dividerColor: Colors.transparent,
              padding: EdgeInsets.zero,
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelPadding: EdgeInsets.symmetric(horizontal: w * 0.0082),
              labelStyle: TextStyle(
                fontFamily: 'RozhaOne',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                height: 1.6,
                color: Color(0xff110B0F),
                letterSpacing: 0.15,
              ),
              unselectedLabelStyle: TextStyle(
                fontFamily: 'RozhaOne',
                fontWeight: FontWeight.w400,
                color: Color(0xff617C9D),
                fontSize: 15,
                height: 1.6,
                letterSpacing: 0.15,
              ),
              tabs: List.generate(4, (index) {
                return Container(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  height: h * 0.03,
                  color: _selectedTabIndex == index
                      ? Color(0xffE7C6A0)
                      : Colors.transparent,
                  child: Tab(
                    child: Center(
                      child: Text(
                        index == 0
                            ? 'Collar'
                            : index == 1
                                ? 'Cuff Type'
                                : index == 2
                                    ? 'Placket Type'
                                    : 'Back Body',
                      ),
                    ),
                  ),
                );
              }),
              onTap: (index) {
                FocusScope.of(context).unfocus();
                _pageController.jumpToPage(index);
                setState(() {
                  _selectedTabIndex = index; // Update selected tab index
                });
              },
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                CollerTypeCustomize(),
                CuffTypeCustomize(),
                PocketTypeCustomize(),
                BackBodyCustomize(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
