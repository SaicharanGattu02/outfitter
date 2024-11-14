//
// import 'package:flutter/material.dart';
//
// import '../utils/CustomAppBar1.dart';
// import '../utils/constants.dart';
// import 'AddAddress.dart';
//
// class AddressListScreen extends StatefulWidget {
//   @override
//   _AddressListScreenState createState() => _AddressListScreenState();
// }
//
// class _AddressListScreenState extends State<AddressListScreen> {
//   // List of addresses (simulating a model with address and mobile number)
//   List<Map<String, String>> addressList = [
//     {
//       'address':
//           '303, The Platina, A-Block, Jayabheri Enclave,Gachibowli, Hyderabad, Telangana 500032',
//       'mobile': '9876543210'
//     },
//     {
//       'address':
//           '303, The Platina, A-Block, Jayabheri Enclave,Gachibowli, Hyderabad, Telangana 500032',
//       'mobile': '9123456789'
//     },
//     {
//       'address':
//           '303, The Platina, A-Block, Jayabheri Enclave,Gachibowli, Hyderabad, Telangana 500032t',
//       'mobile': '8234567890'
//     },
//   ];
//
//   // Radio button value for selected address
//   String? selectedAddress;
//
//   // Function to handle address selection
//   void _onAddressSelected(String? value) {
//     setState(() {
//       selectedAddress = value;
//     });
//   }
//
//   void _addAddress() {
//     setState(() {
//       addressList.add({'address': 'New Address', 'mobile': '1234567890'});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar:  CustomApp(title: 'AddressList', w: w),
//       body: Container(
//         width: w,
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage(
//                   'assets/Drug Clam Background.png',
//                 ),
//                 fit: BoxFit.cover)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             InkResponse(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AddAddress(),
//                     ));
//               },
//               child: Container(
//                 width: w,
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 decoration: BoxDecoration(
//                   color: color4, // Button color
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize
//                       .min, // To make the container size fit content
//                   children: [
//                     Icon(
//                       Icons.add_location, // Choose an icon you prefer
//                       color: color1, // Icon color
//                     ),
//                     SizedBox(width: 8), // Space between the icon and text
//                     Text(
//                       'Add Address',
//                       style: TextStyle(
//                           color: color, // Text color
//                           fontWeight: FontWeight.w400,
//                           fontFamily: "Inter",
//                           fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//
//             // List of Addresses
//             Expanded(
//               child: ListView.builder(
//                 itemCount: addressList.length,
//                 itemBuilder: (context, index) {
//                   String address = addressList[index]['address']!;
//                   String mobile = addressList[index]['mobile']!;
//
//                   return Card(
//                     color: color4,
//                     child: Padding(
//                       padding: EdgeInsets.all(10.0), // Padding inside the card
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Radio<String>(
//                             value: mobile,
//                             groupValue: selectedAddress,
//                             onChanged: _onAddressSelected,
//                             activeColor: color1,
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Prashanth Chary",
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                       fontFamily: "Inter",
//                                       color: color11),
//                                 ),
//                                 Text(
//                                   address,
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                       fontFamily: "Inter",
//                                       color: color),
//                                 ),
//                                 Text(
//                                   "Mobile No: ${mobile}",
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontFamily: "Inter",
//                                       color: color,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Info IconButton on the right side
//                           IconButton(
//                             padding: EdgeInsets.all(0),
//                             icon: Image.asset(
//                               "assets/DOT.png",
//                               width: 4,
//                               height: 18,
//                             ),
//                             onPressed: () {},
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
