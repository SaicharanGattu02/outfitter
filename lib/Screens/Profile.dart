import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:outfitter/Screens/AddressList.dart';
import 'package:outfitter/Screens/Edit%20Profile%20screeen.dart';
import 'package:outfitter/Screens/OrderListScreen.dart';
import 'package:outfitter/providers/UserDetailsProvider.dart';
import 'package:outfitter/utils/CustomAppBar.dart';
import 'package:outfitter/utils/CustomAppBar1.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Authentication/Login2.dart';
import '../Model/UserDetailsModel.dart';
import '../utils/CustomSnackBar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserDetailsModel? userDetails;
  bool isLoading = true;
  final spinkits = Spinkits3();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final profile_provider =
          Provider.of<UserDetailsProvider>(context, listen: false);
      var res = await profile_provider.fetchUserDetails();
      setState(() {
        if (res == 1) {
          isLoading = false;
        } else {
          isLoading = false;
        }
      });
    } catch (e) {
      // Handle error appropriately, e.g., show a toast or dialog
      print('Error fetching user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar2(title: 'Profile', w: w),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: Color(0xffE7C6A0),
              ))
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<UserDetailsProvider>(
                      builder: (context, userdetailsProvider, child) {
                    final user_data = userdetailsProvider.userDetails;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: (user_data?.image != null)
                              ? CachedNetworkImage(
                                  imageUrl: user_data?.image ?? "",
                                  width: w * 0.2,
                                  height: h * 0.1,
                                  fit: BoxFit.cover,
                                  placeholder:
                                      (BuildContext context, String url) {
                                    return Center(
                                      child: spinkits.getSpinningLinespinkit(),
                                    );
                                  },
                                  errorWidget: (BuildContext context,
                                      String url, dynamic error) {
                                    // Handle error in case the image fails to load
                                    return Icon(Icons.error);
                                  },
                                )
                              : _buildNamePlaceholder(
                                  user_data?.fullName, w, h),
                        ),
                        SizedBox(width: w * 0.04),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    user_data?.fullName ?? 'No Name',
                                    style: TextStyle(
                                      color: const Color(0xff110B0F),
                                      fontFamily: 'RozhaOne',
                                      fontSize: 16,
                                      height: 21 / 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfileScreen()),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Image.asset(
                                        'assets/edit.png',
                                        width: w * 0.1,
                                        height: h * 0.03,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: h * 0.01),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/call.png',
                                    width: w * 0.04,
                                    height: h * 0.02,
                                    color: const Color(0xff617C9D),
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    user_data?.mobile ?? '+91 XXXXXX',
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
                                    width: w * 0.05,
                                    height: h * 0.02,
                                    color: const Color(0xff617C9D),
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      user_data?.email ?? '',
                                      style: TextStyle(
                                        color: const Color(0xff617C9D),
                                        fontFamily: 'RozhaOne',
                                        fontSize: 16,
                                        height: 21 / 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: h * 0.06),
                  // Menu Items (Orders, Wishlist, etc.)
                  _buildMenuItem(
                    context,
                    iconPath: "assets/orders.png",
                    label: 'Orders',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderListScreen()),
                      );
                    },
                  ),
                  // _buildDivider(h),
                  // _buildMenuItem(
                  //   context,
                  //   iconPath: "assets/fav.png",
                  //   label: 'Wishlist',
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => WishlistScreen()),
                  //     );
                  //   },
                  // ),
                  // _buildDivider(h),
                  // _buildMenuItem(
                  //   context,
                  //   iconPath: "assets/notification.png",
                  //   label: 'Notifications',
                  // ),
                  // _buildDivider(h),
                  // _buildMenuItem(
                  //   context,
                  //   iconPath: "assets/history.png",
                  //   label: 'Payment Methods',
                  // ),
                  _buildDivider(h),
                  _buildMenuItem(
                    context,
                    iconPath: "assets/address.png",
                    label: 'Address',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddressListScreen()),
                      );
                    },
                  ),
                  // _buildDivider(h),
                  // _buildMenuItem(
                  //   context,
                  //   iconPath: "assets/helpsupport.png",
                  //   label: 'Help & Support',
                  // ),
                  // _buildDivider(h),
                  // _buildMenuItem(
                  //   context,
                  //   iconPath: "assets/Settings.png",
                  //   label: 'Settings',
                  // ),
                  _buildDivider(h),
                  const Spacer(),
                  InkResponse(
                    onTap: () async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.remove('token');
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Login()),
                      // );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login2()),
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
        borderRadius:
            BorderRadius.circular(7), // Slightly rounded corners (optional)
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
