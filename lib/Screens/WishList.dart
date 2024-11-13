import 'package:flutter/material.dart';
import 'package:outfitter/utils/CustomAppBar1.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
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
      appBar: CustomApp(title: 'WishList', w: w),
      body:Column(
        children: [
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
                        width: w * 0.25,
                        height: h * 0.16,
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
                          item['mrp']!,
                          style: TextStyle(
                            fontFamily: 'RozhaOne',
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Color(0xff617C9D),
                            height: 18 / 12,
                            color: Color(0xff617C9D),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: w * 0.006),
                        Text(
                          '(70% off)',
                          style: TextStyle(
                            color: Color(0xff617C9D),
                            fontFamily: 'RozhaOne',
                            fontSize: 14,
                            height: 18 / 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.006),
                    Text(
                      'Only Few Left:',
                      style: TextStyle(
                        color: Color(0xffED1C24),
                        fontFamily: 'RozhaOne',
                        fontSize: 10,
                        height: 18 / 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: h * 0.006),
                    Container(
                      width: w * 0.43,
                      height: h * 0.04,
                      decoration: BoxDecoration(
                        color: Color(0xff110B0F),
                        border: Border.all(color: Color(0xffCAA16C), width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          "MOVE TO CART",
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
                  ],
                ),
              ),
            ],
          ),
        );
      },
    )
        ],
      ) ,

    );
  }
}
