import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/UserDetailsModel.dart';
import '../Services/UserApi.dart';
import '../utils/CustomAppBar1.dart';
import '../utils/CustomSnackBar.dart';



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
  File? _image;  // To store the selected image
  bool isLoading = true;  // Loading state
  XFile? _pickedFile;
  // CroppedFile? _croppedFile;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();  // Fetch user profile data when the screen is initialized
  }
  UserDetail? userdata=UserDetail();
// Function to fetch user details and set to fields
  Future<void> _fetchUserProfile() async {
    try {
      var res = await Userapi.getUserdetsils();
      setState(() {
        if (res != null && res.data != null) {
          userdata = res.data;
          // Populate your text fields with the data
          fullnameController.text = userdata?.fullName ?? ''; // Use safe navigation
          mobileController.text = userdata?.mobile ?? '';
          emailController.text = userdata?.email ?? '';
          _image=userdata?.image as File?;
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
        _image = File(pickedFile.path);  // Set the selected image
      });
    }
  }

  Future<void> _updateProfile() async {
    String fullname = fullnameController.text.trim();
    String mobile = mobileController.text.trim();
    String email = emailController.text.trim();

    // Validate inputs
    if (fullname.isEmpty || mobile.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill in all fields")));
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? "";  // Replace with actual user ID retrieval logic

    // File imageUrl = _image?.path;

    // Call the updateProfile API
    var updatedUser = await Userapi.updateProfile(
      fullname,
      mobile,
      email,
      _image
    );
    setState(() {
      isLoading = false;

      if (updatedUser?.settings?.success==1) {

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile updated successfully")));
        // Optionally, you can navigate back or update the UI to reflect changes
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to update profile")));
      }
    });


  }
  final spinkits = Spinkits();

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
              // Profile Image Selection
              // Center(
              //   child: GestureDetector(
              //     onTap: _pickImage,  // Allow the user to pick a new image
              //     child: CircleAvatar(
              //       radius: 50,
              //       backgroundImage: _image != null
              //           ? FileImage(_image!) as ImageProvider<Object>  // Cast to ImageProvider<Object>
              //           : AssetImage('assets/default_profile.jpg') as ImageProvider<Object>,  // Cast to ImageProvider<Object>
              //       child: _image == null
              //           ? Icon(Icons.camera_alt, size: 50, color: Colors.white)
              //           : null,  // Display camera icon if no image
              //     ),
              //   ),
              // ),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                           userdata?.image != null &&
                          userdata!.image!.isNotEmpty
                          ? NetworkImage(userdata!.image!)
                          : AssetImage(
                          'assets/avatar_placeholder.png')
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
              Label(text: ' Full Name'),
              SizedBox(height: 4),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                child: TextFormField(
                  controller: fullnameController,
                  focusNode: _focusNodeFullName,
                  keyboardType: TextInputType.text,
                  cursorColor: Color(0xffCAA16C),

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
                    fontSize: 14,
                    fontFamily: 'RozhaOne',
                    overflow: TextOverflow
                        .ellipsis, // Add ellipsis for long text
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
              SizedBox(height: 16),
              Label(text: 'Mobile Number'),
              Container(
                height: MediaQuery.of(context).size.height * 0.050,
                child: TextFormField(
                  controller: mobileController,
                  focusNode: _focusNodePhone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                  cursorColor: Color(0xffCAA16C),

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
                    fontSize: 14,
                    fontFamily: 'RozhaOne',
                    overflow: TextOverflow
                        .ellipsis, // Add ellipsis for long text
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
              SizedBox(height: 16),
              Label(text: 'Email'),
              SizedBox(
                height: 4,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.050,
                child: TextFormField(
                  controller: emailController,
                  focusNode: _focusNodeEmail,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Color(0xffCAA16C),
                  maxLines: 1,

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
                    fontFamily: 'RozhaOne',
                    overflow: TextOverflow
                        .ellipsis, // Add ellipsis for long text
                  ),
                  textAlignVertical: TextAlignVertical
                      .center, // Vertically center the text
                ),
              ),

               SizedBox(height: 40),
              InkResponse(
                onTap: () {
                  _updateProfile();
                },
                child: Container(
                  width: w,
                  height: MediaQuery.of(context).size.height * 0.060,
                  decoration: BoxDecoration(
                    color: const Color(0xff110B0F),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: isLoading ? spinkits.getFadingCircleSpinner(color: Color(0xffE7C6A0)):
                    Text(
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

  Widget Label({
    required String text,
    TextAlign? textalign
  }) {
    return Text(text,
        textAlign: textalign,
        style: TextStyle(
            color: Color(0xff110B0F),
            fontFamily: 'RozhaOne',
            fontSize: 15,
            height: 21.3/ 15,
            fontWeight: FontWeight.w400)
    );
  }
}

