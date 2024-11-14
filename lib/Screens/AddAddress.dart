//
// import 'package:flutter/material.dart';
//
// import '../utils/ShakeWidget.dart';
//
// class AddAddress extends StatefulWidget {
//   const AddAddress({super.key});
//
//   @override
//   State<AddAddress> createState() => _AddAddressState();
// }
//
// class _AddAddressState extends State<AddAddress> {
//   final TextEditingController _pincodeController = TextEditingController();
//   String _validatePincode = "";
//   String? _selectedOption = 'Home'; // Default value is Home
//
//   // Method to update the selected value
//   void _handleRadioValueChanged(String? value) {
//     setState(() {
//       _selectedOption = value;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Scaffold(
//         appBar: CustomAppBar1(title: 'ADD ADDRESS', actions: []),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: w,
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(
//                         'assets/Drug Clam Background.png',
//                       ),
//                       fit: BoxFit.cover)),
//               child: container(context,
//
//                   padding: EdgeInsets.all(16),
//                   borderRadius: BorderRadius.circular(8),
//                   colors: color4,
//                   w: w,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       text(context, 'Pincode', 15,
//                           fontWeight: FontWeight.w400, color: color),
//                       SizedBox(
//                         height: h * 0.01,
//                       ),
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.050,
//                         child: TextFormField(
//                           controller: _pincodeController,
//                           keyboardType: TextInputType.text,
//                           cursorColor: Color(0xff8856F4),
//                           onTap: () {
//                             setState(() {
//                               // _validateTitle="";
//                             });
//                           },
//                           onChanged: (v) {
//                             setState(() {
//                               // _validateTitle="";
//                             });
//                           },
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 0, horizontal: 10),
//                             hintText: "Pincode",
//                             hintStyle: TextStyle(
//                               overflow: TextOverflow.ellipsis,
//                               fontSize: 14,
//                               letterSpacing: 0,
//                               height: 19.36 / 14,
//                               color: Color(0xffAFAFAF),
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.w400,
//                             ),
//                             filled: true,
//                             fillColor: const Color(0xffFCFAFF),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                             focusedErrorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                           ),
//                           textAlignVertical: TextAlignVertical.center,
//                         ),
//                       ),
//                       if (_validatePincode.isNotEmpty) ...[
//                         Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
//                           width: MediaQuery.of(context).size.width * 0.6,
//                           child: ShakeWidget(
//                             key: Key("value"),
//                             duration: Duration(milliseconds: 700),
//                             child: Text(
//                               _validatePincode,
//                               style: TextStyle(
//                                 fontFamily: "Poppins",
//                                 fontSize: 12,
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ] else ...[
//                         SizedBox(height: 15),
//                       ],
//                       SizedBox(
//                         height: h * 0.01,
//                       ),
//                       text(context, 'House Number, Building and Locality', 15,
//                           fontWeight: FontWeight.w400, color: color),
//                       SizedBox(
//                         height: h * 0.01,
//                       ),
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.050,
//                         child: TextFormField(
//                           controller: _pincodeController,
//                           keyboardType: TextInputType.text,
//                           cursorColor: Color(0xff8856F4),
//                           onTap: () {
//                             setState(() {
//                               // _validateTitle="";
//                             });
//                           },
//                           onChanged: (v) {
//                             setState(() {
//                               // _validateTitle="";
//                             });
//                           },
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 0, horizontal: 10),
//                             hintText: "Address",
//                             hintStyle: TextStyle(
//                               overflow: TextOverflow.ellipsis,
//                               fontSize: 14,
//                               letterSpacing: 0,
//                               height: 19.36 / 14,
//                               color: Color(0xffAFAFAF),
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.w400,
//                             ),
//                             filled: true,
//                             fillColor: const Color(0xffFCFAFF),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                             focusedErrorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                           ),
//                           textAlignVertical: TextAlignVertical.center,
//                         ),
//                       ),
//                       if (_validatePincode.isNotEmpty) ...[
//                         Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
//                           width: MediaQuery.of(context).size.width * 0.6,
//                           child: ShakeWidget(
//                             key: Key("value"),
//                             duration: Duration(milliseconds: 700),
//                             child: Text(
//                               _validatePincode,
//                               style: TextStyle(
//                                 fontFamily: "Poppins",
//                                 fontSize: 12,
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ] else ...[
//                         SizedBox(height: 15),
//                       ],
//                       SizedBox(
//                         height: h * 0.01,
//                       ),
//                       text(context, 'Full Name', 15,
//                           fontWeight: FontWeight.w400, color: color),
//                       SizedBox(
//                         height: h * 0.01,
//                       ),
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.050,
//                         child: TextFormField(
//                           controller: _pincodeController,
//                           keyboardType: TextInputType.text,
//                           cursorColor: Color(0xff8856F4),
//                           onTap: () {
//                             setState(() {
//                               // _validateTitle="";
//                             });
//                           },
//                           onChanged: (v) {
//                             setState(() {
//                               // _validateTitle="";
//                             });
//                           },
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 0, horizontal: 10),
//                             hintText: "Full Name",
//                             hintStyle: TextStyle(
//                               overflow: TextOverflow.ellipsis,
//                               fontSize: 14,
//                               letterSpacing: 0,
//                               height: 19.36 / 14,
//                               color: Color(0xffAFAFAF),
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.w400,
//                             ),
//                             filled: true,
//                             fillColor: const Color(0xffFCFAFF),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                             focusedErrorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                           ),
//                           textAlignVertical: TextAlignVertical.center,
//                         ),
//                       ),
//                       if (_validatePincode.isNotEmpty) ...[
//                         Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
//                           width: MediaQuery.of(context).size.width * 0.6,
//                           child: ShakeWidget(
//                             key: Key("value"),
//                             duration: Duration(milliseconds: 700),
//                             child: Text(
//                               _validatePincode,
//                               style: TextStyle(
//                                 fontFamily: "Poppins",
//                                 fontSize: 12,
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ] else ...[
//                         SizedBox(height: 15),
//                       ],
//                       text(context, 'Phone Number', 15,
//                           fontWeight: FontWeight.w400, color: color),
//                       SizedBox(
//                         height: h * 0.01,
//                       ),
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.050,
//                         child: TextFormField(
//                           controller: _pincodeController,
//                           keyboardType: TextInputType.phone,
//                           cursorColor: Color(0xff8856F4),
//                           onTap: () {
//                             setState(() {
//                               // _validateTitle="";
//                             });
//                           },
//                           onChanged: (v) {
//                             setState(() {
//                               // _validateTitle="";
//                             });
//                           },
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 0, horizontal: 10),
//                             hintText: "PhoneNumber",
//                             hintStyle: TextStyle(
//                               overflow: TextOverflow.ellipsis,
//                               fontSize: 14,
//                               letterSpacing: 0,
//                               height: 19.36 / 14,
//                               color: Color(0xffAFAFAF),
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.w400,
//                             ),
//                             filled: true,
//                             fillColor: const Color(0xffFCFAFF),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                             focusedErrorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                   width: 1, color: Color(0xffd0cbdb)),
//                             ),
//                           ),
//                           textAlignVertical: TextAlignVertical.center,
//                         ),
//                       ),
//                       if (_validatePincode.isNotEmpty) ...[
//                         Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
//                           width: MediaQuery.of(context).size.width * 0.6,
//                           child: ShakeWidget(
//                             key: Key("value"),
//                             duration: Duration(milliseconds: 700),
//                             child: Text(
//                               _validatePincode,
//                               style: TextStyle(
//                                 fontFamily: "Poppins",
//                                 fontSize: 12,
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ] else ...[
//                         SizedBox(height: 15),
//                       ],
//                       SizedBox(
//                         height: h * 0.01,
//                       ),
//                       Row(
//                           mainAxisAlignment:
//                               MainAxisAlignment.center, // Centers the row
//                           children: <Widget>[
//                             // Home radio button
//                             Row(
//                               children: [
//                                 Radio<String>(activeColor: color1,
//                                   value: 'Home',
//                                   groupValue: _selectedOption,
//                                   onChanged: _handleRadioValueChanged,
//                                 ),
//                              text(context, 'Home', 15,fontWeight: FontWeight.w400,color: color)
//                               ],
//                             ),
//
//                             // Office radio button
//                             Row(
//                               children: [
//                                 Radio<String>(activeColor: color1,
//                                   value: 'Office',
//                                   groupValue: _selectedOption,
//                                   onChanged: _handleRadioValueChanged,
//                                 ),
//                                 text(context, 'Office', 15,fontWeight: FontWeight.w400,color: color)
//                               ],
//                             ),
//
//                             // Other radio button
//                             Row(
//                               children: [
//                                 Radio<String>(activeColor: color1,
//                                   value: 'Other',
//                                   groupValue: _selectedOption,
//                                   onChanged: _handleRadioValueChanged,
//                                 ),
//                                 text(context, 'Other', 15,fontWeight: FontWeight.w400,color: color)
//                               ],
//                             ),
//                           ])
//                     ],
//                   ),
//               ),
//
//             ),
//             Spacer(),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: containertext(
//                   context, 'SAVE'),
//             )
//           ],
//         )
//
//     );
//   }
// }
