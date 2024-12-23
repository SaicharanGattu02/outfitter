import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outfitter/Authentication/Otp.dart';
import 'package:outfitter/Authentication/Register.dart';
import 'package:outfitter/Screens/dashbord.dart';
import 'package:outfitter/Services/UserApi.dart';
import 'package:outfitter/utils/CustomSnackBar.dart';
import 'package:provider/provider.dart';

import '../providers/ConnectivityService.dart';
import '../utils/Mywidgets.dart';
import '../utils/Preferances.dart';
import '../utils/ShakeWidget.dart';
import 'dart:developer' as developer;
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import '../Services/otherservices.dart';


class Login2 extends StatefulWidget {
  const Login2({super.key});

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _validateEmail = "";
  String _validatePassword = "";
  bool _loading = false;
  final spinkits=Spinkits();

  bool _obscureText = true;


  void _validateFields() {
    setState(() {
      _loading=true;
      _validateEmail =
      !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
          .hasMatch(_emailController.text)
          ? "Please enter a valid email address (e.g. user@domain.com)"
          : "";
      _validatePassword = _passwordController.text.isEmpty ? "Please enter password" : "";
      if (_validateEmail.isEmpty &&
          _validatePassword.isEmpty
      ) {
        LoginApi();
      }else{
        _loading=false;
      }
    });
  }

  Future<void> LoginApi() async {
    await Userapi.LoginWithEmail(_emailController.text,_passwordController.text).then((data) => {
      if (data != null) {
        setState(() {
          if (data.settings?.success ==1) {
            _loading=false;
            PreferenceService().saveString('token',data.data?.access??"");
            Navigator.push(context, MaterialPageRoute(builder: (context) => Dashbord()));
          }else{
            _loading=false;
            CustomSnackBar.show(context, "${data.settings?.message??""}");
          }
        })
      }
    });
  }

  @override
  void initState() {
    Provider.of<ConnectivityService>(context, listen: false).initConnectivity();
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<ConnectivityService>(context, listen: false).dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    final _connectivityService = Provider.of<ConnectivityService>(context);
    return (_connectivityService.isDeviceConnected == "ConnectivityResult.wifi" ||
        _connectivityService.isDeviceConnected == "ConnectivityResult.mobile")
        ?
    Scaffold(
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
                            Label(text: 'Email'),
                            SizedBox(height: h * 0.005),
                            Container(
                              height: h * 0.050,
                              child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Color(0xffCAA16C),
                                onTap: () {
                                  setState(() {
                                    _validateEmail = "";
                                  });
                                },
                                onChanged: (v) {
                                  setState(() {
                                    _validateEmail = "";
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  hintText: "Enter Email",
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
                            if (_validateEmail.isNotEmpty)
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                                width: w * 0.8,
                                child: ShakeWidget(
                                  key: Key("value"),
                                  duration: Duration(milliseconds: 700),
                                  child: Text(
                                    _validateEmail,
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
                            Label(text: 'Password'),
                            SizedBox(height: h * 0.005),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.050,
                              child: TextFormField(
                                obscureText: _obscureText,
                                controller: _passwordController,
                                keyboardType: TextInputType.text,
                                cursorColor: Color(0xffCAA16C),
                                onTap: () {
                                  setState(() {
                                    _validatePassword = "";
                                  });
                                },
                                onChanged: (v) {
                                  setState(() {
                                    _validatePassword = "";
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                  hintText: "Enter Password",
                                  hintStyle: const TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 0,
                                    height: 25.73 / 15,
                                    color: Color(0xffCAA16C),
                                    fontFamily: 'RozhaOne',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  prefixIcon: Container(
                                    width: 24,
                                    height: 24,
                                    padding:
                                    EdgeInsets.only(top: 10, bottom: 10, left: 6),
                                    child: Image.asset(
                                      "assets/pwd.png",
                                      fit: BoxFit.contain,
                                      color: Color(0xffCAA16C),
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      size: 20,
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color(0xffCAA16C),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText =
                                        !_obscureText; // Toggle the visibility
                                      });
                                    },
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
                                        width: 1, color: Color(0xffd0cbdb)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: const BorderSide(
                                        width: 1, color: Color(0xffd0cbdb)),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: const BorderSide(
                                        width: 1, color: Color(0xffd0cbdb)),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'RozhaOne',
                                  overflow: TextOverflow
                                      .ellipsis, // Add ellipsis for long text
                                ),
                                textAlignVertical: TextAlignVertical.center,
                              ),
                            ),
                            if (_validatePassword.isNotEmpty)
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                                width: w * 0.8,
                                child: ShakeWidget(
                                  key: Key("value"),
                                  duration: Duration(milliseconds: 700),
                                  child: Text(
                                    _validatePassword,
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
                            if(_loading){

                            }else{
                              _validateFields();
                            }
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
    ):NoInternetWidget();
  }
}
