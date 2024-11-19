import 'package:flutter/material.dart';
import 'package:outfitter/Screens/AddressList.dart';
import 'package:outfitter/Screens/OrderListScreen.dart';
import 'package:outfitter/utils/CustomAppBar1.dart';
import 'package:outfitter/utils/CustomSnackBar.dart';
import 'package:provider/provider.dart';

import '../Model/ShippingDetailsModel.dart';
import '../Services/UserApi.dart';
import '../providers/CartProvider.dart';
import '../providers/ShippingDetailsProvider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int order_value = 0;
  String address = "";
  String product = "";
  List<String> items = [];

  Future<void> PlacerOrderApi() async {
    await Userapi.placeOrder(order_value, address, items).then((data) => {
          if (data != null)
            {
              setState(() {
                if (data.settings?.success == 1) {
                  CustomSnackBar.show(context, "Order Placed Successfully!");
                  final cart_list_provider = Provider.of<CartProvider>(context, listen: false);
                  cart_list_provider.fetchCartProducts();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderListScreen(),));
                } else {
                  CustomSnackBar.show(context, data.settings?.message ?? "");
                }
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomApp(title: "Checkout", w: w),
      body: Consumer<ShippingDetailsProvider>(
          builder: (context, shippingProvider, child) {
        final shipping_data = shippingProvider.shippingData;
        if (shipping_data?.address != null) {
          if (shipping_data?.address is Address) {
            address = shipping_data?.address?.id?? "";
          }
        }
        // Handle null or invalid shipping_data cases
        order_value = shipping_data?.totalAmount ?? 0;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (address.isNotEmpty && address != "No address found") ...[
                  Row(
                    children: [
                      Text(
                        "Delivery To",
                        style: TextStyle(
                          color: Color(0xff110B0F),
                          fontFamily: 'RozhaOne',
                          fontSize: 20,
                          height: 28 / 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      InkResponse(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddressListScreen(),
                              ));
                        },
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border:
                            Border.all(color: Color(0xff0AA44F), width: 1),
                          ),
                          child: Text(
                            "Change",
                            style: TextStyle(
                              color: Color(0xff0AA44F),
                              fontFamily: 'RozhaOne',
                              fontSize: 16,
                              height: 28 / 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.01),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xffFFFDF6),
                      border: Border.all(color: Color(0xffF3EFE1), width: 1),
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
                              shipping_data?.address?.fullName ?? "",
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
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                shipping_data?.address?.addressType ?? "",
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on_rounded,
                                color: Color(0xffCAA16C), size: 18),
                            SizedBox(width: w * 0.02),
                            Flexible(
                              child: Text(
                                "Address\n ${shipping_data?.address?.address}",
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
                ],
                SizedBox(height: h * 0.008),
                Container(
                  width: w,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFDF6),
                    border: Border.all(color: Color(0xffF3EFE1), width: 1),
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
                          "₹${shipping_data?.totalAmount.toString() ?? ""}"),
                      _buildPaymentRow("Shipping Fee",
                          "₹${shipping_data?.shippingFee.toString() ?? ""}"),
                      _buildPaymentRow("Delivery Charges",
                          "₹${shipping_data?.deliveryCharges.toString() ?? ""}"),
                      _buildPaymentRow("Handling Charges",
                          "₹${shipping_data?.handlingCharges.toString() ?? ""}"),
                      // _buildPaymentRow("GST", "₹80"),
                      _buildPaymentRow("Additional Discount",
                          "₹${shipping_data?.discount.toString() ?? ""}",
                          isDiscount: true),
                      SizedBox(height: h * 0.01),
                      Divider(
                          thickness: 1, height: 1, color: Color(0xffF3EFE1)),
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
                            "₹${shipping_data?.totalAmount.toString() ?? ""}",
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
                ),
                SizedBox(height: h * 0.008),
                _buildItemList(w, h),
                SizedBox(height: h * 0.008),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar:
          // Container(
          //   padding: EdgeInsets.only(top: 8, bottom: 8),
          //   height: h * 0.04,
          //   decoration: BoxDecoration(color: Color(0xffE7C6A0)),
          //   child: Center(
          //     child: Text(
          //       "Available until 10hrs 30mins 20secs",
          //       style: TextStyle(
          //         color: Color(0xff110B0F),
          //         fontFamily: 'RozhaOne',
          //         fontSize: 16,
          //         height: 20 / 16,
          //         fontWeight: FontWeight.w400,
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          //
          //
          // ),

          Consumer<ShippingDetailsProvider>(
              builder: (context, shippingProvider, child) {
        final shipping_data = shippingProvider.shippingData;
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 5),
          margin: EdgeInsets.symmetric(vertical: 10,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Total: ",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: 'RozhaOne',
                      fontSize: 20,
                      height: 24 / 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "₹${shipping_data?.totalAmount.toString() ?? ""}",
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
              InkWell(
                onTap: () {
                  if (address.isNotEmpty && address != "No address found"){
                    PlacerOrderApi();
                  }else{
                    CustomSnackBar.show(context, "Please Select address!");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddressListScreen(),));
                  }
                },
                child: Container(
                  width: w * 0.45,
                  height: h * 0.05,
                  // padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xff110B0F),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      "PLACE ORDER",
                      style: TextStyle(
                        color: Color(0xffCAA16C),
                        fontFamily: 'RozhaOne',
                        fontSize: 16,
                        height: 21.06 / 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
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

  Widget _buildItemList(double w, double h) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final cart_list = cartProvider.cartList;
        if (cart_list.isEmpty) {
          return Center(
            child: Text(
              "No data found", // Text when cart is empty
              style: TextStyle(
                fontSize: 18,
                color: Colors.black45,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cart_list.length,
          itemBuilder: (context, index) {
            final cartItem = cart_list[index];
            // Add each item's ID to the items list
            if (cartItem.id != null) {
              items.add(cartItem.id ?? ""); // Add item ID to the list
            }
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xffFFFDF6),
                border: Border.all(color: Color(0xffF3EFE1), width: 1),
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
                          borderRadius: BorderRadius.circular(6),
                          border:
                              Border.all(color: Color(0xffE7C6A0), width: 1),
                        ),
                        child: Center(
                          child: Image.network(
                            cartItem.product?.image ?? "",
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItem.product?.title ?? "",
                          style: TextStyle(
                            color: Color(0xff181725),
                            fontFamily: 'RozhaOne',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                        ),
                        Row(
                          children: [
                            // InkResponse(
                            //   onTap: () {
                            //     if ((cartItem.quantity ?? 0) > 0) {
                            //       // Decrease the quantity
                            //       int newQuantity =
                            //           (cartItem.quantity ?? 0) - 1;
                            //       cartProvider.updateQuantity(
                            //           cartItem.product?.id ?? "", newQuantity);
                            //       cartProvider.updateCartApi(
                            //           cartItem.product?.id ?? "",
                            //           newQuantity.toString());
                            //     }
                            //   },
                            //   child: Container(
                            //     width: 30,
                            //     height: 30,
                            //     decoration: BoxDecoration(
                            //       border: Border.all(
                            //           color: Color(0xffE7C6A0), width: 1),
                            //     ),
                            //     child: Icon(
                            //       Icons.remove,
                            //       size: 20,
                            //       color: Color(0xffE7C6A0),
                            //     ),
                            //   ),
                            // ),
                            Text(
                              "Total Quantity:",
                              style: TextStyle(
                                color: Color(0xff181725),
                                fontFamily: 'RozhaOne',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 8),
                            // Display quantity
                            Text(
                              cartItem.quantity.toString(),
                              style: TextStyle(
                                color: Color(0xffE7C6A0),
                                fontFamily: 'RozhaOne',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 8),
                            // InkResponse(
                            //   onTap: () {
                            //     int newQuantity = (cartItem.quantity ?? 0) + 1;
                            //     cartProvider.updateQuantity(
                            //         cartItem.product?.id ?? "", newQuantity);
                            //     cartProvider.updateCartApi(
                            //         cartItem.product?.id ?? "",
                            //         newQuantity.toString());
                            //   },
                            //   child: Container(
                            //     width: 30,
                            //     height: 30,
                            //     decoration: BoxDecoration(
                            //       border: Border.all(
                            //           color: Color(0xffE7C6A0), width: 1),
                            //     ),
                            //     child: Icon(
                            //       Icons.add,
                            //       size: 20,
                            //       color: Color(0xffE7C6A0),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("₹${cartItem.product?.salePrice.toString() ?? ""}",
                              style: TextStyle(
                                color: Color(0xff181725),
                                fontFamily: 'RozhaOne',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 8),
                            // Text(
                            //   "M.R.P",
                            //   style: TextStyle(
                            //     color: Color(0xffCAA16C),
                            //     fontFamily: 'RozhaOne',
                            //     fontSize: 12,
                            //     decoration: TextDecoration.lineThrough,
                            //     height: 1.5,
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                            // SizedBox(width: 4),
                            Text(
                              "₹${cartItem.product?.mrp.toString() ?? ""}",
                              style: TextStyle(
                                color: Color(0xffED1C24),
                                fontFamily: 'RozhaOne',
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                decorationColor:Color(0xffED1C24),
                                fontWeight: FontWeight.w400,
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
        );
      },
    );
  }
}
