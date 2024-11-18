import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outfitter/Authentication/Otp.dart';
import 'package:outfitter/Authentication/Register.dart';
import 'package:outfitter/Services/UserApi.dart';
import 'package:outfitter/utils/CustomSnackBar.dart';

import '../utils/Mywidgets.dart';
import '../utils/ShakeWidget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _focusNodePhone = FocusNode();
  String _validatePhone = "";
  bool _loading = false;
  final spinkits=Spinkits();

  void _validateFields() {
    setState(() {
      _validatePhone =
      _phoneController.text.isEmpty ? "Please enter a phone number" : "";
    });

    if (_validatePhone.isEmpty) {
      LoginOtp();

    }
  }

  Future<void> LoginOtp() async {
    await Userapi.PostOtp(_phoneController.text).then((data) => {
      if (data != null) {
        setState(() {
          if (data.settings?.success ==1) {
            _loading=false;
            Navigator.push(context, MaterialPageRoute(builder: (context) => Otp(mobileNumber: _phoneController.text)));

          }else{
            _loading=false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                data.settings?.message??"",
                style: TextStyle(color: Color(0xff000000)),
              ),
              duration: Duration(seconds: 1),
              backgroundColor: Color(0xFFCDE2FB),
            ));
          }
        })
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xff),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        width: w,
                        child: Image.asset(
                          "assets/SplashSuit.png", // Your image path
                          fit: BoxFit.fill,
                          width: w, // Fit the image
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: w,
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xffE7C6A0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: h * 0.015),
                        Center(
                            child: Image.asset(
                              "assets/OutfiterText.png",
                              fit: BoxFit.contain,
                              width: w * 0.4,
                            )),
                        SizedBox(height: h * 0.05),
                        Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xff110B0F),
                            fontFamily: 'RozhaOne',
                            fontSize: 24,
                            height: 21.3 / 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Label(text: 'Mobile Number'),
                            SizedBox(height: h * 0.005),
                            Container(
                              height: h * 0.050,
                              child: TextFormField(
                                controller: _phoneController,
                                focusNode: _focusNodePhone,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .digitsOnly, // Only allow digits
                                  LengthLimitingTextInputFormatter(
                                      10), // Limit input to 10 digits
                                ],
                                cursorColor: Color(0xffCAA16C),
                                onTap: () {
                                  setState(() {
                                    _validatePhone = "";
                                  });
                                },
                                onChanged: (v) {
                                  setState(() {
                                    _validatePhone = "";
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  hintText: "Enter Mobile Number",
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    height: 25.73 / 14,
                                    color: Color(0xffCAA16C),
                                    fontFamily: 'RozhaOne',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  prefixIcon: Container(
                                    width: 24,
                                    height: 24,
                                    padding: EdgeInsets.only(
                                        top: 10, bottom: 10, left: 6),
                                    child: Image.asset(
                                      "assets/smartphone.png",
                                      fit: BoxFit.contain,
                                      color: Color(0xffCAA16C),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xffFCFAFF),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: const BorderSide(
                                        width: 1, color: Color(0xffCAA16C)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: const BorderSide(
                                        width: 1, color: Color(0xffCAA16C)),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: 'RozhaOne',
                                ),
                                textAlignVertical: TextAlignVertical.center,
                              ),
                            ),
                            if (_validatePhone.isNotEmpty)
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                                width: w * 0.6,
                                child: ShakeWidget(
                                  key: Key("value"),
                                  duration: Duration(milliseconds: 700),
                                  child: Text(
                                    _validatePhone,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            else
                              SizedBox(height: 8),
                          ],
                        ),
                        const SizedBox(height: 16),
                        InkResponse(
                          onTap: () {
                            _validateFields();
                          },
                          child: Container(
                            width: w,
                            height: h * 0.050,
                            decoration: BoxDecoration(
                              color: const Color(0xff110B0F),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Center(
                              child:_loading?spinkits.getFadingCircleSpinner(color: Color(0xffE7C6A0)):
                              Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: Color(0xffCAA16C),
                                  fontFamily: "RozhaOne",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  height: 21 / 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "you don't  have an account?",
                              style: TextStyle(
                                fontFamily: 'RozhaOne',
                                fontSize: 14,
                                color: Color(0xff6C7278),
                                fontWeight: FontWeight.w400,
                                height: 19.6 / 14,
                                letterSpacing: -0.01,
                              ),
                            ),
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontFamily: 'RozhaOne',
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xff110B0F),
                                  color: Color(0xff110B0F),
                                  fontWeight: FontWeight.w400,
                                  height: 19.6 / 14,
                                  letterSpacing: -0.01,
                                ),
                              ),

                            )

                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
