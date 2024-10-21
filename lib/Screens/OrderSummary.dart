import 'package:flutter/material.dart';
import 'package:outfitter/utils/CustomAppBar1.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  final List<Map<String, String>> grid = [
    {
      "image": 'assets/hoodie.png',
      'name': 'Regular Fit Corduroy shirt',
      'rating': '4',
      'price': '₹ 1,196',
      'mrp': '₹ 4,999',
      'quantity': '1',
    },
    {
      "image": 'assets/jeans.png',
      'name': 'Regular Fit Jeans',
      'rating': '4',
      'price': '₹ 1,196',
      'mrp': '₹ 4,999',
      'quantity': '1',
    },
    {
      "image": 'assets/sleaves.png',
      'name': 'Stylish Sleeves Top',
      'rating': '4',
      'price': '₹ 1,196',
      'mrp': '₹ 4,999',
      'quantity': '1',
    },
  ];
  void _incrementQuantity(int index) {
    setState(() {
      grid[index]['quantity'] =
          (int.parse(grid[index]['quantity']!) + 1).toString();
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (int.parse(grid[index]['quantity']!) > 1) {
        grid[index]['quantity'] =
            (int.parse(grid[index]['quantity']!) - 1).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomApp(title: "Cart", w: w),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Color(0xff0AA44F), width: 1),
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
                          "Prashanth Chary",
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(0xffE8EFFB),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "Home",
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
                            "Address\n LVS Arcade, Plot No.71, Jubilee Enclave, HITEC City, Madhapur, Hyderabad, Telangana 500081",
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
              SizedBox(height: h * 0.008),
              _buildPaymentDetails(w, h),
              SizedBox(height: h * 0.008),
              _buildItemList(w, h),
              SizedBox(height: h * 0.008),
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                height: h * 0.04,
                decoration: BoxDecoration(color: Color(0xffE7C6A0)),
                child: Center(
                  child: Text(
                    "Available until 10hrs 30mins 20secs",
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'RozhaOne',
                      fontSize: 16,
                      height: 20 / 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      // bottomNavigationBar: Column(children: [
      //   Container(
      //     padding: EdgeInsets.only(top: 8, bottom: 8),
      //     height: h * 0.04,
      //     decoration: BoxDecoration(color: Color(0xffE7C6A0)),
      //     child: Center(
      //       child: Text(
      //         "Available until 10hrs 30mins 20secs",
      //         style: TextStyle(
      //           color: Color(0xff110B0F),
      //           fontFamily: 'RozhaOne',
      //           fontSize: 16,
      //           height: 20 / 16,
      //           fontWeight: FontWeight.w400,
      //         ),
      //         textAlign: TextAlign.center,
      //       ),
      //     ),
      //   ),
      //   Row(children: [
      //     Text(
      //       "₹5209",
      //       style: TextStyle(
      //         color: Color(0xff617C9D),
      //         fontFamily: 'RozhaOne',
      //         fontSize: 20,
      //         height: 24 / 20,
      //         fontWeight: FontWeight.w400,
      //       ),
      //     ),
      //     Spacer(),
      //     Container(
      //       width: w * 0.45,
      //       height: h*0.06,
      //       padding: EdgeInsets.all(12),
      //       decoration: BoxDecoration(
      //           border: Border.all(color: Color(0xff110B0F), width: 1),
      //           borderRadius: BorderRadius.circular(6)),
      //       child: Center(
      //         child: Text(
      //           "CHECK OUT",
      //           style: TextStyle(
      //             color: Color(0xffCAA16C),
      //             fontFamily: 'RozhaOne',
      //             fontSize: 16,
      //             height: 21.06 / 16,
      //             fontWeight: FontWeight.w400,
      //           ),
      //           textAlign: TextAlign.center,
      //         ),
      //       ),
      //     ),
      //
      //   ],)
      // ],),
    );
  }

  Widget _buildPaymentDetails(double w, double h) {
    return Container(
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
          _buildPaymentRow("Total Cost:", "₹5029"),
          _buildPaymentRow("Shipping Fee", "₹40"),
          _buildPaymentRow("Delivery Charges", "₹40"),
          _buildPaymentRow("Handling Charges", "₹4"),
          _buildPaymentRow("GST", "₹80"),
          _buildPaymentRow("Additional Discount", "-₹60", isDiscount: true),
          SizedBox(height: h * 0.01),
          Divider(thickness: 1, height: 1, color: Color(0xffF3EFE1)),
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
                "₹5209",
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
    return ListView.builder(
      padding: EdgeInsets.all(0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: grid.length,
      itemBuilder: (context, index) {
        final item = grid[index];

        // Ensure quantity is correctly parsed from string
        int quantity = int.parse(item['quantity']!);

        return Container(
          width: w,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xffFFFDF6),
            border: Border.all(color: Color(0xffF3EFE1), width: 1),
            borderRadius: BorderRadius.circular(7),
          ),
          margin: EdgeInsets.only(bottom: 16),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Color(0xffE7C6A0), width: 1),
                ),
                child: Center(
                  child: Image.asset(
                    item['image']!,
                    width: w * 0.28,
                    height: h * 0.16,
                  ),
                ),
              ),
              SizedBox(width: w * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name']!,
                      style: TextStyle(
                        color: Color(0xff181725),
                        fontFamily: 'RozhaOne',
                        fontSize: 16,
                        height: 18 / 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: h * 0.008),
                    Row(
                      children: List.generate(5, (starIndex) {
                        return Icon(
                          starIndex < int.parse(item['rating']!)
                              ? Icons.star
                              : Icons.star_border,
                          color: Color(0xffF79009),
                          size: 14,
                        );
                      }),
                    ),
                    SizedBox(height: h * 0.008),
                    Row(
                      children: [
                        Text(
                          item['price']!,
                          style: TextStyle(
                            color: Color(0xff181725),
                            fontFamily: 'RozhaOne',
                            fontSize: 18,
                            height: 21 / 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: w * 0.02),
                        Text(
                          "M.R.P",
                          style: TextStyle(
                            color: Color(0xffCAA16C),
                            fontFamily: 'RozhaOne',
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Color(0xffED1C24),
                            height: 18 / 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: w * 0.004),
                        Text(
                          item['mrp']!,
                          style: TextStyle(
                            color: Color(0xffED1C24),
                            fontFamily: 'RozhaOne',
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Color(0xffED1C24),
                            height: 18 / 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.008), // Corrected spacing
                    Container(
                      width: w * 0.37,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        border: Border.all(color: Color(0xfffE7C6A0), width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove,
                                size: 16, color: Color(0xfffE7C6A0)),
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                  item['quantity'] = quantity.toString();
                                });
                              }
                            },
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 6, right: 6, top: 4, bottom: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xfffE7C6A0), width: 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'RozhaOne',
                                    color: Color(0xff110B0F),
                                    height: 18 / 16,
                                    fontWeight: FontWeight.w400,
                                  ))),
                          IconButton(
                            icon: Icon(Icons.add, size: 16, color: Color(0xfffE7C6A0)),
                            onPressed: () {
                              setState(() {
                                quantity++;
                                item['quantity'] = quantity.toString();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
