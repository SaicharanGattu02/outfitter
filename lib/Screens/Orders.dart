import 'package:flutter/material.dart';
import 'package:outfitter/utils/CustomAppBar1.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
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

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomApp(title: 'Orders', w: w),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Order ID: 3354654654526',
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'RozhaOne',
                      fontSize: 16,
                      height: 21 / 16,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '14-10-2024',
                  style: TextStyle(
                    color: Color(0xff617C9D),
                    fontFamily: 'RozhaOne',
                    fontSize: 14,
                    height: 19 / 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.008),
            ListView.builder(

              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: grid.length,
              itemBuilder: (context, index) {
                final item = grid[index];
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
                    children: [
                      Stack(
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
                                width: w * 0.2,
                                height: h * 0.1,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 3,
                            right: 3,
                            child: Image.asset(
                              'assets/favLove.png',
                              width: 10,
                              height: 10,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
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
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: h * 0.008),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Order ID: 3354654654526',
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'RozhaOne',
                      fontSize: 16,
                      height: 21 / 16,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '18-10-2024',
                  style: TextStyle(
                    color: Color(0xff617C9D),
                    fontFamily: 'RozhaOne',
                    fontSize: 14,
                    height: 19 / 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.008),
            ListView.builder(
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: grid.length,
              itemBuilder: (context, index) {
                final item = grid[index];
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
                    children: [
                      Stack(
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
                                width: w * 0.2,
                                height: h * 0.1,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 3,
                            right: 3,
                            child: Image.asset(
                              'assets/favLove.png',
                              width: 10,
                              height: 10,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
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
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],),
        ),
      ),
    );
  }
}
