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

          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
