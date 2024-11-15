import 'package:flutter/material.dart';
import '../utils/CustomAppBar1.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
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
        appBar: CustomApp(title: 'Order Details', w: w),
        body: SingleChildScrollView(
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
                                    // controller: _searchController,
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
                                        color: Color(0xff9E7BCA),
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
                              "assets/filter.png",
                              width: 22,
                              height: 22,
                              color: Color(0xffCAA16C),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Filters",
                            style: TextStyle(
                              color: Color(0xffCAA16C),
                              fontFamily: 'RozhaOne',
                              fontSize: 16,
                              height: 19 / 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(children: [
                        Text(
                          "Order ID:0D117216332413925000",
                          style: TextStyle(
                            color: Color(0xff181725),
                            fontFamily: 'RozhaOne',
                            fontSize: 16,
                            height: 19 / 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "21-11-2024",
                          style: TextStyle(
                            color: Color(0xff617C9D),
                            fontFamily: 'RozhaOne',
                            fontSize: 14,
                            height: 19 / 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],),
                      SizedBox(height: 10,),

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

                                          SizedBox(width: w * 0.004),
                                          Text(
                                            item['mrp']!,
                                            style: TextStyle(
                                              color: Color(0xff617C9D),
                                              fontFamily: 'RozhaOne',
                                              fontSize: 12,
                                              decoration: TextDecoration.lineThrough,
                                              decorationColor: Color(0xff617C9D),
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
                      SizedBox(height: 10,),

                      InkResponse(onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderSummary()));
                      },
                        child: Text(
                          "Delivery Address",
                          style: TextStyle(
                            color: Color(0xff181725),
                            fontFamily: 'RozhaOne',
                            fontSize: 16,
                            height: 19 / 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),

                    ]
                )
            )
        )
    );
  }
}
