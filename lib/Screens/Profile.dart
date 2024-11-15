import 'package:flutter/material.dart';
import 'package:outfitter/Authentication/Login.dart';
import 'package:outfitter/Screens/AddressList.dart';
import 'package:outfitter/Screens/Edit%20Profile%20screeen.dart';
import 'package:outfitter/Screens/OrderList.dart';
import 'package:outfitter/Screens/Orders.dart';
import 'package:outfitter/Screens/WishList.dart';
import 'package:outfitter/utils/CustomAppBar1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/UserDetailsModel.dart';
import '../Services/UserApi.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserDetailsModel? userDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      var data = await Userapi.getUserdetsils();
      setState(() {
        userDetails = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error appropriately, e.g., show a toast or dialog
      print('Error fetching user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomApp(title: 'Profile', w: w),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : userDetails == null
            ? Center(child: Text('Failed to load profile'))
            : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: (userDetails?.data?.image != null && userDetails!.data!.image!.isNotEmpty)
                      ? Image.network(
                    userDetails!.data!.image!,
                    width: w * 0.2,
                    height: h * 0.1,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to show the first letter of the name if the image fails to load
                      return _buildNamePlaceholder(userDetails?.data?.fullName, w, h);
                    },
                  )
                      : _buildNamePlaceholder(userDetails?.data?.fullName, w, h),
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
                            userDetails!.data?.fullName ?? 'No Name',
                            style: TextStyle(
                              color: const Color(0xff110B0F),
                              fontFamily: 'RozhaOne',
                              fontSize: 16,
                              height: 21 / 16,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditProfileScreen()),
                              );
                            },
                            child: Image.asset(
                              'assets/edit.png',
                              width: w * 0.09,
                              height: h * 0.02,
                              fit: BoxFit.contain,
                            ),
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
                            color: const Color(0xff617C9D),
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            userDetails!.data?.mobile ?? '+91 XXXXXX',
                            style: TextStyle(
                              color: const Color(0xff617C9D),
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
                            color: const Color(0xff617C9D),
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            userDetails!.data?.email ?? 'example@mail.com',
                            style: TextStyle(
                              color: const Color(0xff617C9D),
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
            SizedBox(height: h * 0.06),
            // Menu Items (Orders, Wishlist, etc.)
            _buildMenuItem(
              context,
              iconPath: "assets/orders.png",
              label: 'Orders',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderListScreen()),
                );
              },
            ),
            _buildDivider(h),
            _buildMenuItem(
              context,
              iconPath: "assets/fav.png",
              label: 'Wishlist',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WishlistScreen()),
                );
              },
            ),
            _buildDivider(h),
            _buildMenuItem(
              context,
              iconPath: "assets/notification.png",
              label: 'Notifications',
            ),
            _buildDivider(h),
            _buildMenuItem(
              context,
              iconPath: "assets/history.png",
              label: 'Payment Methods',
            ),
            _buildDivider(h),
            _buildMenuItem(
              context,
              iconPath: "assets/address.png",
              label: 'Address',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressListScreen()),
                );
              },
            ),
            _buildDivider(h),
            _buildMenuItem(
              context,
              iconPath: "assets/helpsupport.png",
              label: 'Help & Support',
            ),
            _buildDivider(h),
            _buildMenuItem(
              context,
              iconPath: "assets/Settings.png",
              label: 'Settings',
            ),
            _buildDivider(h),
            const Spacer(),
            InkResponse(
              onTap: () async {
                SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
                sharedPreferences.remove('token');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Row(
                children: [
                  Image.asset(
                    "assets/logout.png",
                    width: 24,
                    height: 24,
                    color: const Color(0xffED1C24),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: w * 0.03),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: const Color(0xffED1C24),
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      height: 20 / 15,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(height: h * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required String iconPath, required String label, VoidCallback? onTap}) {
    var w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 24,
              height: 24,
              color: const Color(0xff110B0F),
              fit: BoxFit.contain,
            ),
            SizedBox(width: w * 0.03),
            Text(
              label,
              style: TextStyle(
                color: const Color(0xff110B0F),
                fontFamily: 'Poppins',
                fontSize: 16,
                height: 19 / 16,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(double height) {
    return Column(
      children: [
        SizedBox(height: height * 0.02),
        DashedLine(width: MediaQuery.of(context).size.width, height: 1.0),
        SizedBox(height: height * 0.02),
      ],
    );
  }
  Widget _buildNamePlaceholder(String? fullName, double w, double h) {
    // Extract the first letter and convert it to uppercase
    String firstLetter = (fullName != null && fullName.isNotEmpty)
        ? fullName[0].toUpperCase()
        : '?';

    return Container(
      width: w * 0.2,
      height: h * 0.1,
      decoration: BoxDecoration(
        color: Colors.black, // Background color for the square
        borderRadius: BorderRadius.circular(7), // Slightly rounded corners (optional)
      ),
      alignment: Alignment.center,
      child: Text(
        firstLetter,
        style: TextStyle(
          fontSize: 32, // Adjust font size as needed
          color: Color(0xFFE7C6A0), // Text color
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}

