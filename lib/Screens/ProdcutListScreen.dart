import 'package:flutter/material.dart';
import 'package:outfitter/Screens/ProductDetailsScreen.dart';
import 'package:outfitter/Screens/Filters.dart';
import 'package:outfitter/Screens/UploderProfile.dart';
import 'package:outfitter/providers/ProductListProvider.dart';
import 'package:provider/provider.dart';
import '../providers/CategoriesProvider.dart';
import '../providers/WishlistProvider.dart';
import '../utils/CustomAppBar1.dart';
import '../Services/UserApi.dart';

class ProdcutListScreen extends StatefulWidget {
  final String selectid;
  ProdcutListScreen({super.key, required this.selectid});

  @override
  State<ProdcutListScreen> createState() => _ProdcutListScreenState();
}

class _ProdcutListScreenState extends State<ProdcutListScreen> {
  ScrollController _scrollController = ScrollController();
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
  ];

  List<Color> selectedColors = [];
  String _selectedIndex="";

  void _toggleColorSelection(Color color) {
    setState(() {
      selectedColors.clear();
      selectedColors.add(color);
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.selectid;
    GetProductcategoryList(widget.selectid);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedIndex();
    });
    super.initState();
  }
  void _scrollToSelectedIndex() {
    final categoriesList = context.read<CategoriesProvider>().categoriesList;
    final selectedIndex = categoriesList.indexWhere((category) => category.id == _selectedIndex);

    if (selectedIndex != -1) {
      // Assuming each item has a width of 96.0 (adjust as needed based on actual layout)
      double position = selectedIndex * (96.0 + 16.0);  // 96.0 for item width + 16.0 for horizontal padding
      _scrollController.animateTo(position,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }


  Future<void> GetProductcategoryList(String id) async {
    final products_list_provider =
        Provider.of<ProductListProvider>(context, listen: false);
    products_list_provider.fetchProductsList(id);
  }



  Future<void> Addwish(String product) async {
    var res = await Userapi.AddWishList(product);
    if (res != null) {
      setState(() {
        if (res.settings?.success == 1) {
        } else {}
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomApp(title: 'ProductList', w: w),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Consumer<CategoriesProvider>(
                    builder: (context, profileProvider, child) {
                  final categories_list = profileProvider.categoriesList;
                  return Row(
                    children: List.generate(
                      categories_list.length,
                      (index) {
                        final data = categories_list[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              InkResponse(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = data.id??"";
                                    GetProductcategoryList(data.id ?? "");
                                  });
                                },
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _selectedIndex ==  data.id
                                            ? Color(0xffCAA16C)
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff110B0F),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Image.network(
                                        data.image ?? '',
                                        // Default to an empty string if image is null
                                        width: 64,
                                        height: 64,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  data.categoryName ?? "",
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
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
              SizedBox(height: h * 0.02),
              Consumer<ProductListProvider>(
                builder: (context, profileProvider, child) {
                  final product_list = profileProvider.productList;
                  print("Consumer product list:${product_list}");
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

                  // If product list is not empty, show GridView
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.46,
                    ),
                    itemCount: product_list.length,
                    itemBuilder: (context, index) {
                      final productData = product_list[index];
                      print("Consumer product name:${productData.title}");
                      return Column(
                        children: [
                          Stack(
                            children: [
                              InkResponse(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsScreen(productid: productData.id.toString())));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xffEEF2F6),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          child: Image.network(
                                            productData.image ?? "",
                                            fit: BoxFit.contain,
                                            width: w * 0.3,
                                            height: h * 0.2,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UploaderProfile()));
                                            },
                                            child: CircleAvatar(
                                              radius: 12,
                                              child: ClipOval(
                                                child: Image.asset(
                                                  "assets/postedBY.png",
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: w * 0.03),
                                          Text(
                                            "POSTED BY",
                                            style: TextStyle(
                                              color: Color(0xff617C9D),
                                              fontFamily: 'RozhaOne',
                                              fontSize: 14,
                                              height: 19.36 / 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        productData.title ?? '',
                                        style: TextStyle(
                                          color: Color(0xff121926),
                                          fontFamily: 'RozhaOne',
                                          fontSize: 16,
                                          height: 24 / 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            productData.mrp.toString() ?? "",
                                            style: TextStyle(
                                              color: Color(0xff121926),
                                              fontFamily: 'RozhaOne',
                                              fontSize: 14,
                                              height: 21 / 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(width: w * 0.03),
                                          Text(
                                            productData.salePrice.toString() ??
                                                "",
                                            style: TextStyle(
                                              color: Color(0xff617C9D),
                                              fontFamily: 'RozhaOne',
                                              fontSize: 14,
                                              height: 21 / 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: colors.map((color) {
                                          return GestureDetector(
                                            onTap: () =>
                                                _toggleColorSelection(color),
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                  color: selectedColors
                                                          .contains(color)
                                                      ? Colors.black
                                                      : Colors.transparent,
                                                  width: 0.5,
                                                ),
                                              ),
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: color,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: InkResponse(
                                  onTap: () {
                                    if (productData.isInWishlist ?? false) {
                                      // Remove from wishlist
                                      context
                                          .read<WishlistProvider>()
                                          .removeFromWishlist(
                                              productData.id ?? "");
                                    } else {
                                      // Add to wishlist
                                      context
                                          .read<WishlistProvider>()
                                          .addToWishlist(productData.id ?? "");
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: productData.isInWishlist ?? false
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
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              // SizedBox(height: h * 0.01),
              // Center(
              //   child:
              //   Container(
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
              // SizedBox(height: h * 0.04),
              // Center(
              //   child: Text(
              //     "Recently Viewed",
              //     style: TextStyle(
              //       color: Color(0xff110B0F),
              //       fontFamily: 'RozhaOne',
              //       fontSize: 24,
              //       height: 32 / 24,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // ),
              // SizedBox(height: h * 0.02),
              // SizedBox(height: h * 0.02),
              // GridView.builder(
              //   physics: NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 8.0,
              //     mainAxisSpacing: 8.0,
              //     childAspectRatio: 0.46,
              //   ),
              //   itemCount: grid.length,
              //   itemBuilder: (context, index) {
              //     return Column(
              //       children: [
              //         Stack(
              //           children: [
              //             InkResponse(
              //               onTap: () {
              //                 // Navigator.push(
              //                 //   context,
              //                 //   MaterialPageRoute(
              //                 //     builder: (context) => Home(),
              //                 //   ),
              //                 // );
              //               },
              //               child: Container(
              //                 padding: const EdgeInsets.all(8.0),
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: Color(0xffEEF2F6),
              //                     width: 1,
              //                   ),
              //                 ),
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Center(
              //                       child: Container(
              //                           child: Image.asset(
              //                         grid[index]['image']!,
              //                         fit: BoxFit.contain,
              //                         width: w * 0.3,
              //                         height: h * 0.2,
              //                       )),
              //                     ),
              //                     const SizedBox(height: 15),
              //                     Row(
              //                       children: [
              //                         CircleAvatar(
              //                           radius: 12,
              //                           child: ClipOval(
              //                             child: Image.asset(
              //                               "assets/postedBY.png",
              //                               fit: BoxFit.contain,
              //                             ),
              //                           ),
              //                         ),
              //                         SizedBox(width: w * 0.03),
              //                         Text(
              //                           "POSTED BY",
              //                           style: TextStyle(
              //                             color: Color(0xff617C9D),
              //                             fontFamily: 'RozhaOne',
              //                             fontSize: 14,
              //                             height: 19.36 / 14,
              //                             fontWeight: FontWeight.w400,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     const SizedBox(height: 10),
              //                     Text(
              //                       "Straight Regular Jeans",
              //                       style: TextStyle(
              //                         color: Color(0xff121926),
              //                         fontFamily: 'RozhaOne',
              //                         fontSize: 16,
              //                         height: 24 / 16,
              //                         fontWeight: FontWeight.w400,
              //                       ),
              //                     ),
              //                     const SizedBox(height: 10),
              //                     Row(
              //                       children: [
              //                         Text(
              //                           "₹2340.00",
              //                           style: TextStyle(
              //                             color: Color(0xff121926),
              //                             fontFamily: 'RozhaOne',
              //                             fontSize: 14,
              //                             height: 21 / 14,
              //                             fontWeight: FontWeight.w400,
              //                           ),
              //                         ),
              //                         SizedBox(width: w * 0.03),
              //                         Text(
              //                           "₹2340.00",
              //                           style: TextStyle(
              //                             color: Color(0xff617C9D),
              //                             fontFamily: 'RozhaOne',
              //                             fontSize: 14,
              //                             height: 21 / 14,
              //                             fontWeight: FontWeight.w400,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     const SizedBox(height: 10),
              //                     Row(
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       children: colors.map((color) {
              //                         return GestureDetector(
              //                           onTap: () =>
              //                               _toggleColorSelection(color),
              //                           child: Container(
              //                             padding: EdgeInsets.all(3),
              //                             decoration: BoxDecoration(
              //                               borderRadius:
              //                                   BorderRadius.circular(100),
              //                               border: Border.all(
              //                                 color:
              //                                     selectedColors.contains(color)
              //                                         ? Colors.black
              //                                         : Colors.transparent,
              //                                 width: 0.5,
              //                               ),
              //                             ),
              //                             child: Container(
              //                               width: 20,
              //                               height: 20,
              //                               decoration: BoxDecoration(
              //                                 color:
              //                                     // selectedColors.contains(color)
              //                                     //     ?
              //                                     color,
              //                                 // : Colors.grey[300],
              //                                 borderRadius:
              //                                     BorderRadius.circular(100),
              //                               ),
              //                             ),
              //                           ),
              //                         );
              //                       }).toList(),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //             Positioned(
              //               top: 8,
              //               right: 8,
              //               child: Container(
              //                 padding: const EdgeInsets.all(8),
              //                 decoration: BoxDecoration(
              //                   color: Color(0xffFFE5E6),
              //                   borderRadius: BorderRadius.circular(100),
              //                 ),
              //                 child: Image.asset(
              //                   "assets/fav.png",
              //                   width: 18,
              //                   height: 18,
              //                   fit: BoxFit.contain,
              //                   color: Color(0xff000000),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     );
              //   },
              // ),
              // SizedBox(height: h * 0.04),
              // Container(
              //   margin: EdgeInsets.only(left: 10, right: 10),
              //   padding: EdgeInsets.only(top: 24, bottom: 24),
              //   decoration: BoxDecoration(
              //       color: Color(0xffF6F6F6),
              //       borderRadius: BorderRadius.circular(6)),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Image.asset(
              //         "assets/shipping.png",
              //         width: w * 0.1,
              //         height: h * 0.1,
              //       ),
              //       Text(
              //         "Fast Shipping",
              //         style: TextStyle(
              //           color: Color(0xff110B0F),
              //           fontFamily: 'RozhaOne',
              //           fontSize: 18,
              //           height: 28 / 18,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //       SizedBox(
              //         height: w * 0.002,
              //       ),
              //       Text(
              //         "We offer Rush and Expedited options if you need it fast",
              //         style: TextStyle(
              //           color: Color(0xff697586),
              //           fontFamily: 'RozhaOne',
              //           fontSize: 15,
              //           height: 24 / 15,
              //           fontWeight: FontWeight.w400,
              //         ),
              //         textAlign: TextAlign.center,
              //       ),
              //       Image.asset(
              //         "assets/support.png",
              //         width: w * 0.1,
              //         height: h * 0.1,
              //       ),
              //       Text(
              //         "24x7 SUPPORT",
              //         style: TextStyle(
              //           color: Color(0xff110B0F),
              //           fontFamily: 'RozhaOne',
              //           fontSize: 18,
              //           height: 28 / 18,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //       SizedBox(
              //         height: w * 0.002,
              //       ),
              //       Text(
              //         "24 hours a day, 7 days a week",
              //         style: TextStyle(
              //           color: Color(0xff697586),
              //           fontFamily: 'RozhaOne',
              //           fontSize: 15,
              //           height: 24 / 15,
              //           fontWeight: FontWeight.w400,
              //         ),
              //         textAlign: TextAlign.center,
              //       ),
              //       Image.asset(
              //         "assets/card.png",
              //         width: w * 0.1,
              //         height: h * 0.1,
              //       ),
              //       Text(
              //         "Flexible Payments",
              //         style: TextStyle(
              //           color: Color(0xff110B0F),
              //           fontFamily: 'RozhaOne',
              //           fontSize: 18,
              //           height: 28 / 18,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //       SizedBox(
              //         height: w * 0.002,
              //       ),
              //       Text(
              //         "Pay in a variety of ways",
              //         style: TextStyle(
              //           color: Color(0xff697586),
              //           fontFamily: 'RozhaOne',
              //           fontSize: 15,
              //           height: 24 / 15,
              //           fontWeight: FontWeight.w400,
              //         ),
              //         textAlign: TextAlign.center,
              //       ),
              //       Image.asset(
              //         "assets/doller.png",
              //         width: w * 0.1,
              //         height: h * 0.1,
              //       ),
              //       Text(
              //         "Flexible Returns & Replacements",
              //         style: TextStyle(
              //           color: Color(0xff110B0F),
              //           fontFamily: 'RozhaOne',
              //           fontSize: 18,
              //           height: 28 / 18,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //       SizedBox(
              //         height: w * 0.002,
              //       ),
              //       Text(
              //         "Your satisfaction is important to us",
              //         style: TextStyle(
              //           color: Color(0xff697586),
              //           fontFamily: 'RozhaOne',
              //           fontSize: 15,
              //           height: 24 / 15,
              //           fontWeight: FontWeight.w400,
              //         ),
              //         textAlign: TextAlign.center,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: [
              //           Container(
              //             padding: EdgeInsets.all(8),
              //             margin: EdgeInsets.only(right: 8),
              //             decoration: BoxDecoration(
              //               color: Color(0xffFFE5E6),
              //               borderRadius: BorderRadius.circular(100),
              //             ),
              //             child: Image.asset(
              //               "assets/arrow-sm-up.png",
              //               width: 18,
              //               height: 18,
              //               fit: BoxFit.contain,
              //               color: Color(0xff000000),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
            vertical: 10), // Adjusted padding for vertical alignment
        height: h * 0.06, // Increased height for better visibility
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          border: Border(
              top: BorderSide(
                  color: Color(0xffE3E8EF), width: 1)), // Added a top border
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceAround, // Space between SORT and FILTER evenly
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/sort.png",
                ),
                SizedBox(
                  width: w * 0.02,
                ),
                Text(
                  "SORT",
                  style: TextStyle(
                    color: Color(0xff110B0F),
                    fontFamily: 'RozhaOne',
                    fontSize: 16,
                    height: 24 / 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            // Divider between SORT and FILTER
            Container(
              width: 1,
              height: h * 0.04,
              color: Color(0xffE3E8EF),
            ),
            // FILTER button
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Filters()));
              },
              child: Row(
                children: [
                  Image.asset(
                    "assets/filter.png",
                  ),
                  SizedBox(
                    width: w * 0.02, // Increased width for spacing
                  ),
                  Text(
                    "FILTER",
                    style: TextStyle(
                      color: Color(0xff110B0F),
                      fontFamily: 'RozhaOne',
                      fontSize: 16,
                      height: 24 / 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
