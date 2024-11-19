import 'package:flutter/material.dart';
import 'package:outfitter/Screens/Profile.dart';

class CustomApp extends StatelessWidget implements PreferredSizeWidget {
  final double w;
  final String title;

  CustomApp({required this.title, required this.w});

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
              onTap: () {
                Navigator.pop(context,true);
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Color(0xffffffff)),
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
            // Spacer(),
            // Row(
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         // Handle search icon tap
            //       },
            //       child: Container(
            //         alignment: Alignment.center,
            //         child: Image.asset(
            //           "assets/search.png",
            //           width: 28,
            //           height: 28,
            //           fit: BoxFit.contain,
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: w * 0.025),
            //     InkWell(
            //       onTap: () {},
            //       child: Container(
            //         alignment: Alignment.center,
            //         child: Image.asset(
            //           "assets/notification.png",
            //           width: 28,
            //           height: 28,
            //           fit: BoxFit.contain,
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: w * 0.025),
            //     InkWell(
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => Profile()));
            //       },
            //       child: Container(
            //         alignment: Alignment.center,
            //         child: ClipOval(
            //           child: CircleAvatar(
            //             radius: w * 0.038,
            //             child: Image.asset(
            //               "assets/Passphoto.png",
            //               fit: BoxFit.contain,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class DashedLine extends StatelessWidget {
  final double width;
  final double height;

  const DashedLine({
    Key? key,
    this.width = double.infinity,
    this.height = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CustomPaint(
        painter: DashedLinePainter(),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5.0;
    double dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        Paint()
          ..color = Color(0xffCBDAF3)
          ..strokeWidth = size.height,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
