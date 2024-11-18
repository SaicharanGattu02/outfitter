import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/AddressListModel.dart';
import '../providers/AddressProvider.dart';
import '../utils/CustomAppBar1.dart';
import '../utils/constants.dart';
import 'AddAddress.dart';

class AddressListScreen extends StatefulWidget {

  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {

  @override
  void initState() {
    GetAddressList();
    super.initState();
  }

  Future<void> GetAddressList() async {
    final address_list_provider =
        Provider.of<AddressListProvider>(context, listen: false);
    address_list_provider.fetchAddressList();
  }


  String groupValue="false";
  String? ID;
  void onChanged(String? id ,String? value) {
    setState(() {
      ID = id;
      groupValue = value??"false";
    });
    final address_list_provider =
    Provider.of<AddressListProvider>(context, listen: false);
    address_list_provider.defaultFromAddressList(ID??"");
  }


  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomApp(title: 'AddressList', w: w),
      body: Container(
        width: w,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/Drug Clam Background.png',
                ),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkResponse(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAddress(type: "Add",productid: "",),
                    ));
              },
              child: Container(
                width: w,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffCAA16C), width: 1),
                  color: Color(0xffffffff), // Button color
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize
                      .min, // To make the container size fit content
                  children: [
                    Icon(
                      Icons.add_location, // Choose an icon you prefer
                      color: Color(0xff000000), // Icon color
                    ),
                    SizedBox(width: 8), // Space between the icon and text
                    Text(
                      'Add Address',
                      style: TextStyle(
                        color: Color(0xff110B0F),
                        fontFamily: 'RozhaOne',
                        fontSize: 14,
                        height: 20 / 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Consumer<AddressListProvider>(
              builder: (context, addressProvider, child) {
                final address_list = addressProvider.addressList;

                // Find the id of the address with default_address == true
                String? defaultAddressId = address_list.firstWhere(
                        (address) => address.default_address == true,
                    orElse: () => AddressList()
                ).id;

                return Expanded(
                  child: ListView.builder(
                    itemCount: address_list.length,
                    itemBuilder: (context, index) {
                      final address = address_list[index];

                      return Card(
                        color: Color(0xffF3EFE1),
                        child: Padding(
                          padding: EdgeInsets.all(10.0), // Padding inside the card
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Use the address id as value and compare with default address id
                              Radio<String>(
                                activeColor: Color(0xffCAA16C),
                                value: address.id ?? "", // Each address's id as the value
                                groupValue: defaultAddressId,  // Compare with the id of the default address
                                onChanged: (value) {
                                  if (value != null) {
                                    addressProvider.updateSelectedAddress(value);
                                    addressProvider.defaultFromAddressList(value);
                                  }
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          address.name ?? "",
                                          style: TextStyle(
                                            color: Color(0xff110B0F),
                                            fontFamily: 'RozhaOne',
                                            fontSize: 14,
                                            height: 20 / 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          width: w * 0.06,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 4),
                                          decoration: BoxDecoration(
                                              color: Color(0xff000000).withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(4)),
                                          child: Text(
                                            address.addressType ?? "",
                                            style: TextStyle(
                                              color: Color(0xffCAA16C),
                                              fontFamily: 'RozhaOne',
                                              fontSize: 12,
                                              height: 20 / 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: w * 0.01,
                                    ),
                                    Text(
                                      address.address ?? "",
                                      style: TextStyle(
                                        color: Color(0xff617C9D),
                                        fontFamily: 'RozhaOne',
                                        fontSize: 12,
                                        height: 20 / 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      address.pincode ?? "",
                                      style: TextStyle(
                                        color: Color(0xff617C9D),
                                        fontFamily: 'RozhaOne',
                                        fontSize: 12,
                                        height: 20 / 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "Mobile No: ${address.mobile}",
                                      style: TextStyle(
                                        color: Color(0xff617C9D),
                                        fontFamily: 'RozhaOne',
                                        fontSize: 12,
                                        height: 20 / 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  customButton: const Icon(
                                    Icons.more_vert_rounded,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                  items: [
                                    ...MenuItems.firstItems.map(
                                          (item) => DropdownMenuItem<MenuItem>(
                                        value: item,
                                        child: MenuItems.buildItem(item),
                                      ),
                                    ),
                                    DropdownMenuItem<Divider>(enabled: false, child: Divider(color: Colors.white)),
                                  ],
                                  onChanged: (value) {
                                    MenuItems.onChanged(context, value! as MenuItem, address.id ?? "");
                                  },
                                  dropdownStyleData: DropdownStyleData(
                                    width: 120,
                                    padding: EdgeInsets.symmetric(vertical: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.white,
                                    ),
                                  ),
                                  menuItemStyleData: MenuItemStyleData(
                                    customHeights: [
                                      ...List<double>.filled(MenuItems.firstItems.length, 48),
                                      8,
                                    ],
                                    padding: const EdgeInsets.only(left: 16, right: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

}



class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [edit, remove,];


  static const edit = MenuItem(text: 'Edit', icon: Icons.edit);
  static const remove = MenuItem(text: 'Remove', icon: Icons.delete_outlined);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.black, size: 18),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item,String addressID) {

    Future<void> delateAddress() async{
      final address_delate_provider = Provider.of<AddressListProvider>(context, listen: false);
      address_delate_provider.removFromAddressList(addressID);
    }
    switch (item) {
      case MenuItems.edit:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress(type: "Edit", productid: addressID)));

        break;
      case MenuItems.remove:

        delateAddress();
        break;
    }
  }
}
