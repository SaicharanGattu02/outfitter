import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey; // Key for opening drawer
  final double w; // Screen width

  CustomAppBar({required this.scaffoldKey, required this.w});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: null, // Hides the leading icon (for drawer)
      actions: <Widget>[Container()], // Keeps actions empty for custom icons
      toolbarHeight: 50,
      backgroundColor: const Color(0xff110B0F),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            InkResponse(
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
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
                    // Handle profile icon tap
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
