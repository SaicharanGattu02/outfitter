import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/UserDetailsModel.dart';
import '../Services/UserApi.dart';



class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  File? _image;  // To store the selected image
  bool isLoading = true;  // Loading state

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

    String imageUrl = _image?.path ?? "";

    // Call the updateProfile API
    var updatedUser = await Userapi.updateProfile(
      fullname,
      mobile,
      email,
      imageUrl,
    );

    // Handle the API response
    if (updatedUser != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile updated successfully")));
      // Optionally, you can navigate back or update the UI to reflect changes
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to update profile")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Edit Profile")),
        body: Center(child: CircularProgressIndicator()),  // Show loading indicator while fetching data
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image Selection
              Center(
                child: GestureDetector(
                  onTap: _pickImage,  // Allow the user to pick a new image
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null
                        ? FileImage(_image!) as ImageProvider<Object>  // Cast to ImageProvider<Object>
                        : AssetImage('assets/default_profile.jpg') as ImageProvider<Object>,  // Cast to ImageProvider<Object>
                    child: _image == null
                        ? Icon(Icons.camera_alt, size: 50, color: Colors.white)
                        : null,  // Display camera icon if no image
                  ),
                ),
              ),

              SizedBox(height: 16),
              // Full Name Field
              TextField(
                controller: fullnameController,
                decoration: InputDecoration(labelText: "Full Name"),
              ),
              SizedBox(height: 16),
              // Mobile Field
              TextField(
                controller: mobileController,
                decoration: InputDecoration(labelText: "Mobile Number"),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              // Email Field
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateProfile,
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

