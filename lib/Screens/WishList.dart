import 'package:flutter/material.dart';
import 'package:outfitter/providers/WishlistProvider.dart';
import 'package:outfitter/utils/CustomAppBar1.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // final List<Map<String, String>> grid = [
  //   {
  //     "image": 'assets/hoodie.png',
  //     'name': 'Regular Fit Corduroy shirt',
  //     'rating': '4',
  //     'price': '₹ 1,196',
  //     'mrp': '₹ 4,999',
  //     'quantity': '1',
  //   },
  //   {
  //     "image": 'assets/jeans.png',
  //     'name': 'Regular Fit Jeans',
  //     'rating': '4',
  //     'price': '₹ 1,196',
  //     'mrp': '₹ 4,999',
  //     'quantity': '1',
  //   },
  //   {
  //     "image": 'assets/sleaves.png',
  //     'name': 'Stylish Sleeves Top',
  //     'rating': '4',
  //     'price': '₹ 1,196',
  //     'mrp': '₹ 4,999',
  //     'quantity': '1',
  //   },
  // ];

  @override
  void initState() {
    GetWishlistList();
    super.initState();
  }

  Future<void> GetWishlistList() async {
    final wishlist_list_provider =
        Provider.of<WishlistProvider>(context, listen: false);
    wishlist_list_provider.fetchWishList();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomApp(title: 'WishList', w: w),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Consumer<WishlistProvider>(
            builder: (context, profileProvider, child) {
              final product_list = profileProvider.wishlistProducts;
              print("Consumer product list: ${product_list}");

              // Check if the product list is empty
              if (product_list.isEmpty) {
                return Center(
                  child: Image.asset(
                    'assets/noitems.png', // Your "no items" image
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                );
              }

              return Expanded( // Wrap the ListView.builder inside an Expanded widget
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true, // This makes the ListView take up only the necessary space
                  itemCount: product_list.length,
                  itemBuilder: (context, index) {
                    final item = product_list[index];
                    return Container(
                      width: w,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xffFFFDF6),
                        border: Border.all(color: Color(0xffF3EFE1), width: 1),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
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
                                  child: Image.network(
                                    item.product?.image ?? "",
                                    width: w * 0.25,
                                    height: h * 0.13,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: InkResponse(
                                  onTap: () {
                                    if (item.product?.isInWishlist??false) {
                                      // Remove from wishlist
                                      context.read<WishlistProvider>().removeFromWishlist(item.product?.id??"");
                                    } else {
                                      // Add to wishlist
                                      context.read<WishlistProvider>().addToWishlist(item.product?.id??"");
                                    }
                                  },
                                  child: item.product?.isInWishlist?? false
                                      ? Icon(
                                    Icons.favorite, // Filled heart icon when item is in wishlist
                                    size: 18,
                                    color: Colors.red, // Red color for filled icon
                                  )
                                      : Icon(
                                    Icons.favorite_border, // Outline heart icon when item is NOT in wishlist
                                    size: 18,
                                    color: Colors.black, // Black color for outline icon
                                  ),
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
                                  item.product?.title ?? "",
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
                                  children: [
                                    Text(
                                      item.product?.salePrice.toString() ?? "",
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
                                      item.product?.mrp.toString() ?? "",
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
                                  ],
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }

}
