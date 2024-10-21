import 'package:flutter/material.dart';
import 'package:outfitter/Authentication/Register.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String token = "";

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  fetchDetails() async {
    // final Token = await PreferenceService().getString("token") ?? "";
    // print("Token>>>${Token}");
    setState(() {
      // token = Token;
    });

    // Wait for 2 seconds before navigating
    Future.delayed(Duration(seconds: 2), () {
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => (token.isEmpty) ? LogInScreen() : Dashboard(),
      //   ),
      // );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Register(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(

      body: Center(
        child: Container(

          width: w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/SplashSuit.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Image.asset(
              "assets/OutfiterText.png",color: Color(0xffE7C6A033),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
