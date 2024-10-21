import 'package:flutter/material.dart';

class CustomApp extends StatelessWidget implements PreferredSizeWidget {
  final double w;
  final String  title;

  CustomApp({required this.title,required this.w});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              onTap: () {},
              child: Row(
                children: [
                  Icon(Icons.arrow_back,color: Color(0xffffffff),),
                  const SizedBox(width: 12),
                ],
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Color(0xffffffff),
                fontFamily: 'RozhaOne',
                fontSize: 24,
                height: 32 / 24,
                fontWeight: FontWeight.w400,
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
                  onTap: () {},
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
