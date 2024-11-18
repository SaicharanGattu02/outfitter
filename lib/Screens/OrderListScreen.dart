import 'package:flutter/material.dart';
import 'package:outfitter/Screens/OrderDetailsScreen.dart';

import '../Model/OrdersListModel.dart';
import '../Services/UserApi.dart';
import '../utils/CustomAppBar1.dart';
import '../utils/CustomSnackBar.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  TextEditingController _searchController = TextEditingController();
  bool isLoading = true;
  List<OrdersList> orders_list = []; // Original list
  List<OrdersList> filteredOrders = []; // Filtered list for search
  @override
  void initState() {
    filteredOrders = orders_list; // Initially show all orders
    _searchController.addListener(_filterOrders); // Listen to changes in the search bar
    OrdersListApi(); // Fetch orders list
    super.initState();
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


  Future<void> OrdersListApi() async {
    try {
      final res = await Userapi.getOrdersList();
      if (res != null) {
        setState(() {
          if (res.settings?.success == 1) {
            orders_list = res.data ?? [];
            filteredOrders = res.data ?? [];
            isLoading = false; // Hide loader if error occurs
          } else {
            CustomSnackBar.show(context, res.settings?.message ?? "");
            isLoading = false; // Hide loader if error occurs
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
    return Scaffold(
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
                        width: w * 0.8,
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
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          "assets/calender.png",
                          width: 22,
                          height: 22,
                          color: Color(0xffCAA16C),
                          fit: BoxFit.contain,
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
        ));
  }
}
