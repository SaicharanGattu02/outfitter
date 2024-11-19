import 'package:flutter/material.dart';
import 'package:outfitter/Screens/OrderDetailsScreen.dart';

import '../Model/OrdersListModel.dart';
import '../Services/UserApi.dart';
import '../utils/CustomAppBar1.dart';
import '../utils/CustomSnackBar.dart';
import 'dart:developer' as developer;
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import '../Services/otherservices.dart';


class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  List<OrdersList> orders_list = []; // Original list
  List<OrdersList> filteredOrders = [];
  String selectedSort = 'Last 30 days';
  final List<String> sortOptions = [
    'Last 30 days',
    'Last 6 month',
    'Last 1 year',

  ];

  final Map<String, String> sortOptionToValue = {
    'Last 30 days' :'last_30_days',
    'Last 6 month':'last_6_months',
    'Last 1 year':'last_year'
  };
// Filtered list for search
  @override
  void initState() {
    filteredOrders = orders_list; // Initially show all orders
    _searchController.addListener(_filterOrders); // Listen to changes in the search bar
    OrdersListApi('last_30_days   '); // Fetch orders list
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


  final spinkits=Spinkits1();
  void _filterOrders() {
    setState(() {
      filteredOrders = orders_list
          .where((order) {
        // Check if orderid contains the search text (case insensitive)
        bool matchesOrderId = order.orderid?.toLowerCase().contains(_searchController.text.toLowerCase()) ?? false;

        // Check if orderValue contains the search text (case insensitive)
        bool matchesOrderValue = order.orderValue.toString().contains(_searchController.text);

        // Return true if either orderid or orderValue matches the search query
        return matchesOrderId || matchesOrderValue;
      })
          .toList();
    });
  }


  Future<void> OrdersListApi(String selectdate) async {
    try {
      final res = await Userapi.getOrdersList(selectdate);
      if (res != null) {
        setState(() {
          if (res.settings?.success == 1) {
            orders_list = res.data ?? [];
            filteredOrders = res.data ?? [];
            isLoading = false; // Hide loader if error occurs
          } else {
            CustomSnackBar.show(context, res.settings?.message ?? "");
            isLoading = false;
          }
        });
      }
    } catch (e) {
      CustomSnackBar.show(context, "Failed to load orders.");
    } finally {

    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return
      (isDeviceConnected == "ConnectivityResult.wifi" ||
          isDeviceConnected == "ConnectivityResult.mobile")
          ?
      Scaffold(
        appBar: CustomApp(title: 'Order List', w: w),
        body:isLoading?Center(child:CircularProgressIndicator(color: Color(0xffE7C6A0),)):
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: w * 0.7,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xffF1F2F7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/search.png",
                              width: 20,
                              height: 20,
                              color: Color(0xffCAA16C),
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                  hintText: 'Search',
                                  hintStyle: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Color(0xffCAA16C),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: "Nunito",
                                  ),
                                ),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    decorationColor: Color(0xff9E7BCA),
                                    fontFamily: "Nunito",
                                    overflow: TextOverflow.ellipsis),
                                textAlignVertical: TextAlignVertical.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        "assets/filter.png",
                        color: Color(0xffCAA16C),
                        width: w*0.05,
                        height: h*0.04,
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          _bottomSheet(context);
                        },
                        child:
                        Text(
                          "FILTER",
                          style: TextStyle(
                            color: Color(0xffCAA16C),
                            fontFamily: 'RozhaOne',
                            fontSize: 16,
                            height: 24 / 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),


                      ),

                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (filteredOrders.length == 0) ...[
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: w * 0.2,
                          ),
                          Image.asset(
                            alignment: Alignment.center,
                            'assets/no_order_history.png', // Your "no items" image
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "No Address Found",
                            style: TextStyle(
                              color: Color(0xffCAA16C),
                              fontFamily: 'RozhaOne',
                              fontSize: 22,
                              height: 18 / 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "You have no any delivery location add delivery address first.",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontFamily: 'RozhaOne',
                              fontSize: 16,
                              height: 18 / 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        final item = filteredOrders[index];
                        return InkResponse(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetailScreen(
                                            id: item.id.toString(),
                                          )));
                            },
                            child: Container(
                              width: w,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xffFFFDF6),
                                border: Border.all(
                                    color: Color(0xffF3EFE1), width: 1),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              margin: EdgeInsets.only(bottom: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order ID",
                                            style: TextStyle(
                                              color: Color(0xff617C9D),
                                              fontFamily: 'RozhaOne',
                                              fontSize: 14,
                                              height: 19 / 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            item.orderid ?? "",
                                            style: TextStyle(
                                              color: Color(0xff181725),
                                              fontFamily: 'RozhaOne',
                                              fontSize: 16,
                                              height: 19 / 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Date",
                                            style: TextStyle(
                                              color: Color(0xff617C9D),
                                              fontFamily: 'RozhaOne',
                                              fontSize: 14,
                                              height: 19 / 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            item.createdAt ?? "",
                                            style: TextStyle(
                                              color: Color(0xff181725),
                                              fontFamily: 'RozhaOne',
                                              fontSize: 16,
                                              height: 19 / 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Payment Status",
                                    style: TextStyle(
                                      color: Color(0xff617C9D),
                                      fontFamily: 'RozhaOne',
                                      fontSize: 14,
                                      height: 19 / 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.paymentMethod ?? "",
                                        style: TextStyle(
                                          color: Color(0xff181725),
                                          fontFamily: 'RozhaOne',
                                          fontSize: 16,
                                          height: 19 / 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text("₹${item.orderValue.toString()}",
                                        style: TextStyle(
                                          color: Color(0xff181725),
                                          fontFamily: 'RozhaOne',
                                          fontSize: 20,
                                          height: 19 / 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      },
                    )
                  ]
                ]),
          ),
        )):NoInternetWidget();
  }  void _bottomSheet(
      BuildContext context,
      ) {
    double h = MediaQuery.of(context).size.height * 0.35;
    double w = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                        height: h,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 20),
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  width: w * 0.1,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    'Order Time',
                                    style: TextStyle(
                                      color: Color(0xff1C1D22),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontFamily: 'RozhaOne',
                                      height: 18 / 16,
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {

                                      Navigator.of(context)
                                          .pop(); // Close the BottomSheet when tapped
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      width: w * 0.06,
                                      height: w * 0.06,
                                      decoration: BoxDecoration(
                                        color: Color(0xffE5E5E5),
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/crossblue.png",
                                          fit: BoxFit.contain,
                                          width: w * 0.023,
                                          height: w * 0.023,
                                          color: Color(0xffCAA16C),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: sortOptions.length,
                                itemBuilder: (context, index) {
                                  return RadioListTile<String>(
                                    activeColor: Color(0xffCAA16C),
                                    value: sortOptions[index],
                                    groupValue: selectedSort,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSort = value!;
                                        String sortValue =
                                        sortOptionToValue[selectedSort]!;
                                        OrdersListApi(sortValue);

                                      });
                                      Navigator.pop(
                                          context); // Close the dialog after selection
                                    },
                                    title: Text(sortOptions[index]),
                                  );
                                },
                              ),

                            ])));
              });
        });
  }


}
