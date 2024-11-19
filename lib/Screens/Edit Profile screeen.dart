import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outfitter/utils/CustomAppBar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/UserDetailsModel.dart';
import '../Services/UserApi.dart';
import '../providers/UserDetailsProvider.dart';
import '../utils/CustomAppBar1.dart';
import '../utils/CustomSnackBar.dart';
import '../utils/ShakeWidget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FocusNode _focusNodeFullName = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePhone = FocusNode();
  File? _image; // To store the selected image
  bool isLoading = true; // Loading state
  XFile? _pickedFile;
  // CroppedFile? _croppedFile;
  String _validatePhone = "";
  String _validateEmail = "";

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile(); // Fetch user profile data when the screen is initialized
  }


  void _validateFields() {
    setState(() {
      _validatePhone =
      mobileController.text.length < 10 ? "Please enter a valid phone number (10 digits)" : "";
      _validateEmail = !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(emailController.text)
          ? "Please enter a valid email address (e.g. user@domain.com)"
          : "";
    });

    if (_validatePhone.isEmpty && _validateEmail.isEmpty) {
      _updateProfile();
    }
  }

  String profile_image = "";
  Future<void> _fetchUserProfile() async {
    try {
      final profile_provider =
          Provider.of<UserDetailsProvider>(context, listen: false);
      var res = await profile_provider.userDetails;
      setState(() {
        if (res != null) {
          fullnameController.text = res.fullName ?? ''; // Use safe navigation
          mobileController.text = res.mobile ?? '';
          emailController.text = res.email ?? '';
          profile_image = res.image ?? "";
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error appropriately, e.g., show a toast or dialog
      print('Error fetching user profile: $e');
    }
  }

  // Function to pick image from gallery or camera
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // Use ImageSource.camera for camera
      imageQuality: 100,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Set the selected image
      });
    }
  }

  Future<void> _updateProfile() async {
    String fullname = fullnameController.text;
    String mobile = mobileController.text;
    String email = emailController.text;
    final profile_provider =
        Provider.of<UserDetailsProvider>(context, listen: false);
    var response = await profile_provider.updateUserDetails(
        fullname, mobile, email, _image);
    setState(() {
      if (response == 1) {
        isLoading = false;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Profile updated successfully")));
        // Optionally, you can navigate back or update the UI to reflect changes
      } else {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed to update profile")));
      }
    });
  }

  final spinkits=Spinkits();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomApp(title: 'Edit Profile', w: w),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          profile_image != null && profile_image.isNotEmpty
                              ? _image != null
                                  ? FileImage(_image!) as ImageProvider<Object>
                                  : NetworkImage(profile_image)
                              : AssetImage('assets/personProfile.png',)
                                  as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: _pickImage,
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.camera_alt,
                            color: Color(0xFFCAA16C1A),
                            size: 20, // Size of the camera icon
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
              Label(text: 'Full Name'),
              SizedBox(height: 4),
              _buildTextField(
                controller: fullnameController,
                hint: "Enter Name",
                icon: "assets/person.png",
                focusNode: _focusNodeFullName,
              ),
              SizedBox(height: 16),
              Label(text: 'Mobile Number'),
              _buildTextField(
                controller: mobileController,
                hint: "Enter Mobile Number",
                icon: "assets/call.png",
                focusNode: _focusNodePhone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              if (_validatePhone.isNotEmpty)
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                  width: w * w,
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
              SizedBox(height: 16),
              Label(text: 'Email'),
              _buildTextField(
                controller: emailController,
                hint: "Enter Email Address",
                icon: "assets/mail.png",
                focusNode: _focusNodeEmail,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9@._-]")),
                ],
              ),
              if (_validateEmail.isNotEmpty)
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                  width: w * w,
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
                ),
              SizedBox(height: 40),
              InkResponse(
                onTap: _validateFields,
                child: Container(
                  width: w,
                  height: MediaQuery.of(context).size.height * 0.060,
                  decoration: BoxDecoration(
                    color: const Color(0xff110B0F),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: isLoading
                        ?spinkits.getFadingCircleSpinner(color: Color(0xffE7C6A0))
                        : Text(
                      "SAVE",
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String icon,
    required FocusNode focusNode,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        inputFormatters: inputFormatters,
        cursorColor: Color(0xffCAA16C),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xffCAA16C),
            fontFamily: 'RozhaOne',
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Container(
            width: 24,
            height: 24,
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 6),
            child: Image.asset(
              icon,
              fit: BoxFit.contain,
              color: Color(0xffCAA16C),
            ),
          ),
          filled: true,
          fillColor: const Color(0xffFCFAFF),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(width: 1, color: Color(0xffCAA16C)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(width: 1, color: Color(0xffCAA16C)),
          ),
        ),
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'RozhaOne',
          overflow: TextOverflow.ellipsis,
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }

  Widget Label({required String text, TextAlign? textalign}) {
    return Text(
      text,
      textAlign: textalign,
      style: TextStyle(
        color: Color(0xff110B0F),
        fontFamily: 'RozhaOne',
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
