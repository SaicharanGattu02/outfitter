import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outfitter/Authentication/Login.dart';
import 'package:outfitter/Services/UserApi.dart';
import 'package:outfitter/utils/Mywidgets.dart';
import '../utils/CustomSnackBar.dart';
import '../utils/ShakeWidget.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool _obscureText = true;
  String _gender = "";
  String _validateGender = "";
  // Focus nodes
  final FocusNode _focusNodeFullName = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePhone = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  String _validateFullName = "";
  String _validateemail = "";
  String _validatePhone = "";
  String _validatePwd = "";

  bool _loading = false;
  final spinkits=Spinkits();

  void _validateFields() {
    setState(() {
      _validateFullName =
          _fullNameController.text.isEmpty ? "Please enter a fullName" : "";
      _validateemail =
          _emailController.text.isEmpty ? "Please enter a valid email" : "";
      _validatePhone =
          _phoneController.text.isEmpty ? "Please enter a phonenumber" : "";
      _validatePwd =
          _pwdController.text.isEmpty ? "Please enter a password" : "";
      _validateGender =
      _gender.isEmpty ? "Please select a gender" : "";
    });

    if (_validateFullName.isEmpty &&
        _validateemail.isEmpty &&
        _validatePhone.isEmpty &&
        _validatePwd.isEmpty &&
        _validateGender.isEmpty) {
      RegisterApi();
    }
  }

  Future<void> RegisterApi() async {
    var data = await Userapi.PostRegister(
        _fullNameController.text,
        _emailController.text,
        _phoneController.text,
        _pwdController.text,
        _gender ?? "");
    if (data != null) {
      setState(() {
        if (data.settings?.success == 1) {
          _loading = false;
          CustomSnackBar.show(context, "${data.settings?.message}");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) =>LogInScreen()));
        } else {
          _loading = false;
          CustomSnackBar.show(context, "${data.settings?.message}");
          print("Register failure");
        }
      });
    } else {
      print("Register >>>${data?.settings?.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: w,
          height: h,
          padding: EdgeInsets.only(top: 30, left: 20, right: 20),
          decoration: BoxDecoration(
            color: const Color(0xffE7C6A0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                "assets/OutfiterText.png",
                fit: BoxFit.contain,
                width: w * 0.4,
              )),
              SizedBox(height: 30),
              Text("Register",
                  style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'RozhaOne',
                      fontSize: 24,
                      height: 21.3 / 15,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: h * 0.03,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label(text: 'Name'),
                    SizedBox(height: 4),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: TextFormField(
                        controller: _fullNameController,
                        focusNode: _focusNodeFullName,
                        keyboardType: TextInputType.text,
                        cursorColor: Color(0xffCAA16C),
                        onTap: () {
                          setState(() {
                            _validateFullName = "";
                          });
                        },
                        onChanged: (v) {
                          setState(() {
                            _validateFullName = "";
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          hintText: "Enter Name",
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
                            padding:
                                EdgeInsets.only(top: 10, bottom: 10, left: 6),
                            child: Image.asset(
                              "assets/person.png",
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xffCAA16C)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xffCAA16C)),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 14, // Ensure font size fits within height
                          overflow: TextOverflow
                              .ellipsis,
                          fontFamily: 'RozhaOne',
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ),
                    if (_validateFullName.isNotEmpty) ...[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ShakeWidget(
                          key: Key("value"),
                          duration: Duration(milliseconds: 700),
                          child: Text(
                            _validateFullName,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      SizedBox(height: 8),
                    ],
                    Label(text: 'Mobile Number'),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.050,
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
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                            padding:
                                EdgeInsets.only(top: 10, bottom: 10, left: 6),
                            child: Image.asset(
                              "assets/call.png",
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xffCAA16C)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xffCAA16C)),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 14, // Ensure font size fits within height
                          overflow: TextOverflow
                              .ellipsis,
                          fontFamily: 'RozhaOne',
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ),
                    if (_validatePhone.isNotEmpty) ...[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                        width: MediaQuery.of(context).size.width * 0.6,
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
                      ),
                    ] else ...[
                      SizedBox(height: 8),
                    ],
                    Label(text: 'Email'),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.050,
                      child: TextFormField(
                        controller: _emailController,
                        focusNode: _focusNodeEmail,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Color(0xffCAA16C),
                        maxLines: 1,
                        onTap: () {
                          setState(() {
                            _validateemail = "";
                          });
                        },
                        onChanged: (v) {
                          setState(() {
                            _validateemail = "";
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          hintText: "Enter Email Address",
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
                            padding:
                                EdgeInsets.only(top: 10, bottom: 10, left: 6),
                            child: Image.asset(
                              "assets/mail.png",
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xffCAA16C)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xffCAA16C)),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          overflow: TextOverflow
                              .ellipsis,
                          fontFamily: 'RozhaOne',
                        ),
                        textAlignVertical: TextAlignVertical
                            .center, // Vertically center the text
                      ),
                    ),
                    if (_validateemail.isNotEmpty) ...[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                        child: ShakeWidget(
                          key: Key("value"),
                          duration: Duration(milliseconds: 700),
                          child: Text(
                            _validateemail,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      SizedBox(height: 8),
                    ],
                    Label(text: 'Password'),
                    SizedBox(height: 4),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.050,
                      child: TextFormField(
                        obscureText: _obscureText,
                        controller: _pwdController,
                        focusNode: _focusNodePassword,
                        keyboardType: TextInputType.text,
                        cursorColor: Color(0xffCAA16C),
                        onTap: () {
                          setState(() {
                            _validatePwd = "";
                          });
                        },
                        onChanged: (v) {
                          setState(() {
                            _validatePwd = "";
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
                    if (_validatePwd.isNotEmpty) ...[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ShakeWidget(
                          key: Key("value"),
                          duration: Duration(milliseconds: 700),
                          child: Text(
                            _validatePwd,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      SizedBox(height: 8),
                    ],
                    SizedBox(height: 12),
                    Label(text: 'Gender',textalign: TextAlign.left),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                              scale: 0.9, // Adjust the scale to decrease the size
                              child: Radio<String>(
                                value: 'Male',
                                groupValue: _gender,
                                activeColor:
                                Color(0xffCAA16C), // Change the active color
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value!;
                                    _validateGender="";
                                  });
                                },
                              ),
                            ),
                            // Decrease the space between the Radio and the Text
                            const Text('Male',
                                style: TextStyle(
                                    color: Color(0xff110B0F),
                                    fontFamily: 'RozhaOne',
                                    fontSize: 15,
                                    height: 21.3 / 15,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 0.9,
                              child: Radio<String>(
                                value: 'Female',
                                groupValue: _gender,
                                activeColor:
                                Color(0xffCAA16C), // Change the active color
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value!;
                                    _validateGender="";
                                  });
                                },
                              ),
                            ), // Decrease the space between the Radio and the Text
                            Text('Female',
                                style: TextStyle(
                                    color: Color(0xff110B0F),
                                    fontFamily: 'RozhaOne',
                                    fontSize: 15,
                                    height: 21.3 / 15,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 0.9, // Adjust the scale to decrease the size
                              child: Radio<String>(
                                value: 'Others',
                                groupValue: _gender,
                                activeColor:
                                Color(0xffCAA16C), // Change the active color
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value!;
                                    _validateGender="";
                                  });
                                },
                              ),
                            ),
                            // Decrease the space between the Radio and the Text
                            const Text('Others',
                                style: TextStyle(
                                    color: Color(0xff110B0F),
                                    fontFamily: 'RozhaOne',
                                    fontSize: 15,
                                    height: 21.3 / 15,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ],
                    ),
                    if (_validateGender.isNotEmpty) ...[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ShakeWidget(
                          key: Key("value"),
                          duration: Duration(milliseconds: 700),
                          child: Text(
                            _validateGender,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      SizedBox(height: 8),
                    ],
                  ],
                ),
              ),



              const SizedBox(height: 12),
              InkResponse(
                onTap: () {
                  _validateFields();
                },
                child: Container(
                  width: w,
                  height: MediaQuery.of(context).size.height * 0.050,
                  decoration: BoxDecoration(
                    color: const Color(0xff110B0F),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: _loading?spinkits.getFadingCircleSpinner(color: Color(0xffE7C6A0)):Text(
                      "REGISTER",
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
                    "Already have an account?",
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      "Login",
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
    );
  }
}
