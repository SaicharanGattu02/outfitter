import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.black, fontFamily: "Inter"),
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xFFE7C6A0),
      ),
    );
  }
}

class Spinkits {
  Widget getFadingCircleSpinner({Color color = Colors.white}) {
    return SizedBox(
      height: 15,
      width: 35,
      child: SpinKitThreeBounce(
        size: 20,
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color, // Use the passed color or default to white
            ),
          );
        },
      ),
    );
  }
}

class Spinkits1 {
  Widget getWavespinkit() {
    return SizedBox(
      height: 20,
      width: 55,
      child: SpinKitWave(
        color: Color(0xffE7C6A0),
      ),
    );
  }
}


class Spinkits2 {
  Widget getSpinningLinespinkit() {
    return SizedBox(
      height: 20,
      width: 55,
      child: SpinKitSpinningLines(
        color: Color(0xffE7C6A0),
      ),
    );
  }
}

class Spinkits3 {
  Widget getSpinningLinespinkit() {
    return SizedBox(
      height: 20,
      width: 55,
      child: SpinKitSpinningLines(
        color: Color(0xffE7C6A0),
      ),
    );
  }
}
