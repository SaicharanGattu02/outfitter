import 'package:flutter/material.dart';
import 'package:outfitter/Screens/checkout.dart';
import 'package:outfitter/Screens/dashbord.dart';
import 'package:outfitter/providers/ShippingDetailsProvider.dart';
import 'package:outfitter/utils/CustomAppBar1.dart';
import 'package:provider/provider.dart';
import '../providers/CartProvider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int selectedIndex = 0;
  @override
  void initState() {
    GetCartList();
    super.initState();
  }

  Future<void> GetCartList() async {
    final cart_list_provider =
        Provider.of<CartProvider>(context, listen: false);
    final shipping_provider =
        Provider.of<ShippingDetailsProvider>(context, listen: false);
    cart_list_provider.fetchCartProducts();
    shipping_provider.fetchShippingDetails();
  }

  Color hexToColor(String hexColor) {
    final hex = hexColor.replaceAll('#', '');
    if (hex.length == 6) {
      return Color(
          int.parse('FF$hex', radix: 16)); // Adding FF for full opacity
    } else {
      throw FormatException("Invalid Hex color code");
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: CustomApp(title: 'Cart', w: w),
        body: Consumer<CartProvider>(builder: (context, cartProvider, child) {
          final cart_list = cartProvider.cartList;
          if (cartProvider.isLoading) {
            return Center(
                child: CircularProgressIndicator(
                  color: Color(0xffE7C6A0),
                ));
          } else if (cart_list.isEmpty) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: w * 0.4,
                  ),
                  Image.asset(
                    alignment: Alignment.center,
                    'assets/no_cart.png',
                    // Your "no items" image
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Cart is Empty",
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
                    "It Seems like you haven’t added anything to Your Cart yet!",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: 'RozhaOne',
                      fontSize: 16,
                      height: 18 / 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: w * 0.2,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dashbord()),
                      );
                    },
                    child: Container(
                      width: w * 0.5,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff110B0F),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          "Shop Now",
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
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                child: Column(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cart_list.length,
                      itemBuilder: (context, index) {
                        final cartItem = cart_list[index];
                        Color color = hexToColor(cartItem.color ?? "");
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xffFFFDF6),
                            border:
                                Border.all(color: Color(0xffF3EFE1), width: 1),
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
                                      border: Border.all(
                                          color: Color(0xffE7C6A0), width: 1),
                                    ),
                                    child: Center(
                                      child: Image.network(
                                        cartItem.product?.image ?? "",
                                        fit: BoxFit.contain,
                                        width: 100,
                                        height: 125,
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
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Color:",
                                              style: TextStyle(
                                                color: Color(0xff181725),
                                                fontFamily: 'RozhaOne',
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              maxLines: 2,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 18,
                                              height: 18,
                                              decoration: BoxDecoration(
                                                color: color,
                                                // Set the color of the container
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Size:",
                                              style: TextStyle(
                                                color: Color(0xff181725),
                                                fontFamily: 'RozhaOne',
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              maxLines: 2,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              cartItem.size,
                                              style: TextStyle(
                                                color: Color(0xff181725),
                                                fontFamily: 'RozhaOne',
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          ('₹ ${cartItem.product?.salePrice.toString() ?? ""}'),
                                          style: TextStyle(
                                            color: Color(0xff181725),
                                            fontFamily: 'RozhaOne',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          ('₹ ${cartItem.product?.mrp.toString() ?? ""}'),
                                          style: TextStyle(
                                            color: Color(0xffED1C24),
                                            fontFamily: 'RozhaOne',
                                            fontSize: 12,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: Color(0xffED1C24),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        InkResponse(
                                          onTap: () {
                                            if ((cartItem.quantity ?? 0) > 0) {
                                              // Decrease the quantity
                                              int newQuantity =
                                                  (cartItem.quantity ?? 0) - 1;
                                              cartProvider.updateQuantity(
                                                  cartItem.product?.id ?? "",
                                                  newQuantity);
                                              cartProvider.updateCartApi(
                                                  cartItem.product?.id ?? "",
                                                  newQuantity.toString());
                                            }
                                          },
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffE7C6A0),
                                                  width: 1),
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              size: 20,
                                              color: Color(0xffE7C6A0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        // Display quantity
                                        Text(
                                          cartItem.quantity.toString(),
                                          style: TextStyle(
                                            color: Color(0xffE7C6A0),
                                            fontFamily: 'RozhaOne',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(width: 8),
                                        InkResponse(
                                          onTap: () {
                                            int newQuantity =
                                                (cartItem.quantity ?? 0) + 1;
                                            cartProvider.updateQuantity(
                                                cartItem.product?.id ?? "",
                                                newQuantity);
                                            cartProvider.updateCartApi(
                                                cartItem.product?.id ?? "",
                                                newQuantity.toString());
                                          },
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffE7C6A0),
                                                  width: 1),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              size: 20,
                                              color: Color(0xffE7C6A0),
                                            ),
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
                  ],
                ),
              ),
            );
          }
        }),
        bottomNavigationBar: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            final cart_amount = cartProvider.cartAmount;
            if (cartProvider.isLoading) {
              return SizedBox
                  .shrink(); // Hide the bottom navigation bar when data is null or empty
            } else if (cart_amount == null ||
                cart_amount == null ||
                cart_amount == 0) {
              return SizedBox
                  .shrink(); // Hide the bottom navigation bar when data is null or empty
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  height: h * 0.04,
                  decoration: BoxDecoration(color: Color(0xff24AA72)),
                  child: Center(
                    child: Text(
                      "You are shopping at the best prices ",
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontFamily: 'RozhaOne',
                        fontSize: 12,
                        height: 19.36 / 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.008),
                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 5),
                  margin: EdgeInsets.only(bottom: 15, top: 5),
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
                              fontSize: 18,
                              height: 24 / 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "₹${cart_amount}",
                            style: TextStyle(
                              color: Color(0xff617C9D),
                              fontFamily: 'RozhaOne',
                              fontSize: 24,
                              height: 24 / 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutScreen()),
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Color(0xff110B0F),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              "CHECK OUT",
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
                ),
              ],
            );
          },
        )
        // Empty Container for other
        );
  }

  // Widget _buildItemList1(double w, double h) {
  //   return
  //     ListView.builder(
  //     padding: EdgeInsets.all(0),
  //     physics: NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     itemCount: grid.length,
  //     itemBuilder: (context, index) {
  //       final item = grid[index];
  //       int quantity = int.parse(item['quantity']!);
  //
  //       return Container(
  //         width: w,
  //         padding: EdgeInsets.all(16),
  //         decoration: BoxDecoration(
  //           color: Color(0xffFFFDF6),
  //           border: Border.all(color: Color(0xffF3EFE1), width: 1),
  //           borderRadius: BorderRadius.circular(7),
  //         ),
  //         margin: EdgeInsets.only(bottom: 16),
  //         child: Row(
  //           children: [
  //             Stack(
  //               children: [
  //                 Container(
  //                   decoration: BoxDecoration(
  //                     color: Color(0xffFFFFFF),
  //                     borderRadius: BorderRadius.circular(6),
  //                     border: Border.all(color: Color(0xffE7C6A0), width: 1),
  //                   ),
  //                   child: Center(
  //                     child: Image.asset(
  //                       item['image']!,
  //                       width: w * 0.25,
  //                       height: h * 0.16,
  //                     ),
  //                   ),
  //                 ),
  //                 Positioned(
  //                   top: 3,
  //                   right: 3,
  //                   child: Image.asset(
  //                     'assets/favLove.png',
  //                     width: 10,
  //                     height: 10,
  //                     fit: BoxFit.contain,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(width: w * 0.03),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     item['name']!,
  //                     style: TextStyle(
  //                       color: Color(0xff181725),
  //                       fontFamily: 'RozhaOne',
  //                       fontSize: 16,
  //                       height: 18 / 16,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                   SizedBox(height: h * 0.008),
  //                   Row(
  //                     children: List.generate(5, (starIndex) {
  //                       return Icon(
  //                         starIndex < int.parse(item['rating']!)
  //                             ? Icons.star
  //                             : Icons.star_border,
  //                         color: Color(0xffF79009),
  //                         size: 14,
  //                       );
  //                     }),
  //                   ),
  //                   SizedBox(height: h * 0.008),
  //                   Row(
  //                     children: [
  //                       Text(
  //                         item['price']!,
  //                         style: TextStyle(
  //                           color: Color(0xff181725),
  //                           fontFamily: 'RozhaOne',
  //                           fontSize: 18,
  //                           height: 21 / 18,
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ),
  //                       SizedBox(width: w * 0.02),
  //                       Text(
  //                         item['mrp']!,
  //                         style: TextStyle(
  //                           fontFamily: 'RozhaOne',
  //                           fontSize: 12,
  //                           decoration: TextDecoration.lineThrough,
  //                           decorationColor: Color(0xff617C9D),
  //                           height: 18 / 12,
  //                           color: Color(0xff617C9D),
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ),
  //                       SizedBox(width: w * 0.006),
  //                       Text(
  //                         '(70% off)',
  //                         style: TextStyle(
  //                           color: Color(0xff617C9D),
  //                           fontFamily: 'RozhaOne',
  //                           fontSize: 14,
  //                           height: 18 / 14,
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(height: h * 0.006),
  //                   Text(
  //                     'Only Few Left:',
  //                     style: TextStyle(
  //                       color: Color(0xffED1C24),
  //                       fontFamily: 'RozhaOne',
  //                       fontSize: 10,
  //                       height: 18 / 10,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                   SizedBox(height: h * 0.006),
  //                   Container(
  //                     width: w * 0.43,
  //                     height: h * 0.04,
  //                     decoration: BoxDecoration(
  //                       color: Color(0xff110B0F),
  //                       border: Border.all(color: Color(0xffCAA16C), width: 1),
  //                       borderRadius: BorderRadius.circular(6),
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         "MOVE TO CART",
  //                         style: TextStyle(
  //                           color: Color(0xffCAA16C),
  //                           fontFamily: 'RozhaOne',
  //                           fontSize: 16,
  //                           height: 21.06 / 16,
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
