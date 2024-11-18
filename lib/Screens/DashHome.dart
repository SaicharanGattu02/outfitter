import 'package:flutter/material.dart';
import 'package:outfitter/Screens/Cart.dart';
import 'package:outfitter/Screens/CustomizeBar.dart';
import 'package:outfitter/Screens/ProductDetailsScreen.dart';
import 'package:outfitter/Screens/UploderProfile.dart';
import 'package:outfitter/providers/CategoriesProvider.dart';
import 'package:provider/provider.dart';

import '../Model/ProductsListModel.dart';
import '../Services/UserApi.dart';
import '../providers/CartProvider.dart';
import '../providers/ProductListProvider.dart';
import '../providers/WishlistProvider.dart';
import '../utils/CustomSnackBar.dart';
import 'ProdcutListScreen.dart';
import 'Orders.dart';
import 'Profile.dart';
import 'SearchScreen.dart';
import 'WishList.dart';

class DashHome extends StatefulWidget {
  const DashHome({super.key});

  @override
  State<DashHome> createState() => _DashHomeState();
}

class _DashHomeState extends State<DashHome> {
  ScrollController _scrollController = ScrollController();

  int minprice1 = 0;
  int maxprice1 = 299;

  final List<Map<String, String>> gridmore = [
    {"color": "0xff4CA8D9", "price": "299"},
    {"color": "0xffE98839", "price": "499"},
    {"color": "0xff84B538", "price": "799"},
    {"color": "0xffB9356F", "price": "999"},
  ];

  int _selectedIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,

