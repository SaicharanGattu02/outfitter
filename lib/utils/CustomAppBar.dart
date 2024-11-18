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


class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final double w;
  final String title;

  CustomAppBar2({required this.title, required this.w});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      leading: null,
      actions: <Widget>[Container()],
      toolbarHeight: 50,
      backgroundColor: const Color(0xff110B0F),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: TextStyle(
            color: Color(0xffffffff),
            fontFamily: 'RozhaOne',
            fontSize: 24,
            height: 32 / 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
