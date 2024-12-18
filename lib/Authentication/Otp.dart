import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outfitter/Authentication/Login.dart';
import 'package:outfitter/Screens/dashbord.dart';
import 'package:outfitter/Services/UserApi.dart';
import 'package:outfitter/utils/Preferances.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../utils/CustomSnackBar.dart';
import '../utils/ShakeWidget.dart';
import 'dart:developer' as developer;
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import '../Services/otherservices.dart';


class Otp extends StatefulWidget {
  final String mobileNumber;
  const Otp({super.key, required this.mobileNumber});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController otpController = TextEditingController();
  final FocusNode focusNodeOTP = FocusNode();
  bool _isLoading = false;
  String _verifyMessage = "";
  bool recieving = false;
  final spinkits=Spinkits();

  void _validateFields() {
    setState(() {
      _isLoading = true;
      _verifyMessage =
      (otpController.text.length < 6 || otpController.text.isEmpty)
          ? "Please enter a valid 6-digit OTP"
          : "";
    });
    if (_verifyMessage == "") {
      VerifyOtp();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  Future<void> VerifyOtp() async{
    var res = await Userapi.VerifyOtp(widget.mobileNumber, otpController.text);
    if (res!=null){
      setState(() {
        if(res.settings?.success==1){
          _isLoading=false;
          PreferenceService().saveString('token',res.data?.access??"");
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashbord()));
        }else{
          _isLoading=false;
          CustomSnackBar.show(context, "${res.settings?.message??""}");
        }
      });

    }
  }
  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }


  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  var isDeviceConnected = "";

  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();

  Future<void> initConnectivity() async {
    List<ConnectivityResult> result;
    try {

      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }


    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
      for (int i = 0; i < _connectionStatus.length; i++) {
        setState(() {
          isDeviceConnected = _connectionStatus[i].toString();
          print("isDeviceConnected:${isDeviceConnected}");
        });
      }
    });
    print('Connectivity changed: $_connectionStatus');
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return
      (isDeviceConnected == "ConnectivityResult.wifi" ||
          isDeviceConnected == "ConnectivityResult.mobile")
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: w,
                        padding:
                        EdgeInsets.only(top: 30, left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xffE7C6A0),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: h * 0.015,
                            ),
                            Center(
                                child: Image.asset(
                                  "assets/OutfiterText.png",
                                  fit: BoxFit.contain,
                                  width: w * 0.45,
                                )),
                            SizedBox(
                              height: h * 0.03,
                            ),
                            // Center(
                            //   child: Text("OTP Verification",
                            //       style: TextStyle(
                            //           color: Color(0xff110B0F),
                            //           fontFamily: 'RozhaOne',
                            //           fontSize: 22,
                            //           height: 21.3 / 22,
                            //           fontWeight: FontWeight.w400)),
                            // ),
                            // SizedBox(
                            //   height: h * 0.01,
                            // ),
                            Center(
                              child: Column(
                                children: [
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "We will send you a one-time password on this \n mobile number ",
                                          style: TextStyle(
                                            color: Color(0xff110B0F),
                                            fontFamily: 'RozhaOne',
                                            fontSize: 14,
                                            height: 19 / 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "+91 ${widget.mobileNumber}",
                                          style: TextStyle(
                                            color: Color(0xff110B0F),
                                            fontFamily: 'RozhaOne',
                                            fontSize: 16,
                                            height: 19 / 16,
                                            fontWeight: FontWeight.w500,

                                          ),

                                        ),

                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.01,
                                  ),
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "+91 ${widget.mobileNumber}",
                                        style: TextStyle(
                                          color: Color(0xff110B0F),
                                          fontFamily: 'RozhaOne',
                                          fontSize: 16,
                                          height: 19 / 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 5),  // Small space between the number and image
                                      InkResponse(onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                                      },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(
                                            "assets/pen.png",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),

                            SizedBox(
                              height: h * 0.02,
                            ),
                            // Center(
                            //   child:
                            //   Row(
                            //     children: [
                            //       Text(
                            //         "+91 ${widget.mobileNumber}",
                            //         style: TextStyle(
                            //           color: Color(0xff110B0F),
                            //           fontFamily: 'RozhaOne',
                            //           fontSize: 16,
                            //           height: 19 / 16,
                            //           fontWeight: FontWeight.w500,
                            //         ),
                            //       ),
                            //       SizedBox(width: 5),  // Small space between the number and image
                            //       Container(
                            //         width: 20,
                            //         height: 20,
                            //         child: Image.asset(
                            //           "assets/pen.png",
                            //           fit: BoxFit.contain,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Please enter mobile OTP",
                                    style: TextStyle(
                                        color: Color(0xff110B0F),
                                        fontFamily: 'RozhaOne',
                                        fontSize: 14,
                                        height: 18 / 14,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(
                                  height: 20,
                                ),
                                PinCodeTextField(
                                  autoUnfocus: true,
                                  appContext: context,
                                  pastedTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  length: 6,
                                  blinkWhenObscuring: true,
                                  autoFocus: true,
                                  autoDismissKeyboard: false,
                                  showCursor: true,
                                  animationType: AnimationType.fade,
                                  focusNode: focusNodeOTP,
                                  hapticFeedbackTypes:
                                  HapticFeedbackTypes.heavy,
                                  controller: otpController,
                                  onTap: () {
                                    setState(() {
                                      _verifyMessage = "";
                                    });
                                  },
                                  onChanged: (v) {
                                    setState(() {
                                      _verifyMessage = "";
                                    });
                                  },
                                  pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(50),
                                      fieldHeight: 45,
                                      fieldWidth: 45,
                                      fieldOuterPadding:
                                      EdgeInsets.only(left: 0, right: 3),
                                      activeFillColor: Color(0xFFF4F4F4),
                                      activeColor: Color(0xff110B0F),
                                      selectedColor: Color(0xff110B0F),
                                      selectedFillColor: Color(0xFFF4F4F4),
                                      inactiveFillColor: Color(0xFFF4F4F4),
                                      inactiveColor: Color(0xFFD2D2D2),
                                      inactiveBorderWidth: 1.5,
                                      selectedBorderWidth: 2,
                                      activeBorderWidth: 2),
                                  textStyle: TextStyle(
                                      fontFamily: "RozhaOne",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400),
                                  cursorColor: Colors.black,
                                  enableActiveFill: true,
                                  keyboardType:
                                  TextInputType.numberWithOptions(),
                                  textInputAction: (Platform.isAndroid)
                                      ? TextInputAction.none
                                      : TextInputAction.done,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  boxShadows: const [
                                    BoxShadow(
                                      offset: Offset(0, 1),
                                      color: Colors.black12,
                                      blurRadius: 10,
                                    )
                                  ],
                                  enablePinAutofill: true,
                                  useExternalAutoFillGroup: true,
                                  beforeTextPaste: (text) {
                                    return true;
                                  },
                                ),
                                if (_verifyMessage.isNotEmpty) ...[
                                  Center(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(
                                          left: 8, bottom: 10, top: 5),
                                      width: w * 0.6,
                                      child: ShakeWidget(
                                        key: Key("value"),
                                        duration: Duration(milliseconds: 700),
                                        child: Text(
                                          _verifyMessage,
                                          style: TextStyle(
                                            fontFamily: "RozhaOne",
                                            fontSize: 13,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ] else ...[
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                                InkResponse(
                                  onTap: () {
                                    _validateFields();
                                  },
                                  child: Container(
                                    width: w,
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.050,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff110B0F),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Center(
                                      child:_isLoading ?spinkits.getFadingCircleSpinner(color: Color(0xffE7C6A0)):
                                      Text(
                                        "SUBMIT",
                                        style: TextStyle(
                                            color: Color(0xffD0A85C),
                                            fontFamily: 'RozhaOne',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            height: 16 / 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.07,
                            ),
                          ],
                        ),
                      )
                    ],
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
