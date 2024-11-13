import 'package:flutter/material.dart';
import 'package:outfitter/Authentication/Login.dart';
import 'package:outfitter/Screens/Orders.dart';
import 'package:outfitter/Screens/WishList.dart';
import 'package:outfitter/utils/CustomAppBar1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomApp(title: 'Profile', w: w),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),

                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    'assets/Passphoto.png',
                    width: w * 0.2,
                    height: h * 0.1,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: w * 0.04),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Prashanth Chary',
                            style: TextStyle(
                              color: Color(0xff110B0F),
                              fontFamily: 'RozhaOne',
                              fontSize: 16,
                              height: 21 / 16,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Image.asset(
                            'assets/edit.png',
                            width: w * 0.09,
                            height: h * 0.02,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.01),
                      Row(
                        children: [
                          Image.asset(
                            'assets/call.png',
                            width: w * 0.09,
                            height: h * 0.02,
                            color: Color(0xff617C9D),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 4), // Add some spacing
                          Text(
                            '+91 98564 56321',
                            style: TextStyle(
                              color: Color(0xff617C9D),
                              fontFamily: 'RozhaOne',
                              fontSize: 16,
                              height: 21 / 16,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.01),
                      Row(
                        children: [
                          Image.asset(
                            'assets/mail.png',
                            width: w * 0.09,
                            height: h * 0.02,
                            color: Color(0xff617C9D),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 4), // Add some spacing
                          Text(
                            'acchu.g@gmail.com',
                            style: TextStyle(
                              color: Color(0xff617C9D),
                              fontFamily: 'RozhaOne',
                              fontSize: 16,
                              height: 21 / 16,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: h*0.06,),
            InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Orders()));
            },
              child: Row(
                children: [
                Image.asset(
                  "assets/orders.png",
                  width: 24,
                  height: 24,
                  color: Color(0xff110B0F),
                  fit: BoxFit.contain,
                ),
                  SizedBox(width: w*0.03),
                  Text(
                    'Orders',
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      height: 19 / 16,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                ],),
            ),
            SizedBox(height: h*0.02,),
            DashedLine(width: w, height: 1.0),
            SizedBox(height: h*0.02,),
            InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Wishlist()));
            },
              child: Row(
                children: [
                  Image.asset(
                    "assets/fav.png",
                    width: 24,
                    height: 24,
                    color: Color(0xff110B0F),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: w*0.03),
                  Text(
                    'Wishlist',
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      height: 19 / 16,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                ],),
            ),
            SizedBox(height: h*0.02,),
            DashedLine(width: w, height: 1.0),
            SizedBox(height: h*0.02,),
            Row(
              children: [
                Image.asset(
                  "assets/notification.png",
                  width: 24,
                  height: 24,
                  color: Color(0xff110B0F),
                  fit: BoxFit.contain,
                ),
                SizedBox(width: w*0.03),
                Text(
                  'Notifications',
                  style: TextStyle(
                    color: Color(0xff110B0F),
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    height: 19 / 16,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

              ],),
            SizedBox(height: h*0.02,),
            DashedLine(width: w, height: 1.0),
            SizedBox(height: h*0.02,),
            Row(
              children: [
                Image.asset(
                  "assets/history.png",
                  width: 24,
                  height: 24,
                  color: Color(0xff110B0F),
                  fit: BoxFit.contain,
                ),
                SizedBox(width: w*0.03),
                Text(
                  'Payment Methods',
                  style: TextStyle(
                    color: Color(0xff110B0F),
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    height: 20 / 15,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

              ],),
            SizedBox(height: h*0.02,),
            DashedLine(width: w, height: 1.0),
            SizedBox(height: h*0.02,),
            Row(
              children: [
                Image.asset(
                  "assets/address.png",
                  width: 24,
                  height: 24,
                  color: Color(0xff110B0F),
                  fit: BoxFit.contain,
                ),
                SizedBox(width: w*0.03),
                Text(
                  'Address',
                  style: TextStyle(
                    color: Color(0xff110B0F),
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    height: 19 / 16,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

              ],),
            SizedBox(height: h*0.02,),
            DashedLine(width: w, height: 1.0),
            SizedBox(height: h*0.02,),
            Row(
              children: [
                Image.asset(
                  "assets/helpsupport.png",
                  width: 24,
                  height: 24,
                  color: Color(0xff110B0F),
                  fit: BoxFit.contain,
                ),
                SizedBox(width: w*0.03),
                Text(
                  'Help & Support',
                  style: TextStyle(
                    color: Color(0xff110B0F),
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    height: 19 / 16,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

              ],),
            SizedBox(height: h*0.02,),
            DashedLine(width: w, height: 1.0),
            SizedBox(height: h*0.02,),
            Row(
              children: [
                Image.asset(
                  "assets/Settings.png",
                  width: 24,
                  height: 24,
                  color: Color(0xff110B0F),
                  fit: BoxFit.contain,
                ),
                SizedBox(width: w*0.03),
                Text(
                  'Settings',
                  style: TextStyle(
                    color: Color(0xff110B0F),
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    height: 20 / 15,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

              ],),
            SizedBox(height: h*0.02,),
            DashedLine(width: w, height: 1.0),
            Spacer(),
            InkResponse(onTap: () async{
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.remove('token');
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

            },
              child: Row(
                children: [
                  Image.asset(
                    "assets/logout.png",
                    width: 24,
                    height: 24,
                    color: Color(0xffED1C24),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: w*0.03),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: Color(0xffED1C24),
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      height: 20 / 15,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                ],),
            ),
            SizedBox(height: h*0.02,),
          ],
        ),
      ),
    );
  }
}