    // Add more colors as needed
  ];

  List<Color> selectedColors = [];

  void _toggleColorSelection(Color color) {
    setState(() {
      selectedColors.clear();
      selectedColors.add(color);
    });
  }

  @override
  void initState() {
    GetCategoriesList();
    super.initState();
  }

  Future<void> GetCategoriesList() async {
    final categories_list_provider =
        Provider.of<CategoriesProvider>(context, listen: false);
    final bestseller_list_provider =
        Provider.of<ProductListProvider>(context, listen: false);
    categories_list_provider.fetchCategoriesList();
    bestseller_list_provider.fetchBestSellersList();
  }

  List<ProductsList> productlist = [];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[Container()],
        toolbarHeight: 50,
        backgroundColor: const Color(0xff110B0F),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Image.asset(
                "assets/OutfiterText.png",
                width: w * 0.35,
                fit: BoxFit.contain,
                color: Color(0xffE7C6A0),
              ),
              Spacer(),
              Row(
                children: [
                  if (_selectedIndex == 1) ...[
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Orders()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/orders.png",
                          width: 28,
                          height: 28,
                          color: Color(0xffffffff),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ] else ...[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Searchscreen(),
                            ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/search.png",
                          width: 28,
                          height: 28,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(width: w * 0.025),
                  if (_selectedIndex == 1) ...[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WishlistScreen()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/fav.png",
                          width: 28,
                          height: 28,
                          color: Color(0xffffffff),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ] ,
                  // else ...[
                    // InkWell(
                    //   onTap: () {
                    //
                    //   },
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     child: Image.asset(
                    //       "assets/notification.png",
                    //       width: 28,
                    //       height: 28,
                    //       fit: BoxFit.contain,
                    //     ),
                    //   ),
                    // ),
                  // ],
                  SizedBox(width: w * 0.025),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Cart()), // Navigate to your cart screen
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Consumer<CartProvider>(
                        // Using Consumer to listen to CartProvider changes
                        builder: (context, cartProvider, child) {
                          return Badge.count(
                            count: cartProvider
                                .cartCount, // Get the cart count from CartProvider
                            backgroundColor: Colors
                                .red, // Set the badge background color (red for cart)
                            textColor: Colors
                                .white, // Set the badge text color (white for visibility)
                            smallSize: 12, // Set the small size of the badge
                            largeSize: 16, // Set the large size if needed
                            isLabelVisible: cartProvider.cartCount >
                                0, // Only show badge if count > 0
                            alignment: Alignment
                                .topRight, // Align badge to top right of the cart icon
                            child: Image.asset(
                              "assets/cart.png", // The cart icon
                              width: 28,
                              height: 28,
                              fit: BoxFit.contain,
                              color: Color(0xffffffff),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.asset(
                "assets/Banner.png", // Your image path
                fit: BoxFit.fill,
                width: w,
              ),
            ),
            SizedBox(height: h * 0.05),
            Center(
              child: Text(
                "Shop by Categories",
                style: TextStyle(
                  color: Color(0xff110B0F),
                  fontFamily: 'RozhaOne',
                  fontSize: 24,
                  height: 32 / 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: h * 0.03),
            Consumer<CategoriesProvider>(
                builder: (context, profileProvider, child) {
              final categories_list = profileProvider.categoriesList;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.55,
                  ),
                  itemCount: categories_list.length,
                  itemBuilder: (context, index) {
                    final categorielist = categories_list[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProdcutListScreen(
                                          selectid: categorielist.id ?? "",
                                          minprice: "",
                                          maxprice: "",
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff110B0F),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.network(
                                categorielist?.image ?? '',
                                width: 80,
                                height: 80,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Center(
                          child: Text(
                            categorielist?.categoryName ?? '',
                            style: TextStyle(
                              color: Color(0xff110B0F),
                              fontFamily: 'RozhaOne',
                              fontSize: 14,
                              height: 20 / 14,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }),
            SizedBox(height: h * 0.02),
            Center(
              child: Text(
                "Best Sellers",
                style: TextStyle(
                  color: Color(0xff110B0F),
                  fontFamily: 'RozhaOne',
                  fontSize: 24,
                  height: 32 / 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: h * 0.02),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enables horizontal scrolling
              child: Consumer<ProductListProvider>(
                  builder: (context, bestsellerProvider, child) {
                final products_list = bestsellerProvider.bestsellerList;
                return Row(
                  children: List.generate(products_list.length, (index) {
                    var data = products_list[index];
                    return InkResponse(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                    productid: data.id.toString(),
                                    category_id: "")));
                      },
                      child: Stack(children: [
                        Container(
                          width: w * 0.45,
                          // Control the width of each item
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(left: 10, right: 8.0),
                          // Space between items
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffEEF2F6),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  data.image ?? "",
                                  height: h * 0.2,
                                  width: w * 0.45,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: 15),
                              // Row(
                              //   children: [
                              //     InkWell(
                              //       onTap: () {
                              //         Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //             builder: (context) => UploaderProfile(),
                              //           ),
                              //         );
                              //       },
                              //       child: CircleAvatar(
                              //         radius: 12,
                              //         child: ClipOval(
                              //           child: Image.asset(
                              //             "assets/postedBY.png",
                              //             fit: BoxFit.contain,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(width: w * 0.03),
                              //     Text(
                              //       "POSTED BY",
                              //       style: TextStyle(
                              //         color: Color(0xff617C9D),
                              //         fontFamily: 'RozhaOne',
                              //         fontSize: 14,
                              //         height: 19.36 / 14,
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //     )
                              //   ],
                              // ),
                              SizedBox(height: 10),
                              Text(
                                data.title ?? "",
                                style: TextStyle(
                                  color: Color(0xff121926),
                                  fontFamily: 'RozhaOne',
                                  fontSize: 16,
                                  height: 24 / 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "₹${data.salePrice ?? ""}",
                                    style: TextStyle(
                                      color: Color(0xff121926),
                                      fontFamily: 'RozhaOne',
                                      fontSize: 16,
                                      height: 24 / 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: w * 0.03),
                                  Text(
                                    "₹${data.mrp ?? ""}",
                                    style: TextStyle(
                                      color: Color(0xff617C9D),
                                      fontFamily: 'RozhaOne',
                                      fontSize: 16,
                                      height: 24 / 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 10,
                          child: InkResponse(
                            onTap: () {
                              if (data.isInWishlist ?? false) {
                                context
                                    .read<WishlistProvider>()
                                    .removeFromWishlist(data.id ?? "");
                              } else {
                                // Add to wishlist
                                context
                                    .read<WishlistProvider>()
                                    .addToWishlist(data.id ?? "");
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: data.isInWishlist ?? false
                                  ? Icon(
                                      Icons
                                          .favorite, // Filled heart icon when item is in wishlist
                                      size: 18,
                                      color: Colors
                                          .red, // Red color for filled icon
                                    )
                                  : Icon(
                                      Icons
                                          .favorite_border, // Outline heart icon when item is NOT in wishlist
                                      size: 18,
                                      color: Colors
                                          .black, // Black color for outline icon
                                    ),
                            ),
                          ),
                        ),
                      ]),
                    );
                  }),
                );
              }),
            ),
            // SizedBox(height: h * 0.01),
            // Center(
            //   child: Container(
            //     width: w * 0.35,
            //     padding: EdgeInsets.all(12),
            //     decoration: BoxDecoration(
            //         color: Color(0xff110B0F),
            //         borderRadius: BorderRadius.circular(6)),
            //     child: Center(
            //       child: Text(
            //         "SHOW MORE",
            //         style: TextStyle(
            //           color: Color(0xffE7C6A0),
            //           fontFamily: 'RozhaOne',
            //           fontSize: 16,
            //           height: 21.06 / 16,
            //           fontWeight: FontWeight.w400,
            //         ),
            //         textAlign: TextAlign.center,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: h * 0.04),
            Center(
              child: Text(
                "Shop by Price",
                style: TextStyle(
                  color: Color(0xff110B0F),
                  fontFamily: 'RozhaOne',
                  fontSize: 24,
                  height: 32 / 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: h * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.6,
                ),
                itemCount: gridmore.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkResponse(
                        onTap: () {
                          String selectedMaxPrice =
                              gridmore[index]['price'] ?? '0';

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProdcutListScreen(
                                        selectid: "",
                                        minprice: minprice1.toString(),
                                        maxprice: selectedMaxPrice,
                                      )));
                          print("maxprice>>${selectedMaxPrice}");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(int.parse(gridmore[index]['color']!)),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Column(
                            children: [
                              Text(
                                "Under",
                                style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontFamily: 'RozhaOne',
                                  fontSize: 14,
                                  height: 20 / 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 8),
                              Center(
                                child: Text(
                                  gridmore[index]['price']!,
                                  style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontFamily: 'RozhaOne',
                                    fontSize: 32,
                                    height: 34 / 32,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: h * 0.01),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: Image.asset(
                "assets/Promotional_Banners Mobile.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: h * 0.04),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(top: 24, bottom: 24),
              decoration: BoxDecoration(
                  color: Color(0xffF6F6F6),
                  borderRadius: BorderRadius.circular(6)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/shipping.png",
                    width: w * 0.1,
                    height: h * 0.1,
                  ),
                  Text(
                    "Fast Shipping",
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'RozhaOne',
                      fontSize: 18,
                      height: 28 / 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: w * 0.002,
                  ),
                  Text(
                    "We offer Rush and Expedited options if you need it fast",
                    style: TextStyle(
                      color: Color(0xff697586),
                      fontFamily: 'RozhaOne',
                      fontSize: 15,
                      height: 24 / 15,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    "assets/support.png",
                    width: w * 0.1,
                    height: h * 0.1,
                  ),
                  Text(
                    "24x7 SUPPORT",
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'RozhaOne',
                      fontSize: 18,
                      height: 28 / 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: w * 0.002,
                  ),
                  Text(
                    "24 hours a day, 7 days a week",
                    style: TextStyle(
                      color: Color(0xff697586),
                      fontFamily: 'RozhaOne',
                      fontSize: 15,
                      height: 24 / 15,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    "assets/card.png",
                    width: w * 0.1,
                    height: h * 0.1,
                  ),
                  Text(
                    "Flexible Payments",
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'RozhaOne',
                      fontSize: 18,
                      height: 28 / 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: w * 0.002,
                  ),
                  Text(
                    "Pay in a variety of ways",
                    style: TextStyle(
                      color: Color(0xff697586),
                      fontFamily: 'RozhaOne',
                      fontSize: 15,
                      height: 24 / 15,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    "assets/doller.png",
                    width: w * 0.1,
                    height: h * 0.1,
                  ),
                  Text(
                    "Flexible Returns & Replacements",
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'RozhaOne',
                      fontSize: 18,
                      height: 28 / 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: w * 0.002,
                  ),
                  Text(
                    "Your satisfaction is important to us",
                    style: TextStyle(
                      color: Color(0xff697586),
                      fontFamily: 'RozhaOne',
                      fontSize: 15,
                      height: 24 / 15,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkResponse(
                        onTap: () {
                          _scrollController.animateTo(
                            0.0, // Scroll to the top
                            duration: Duration(
                                milliseconds:
                                    300), // Duration for the scroll animation
                            curve: Curves.easeInOut, // Animation curve
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Color(0xffFFE5E6),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Image.asset(
                            "assets/arrow-sm-up.png",
                            width: 18,
                            height: 18,
                            fit: BoxFit.contain,
                            color: Color(0xff000000),
                          ),
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
    );
  }
}
