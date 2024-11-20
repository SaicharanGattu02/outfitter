import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:outfitter/Services/UserApi.dart';
import '../Model/OrderDetailsModel.dart';
import '../utils/CustomAppBar1.dart';
import 'dart:developer' as developer;
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import '../Services/otherservices.dart';
import '../utils/CustomSnackBar.dart';

class OrderDetailScreen extends StatefulWidget {
  final String id;
  OrderDetailScreen({super.key, required this.id});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool isLoading = true;
  OrderDetails? orderDetail;
  final spinkits = Spinkits3();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  var isDeviceConnected = "";
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    getOrderDetailsApi();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

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

  Future<void> getOrderDetailsApi() async {
    try {
      var res = await Userapi.getOrderDetails(widget.id);
      if (res != null) {
        setState(() {
          if (res.settings?.success == 1) {
            orderDetail = res.data;
            print("OrderDetail data: $orderDetail"); // For debugging
          } else {
            print(
                "API response status is not successful: ${res.settings?.status}");
          }
          isLoading = false;
        });
      } else {
        print("API response is null");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching order details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return (isDeviceConnected == "ConnectivityResult.wifi" ||
            isDeviceConnected == "ConnectivityResult.mobile")
        ? Scaffold(
            appBar: CustomApp(title: 'Order Details', w: w),
            body: isLoading
                ? Center(child: CircularProgressIndicator())
                : orderDetail == null
                    ? Center(child: Text("No Order Details Available"))
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "Order ID: ${orderDetail?.orderId ?? 'N/A'}",
                                    style: TextStyle(
                                      color: Color(0xff181725),
                                      fontFamily: 'RozhaOne',
                                      fontSize: 16,
                                      height: 19 / 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  // Spacer(),
                                  // Text(
                                  //   orderDetail?.?? "N/A",
                                  //   style: TextStyle(
                                  //     color: Color(0xff617C9D),
                                  //     fontFamily: 'RozhaOne',
                                  //     fontSize: 14,
                                  //     height: 19 / 14,
                                  //     fontWeight: FontWeight.w400,
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(height: 10),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: orderDetail?.items?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final item = orderDetail?.items?[index];
                                  return Container(
                                    width: w,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Color(0xffFFFDF6),
                                      border: Border.all(
                                          color: Color(0xffF3EFE1), width: 1),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    margin: EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xffFFFFFF),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: Color(0xffE7C6A0),
                                                    width: 1),
                                              ),
                                              child: Center(
                                                  child: CachedNetworkImage(
                                                imageUrl: item
                                                        ?.product?.image ??
                                                    "", // Placeholder in case image is null
                                                width: w * 0.2,
                                                height: h * 0.1,
                                                fit: BoxFit.contain,
                                                placeholder:
                                                    (BuildContext context,
                                                        String url) {
                                                  return Center(
                                                    child: spinkits
                                                        .getSpinningLinespinkit(),
                                                  );
                                                },
                                                errorWidget:
                                                    (BuildContext context,
                                                        String url,
                                                        dynamic error) {
                                                  // Handle error in case the image fails to load
                                                  return Icon(Icons.error);
                                                },
                                              )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: w * 0.03),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item?.product?.title ??
                                                    "No Title", // Default value if null
                                                style: TextStyle(
                                                  color: Color(0xff181725),
                                                  fontFamily: 'RozhaOne',
                                                  fontSize: 16,
                                                  height: 18 / 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              // SizedBox(height: h * 0.008),
                                              // Row(
                                              //   children:
                                              //       List.generate(5, (starIndex) {
                                              //     int rating = 0;
                                              //     if (item?.product?.rating != null) {
                                              //       rating = int.tryParse(item
                                              //                   ?.product?.rating
                                              //                   .toString() ??
                                              //               "") ??
                                              //           0;
                                              //     }
                                              //     return Icon(
                                              //       starIndex < rating
                                              //           ? Icons.star
                                              //           : Icons.star_border,
                                              //       color: Color(0xffF79009),
                                              //       size: 14,
                                              //     );
                                              //   }),
                                              // ),
                                              SizedBox(height: h * 0.008),
                                              Row(
                                                children: [
                                                  Text(
                                                    "₹${item?.product?.salePrice?.toString() ?? ""}", // Default value if null
                                                    style: TextStyle(
                                                      color: Color(0xff181725),
                                                      fontFamily: 'RozhaOne',
                                                      fontSize: 18,
                                                      height: 21 / 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(width: w * 0.02),
                                                  Text(
                                                    "₹${item?.product?.mrp?.toString() ?? ""}",
                                                    style: TextStyle(
                                                      color: Color(0xffED1C24),
                                                      fontFamily: 'RozhaOne',
                                                      fontSize: 12,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                          Color(0xffED1C24),
                                                      height: 18 / 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Color(0xffFFFDF6),
                                  border: Border.all(
                                      color: Color(0xffF3EFE1), width: 1),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person_outline_rounded,
                                            color: Color(0xffCAA16C), size: 18),
                                        SizedBox(width: w * 0.02),
                                        Text(
                                          orderDetail?.address?.fullName ?? "",
                                          style: TextStyle(
                                            color: Color(0xff110B0F),
                                            fontFamily: 'RozhaOne',
                                            fontSize: 18,
                                            height: 28 / 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(width: w * 0.04),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Color(0xffE8EFFB),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            orderDetail?.address?.addressType ??
                                                "",
                                            style: TextStyle(
                                              color: Color(0xff110B0F),
                                              fontFamily: 'RozhaOne',
                                              fontSize: 12,
                                              height: 18 / 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: h * 0.01),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.location_on_rounded,
                                            color: Color(0xffCAA16C), size: 18),
                                        SizedBox(width: w * 0.02),
                                        Flexible(
                                          child: Text(
                                            "Address\n ${orderDetail?.address?.address}",
                                            style: TextStyle(
                                              color: Color(0xff110B0F),
                                              fontFamily: 'RozhaOne',
                                              fontSize: 14,
                                              height: 21 / 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: w,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Color(0xffFFFDF6),
                                  border: Border.all(
                                      color: Color(0xffF3EFE1), width: 1),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Payment Details",
                                      style: TextStyle(
                                        color: Color(0xff110B0F),
                                        fontFamily: 'RozhaOne',
                                        fontSize: 18,
                                        height: 28 / 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: h * 0.008),
                                    _buildPaymentRow("Total Cost:",
                                        "₹${orderDetail?.orderValue.toString() ?? ""}"),
                                    _buildPaymentRow("Shipping Fee",
                                        "₹${orderDetail?.shipping?.shippingFee.toString() ?? ""}"),
                                    _buildPaymentRow("Delivery Charges",
                                        "₹${orderDetail?.shipping?.deliveryCharges.toString() ?? ""}"),
                                    _buildPaymentRow("Handling Charges",
                                        "₹${orderDetail?.shipping?.handlingCharges.toString() ?? ""}"),
                                    // _buildPaymentRow("GST", "₹80"),
                                    _buildPaymentRow("Additional Discount",
                                        "₹${orderDetail?.shipping?.discount.toString() ?? ""}",
                                        isDiscount: true),
                                    SizedBox(height: h * 0.01),
                                    Divider(
                                        thickness: 1,
                                        height: 1,
                                        color: Color(0xffF3EFE1)),
                                    SizedBox(height: h * 0.01),
                                    Row(
                                      children: [
                                        Text(
                                          "Total Amount",
                                          style: TextStyle(
                                            color: Color(0xff617C9D),
                                            fontFamily: 'RozhaOne',
                                            fontSize: 20,
                                            height: 24 / 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "₹${orderDetail?.orderValue.toString()}",
                                          style: TextStyle(
                                            color: Color(0xff617C9D),
                                            fontFamily: 'RozhaOne',
                                            fontSize: 20,
                                            height: 24 / 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
          )
        : NoInternetWidget();
  }

  Widget _buildPaymentRow(String label, String amount,
      {bool isDiscount = false}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xff617C9D),
            fontFamily: 'RozhaOne',
            fontSize: 14,
            height: 19 / 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Spacer(),
        Text(
          amount,
          style: TextStyle(
            color: isDiscount ? Color(0xffE05F2B) : Color(0xff110B0F),
            fontFamily: 'RozhaOne',
            fontSize: 16,
            height: 24 / 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
