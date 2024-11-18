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
  String selectedSort = '';

  final List<String> sortOptions = [
    'Price (Low to High)',
    'Price (High to Low)',
    'Popularity',
  ];

  final Map<String, String> sortOptionToValue = {
    'Price (Low to High)': 'min-max',
    'Price (High to Low)': 'max-min',
    'Popularity': 'best-seller',
  };
  // Initial range values
  double minPrice = 0;
  double maxPrice = 10000;
  double selectedMinPrice = 0;
  double selectedMaxPrice = 2000;

  int rating = 0;
  List<Color> selectedColors = [];
  String _selectedIndex = "";
  String category_id = "";

  void _toggleColorSelection(Color color) {
    setState(() {
      selectedColors.clear();
      selectedColors.add(color);
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.selectid;
    GetProductcategoryList(widget.selectid, "","","");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedIndex();
    });
    super.initState();
  }

  void _scrollToSelectedIndex() {
    final categoriesList = context.read<CategoriesProvider>().categoriesList;
    final selectedIndex =
        categoriesList.indexWhere((category) => category.id == _selectedIndex);

    if (selectedIndex != -1) {
      // Assuming each item has a width of 96.0 (adjust as needed based on actual layout)
      double position = selectedIndex *
          (96.0 + 16.0); // 96.0 for item width + 16.0 for horizontal padding
      _scrollController.animateTo(position,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  Future<void> GetProductcategoryList(String id, selectedSort,filterminprice,filtermaxprice) async {
    final products_list_provider =
        Provider.of<ProductListProvider>(context, listen: false);
    products_list_provider.fetchProductsList(id, selectedSort,filterminprice,filtermaxprice);
  }

  Future<void> fetchProductDetails(String productId) async {
    try {
      var response = await Userapi.getProductDetails(
          productId); // Use the passed productId here
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
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
      appBar: CustomApp(title: 'Product List', w: w),
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
                                    _selectedIndex = data.id ?? "";
                                    category_id = data.id ?? "";
                                    GetProductcategoryList(data.id ?? "", "","","");
                                  });
                                },
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _selectedIndex == data.id
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
                      childAspectRatio: 0.575,
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
                                  fetchProductDetails(productData.id ?? "");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsScreen(
                                                productid: productData.id ?? "",
                                                category_id: category_id,
                                              )));
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
                                      // const SizedBox(height: 15),
                                      // Row(
                                      //   children: [
                                      //     InkWell(
                                      //       onTap: () {
                                      //         Navigator.push(
                                      //             context,
                                      //             MaterialPageRoute(
                                      //                 builder: (context) =>
                                      //                     UploaderProfile()));
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
                                      //     ),
                                      //   ],
                                      // ),
                                      const SizedBox(height: 10),
                                      Text(
                                        productData.title ?? '',
                                        style: TextStyle(
                                          color: Color(0xff121926),
                                          fontFamily: 'RozhaOne',
                                          fontSize: 16,
                                          height: 24 / 16,
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis
                                        ),
                                        maxLines: 2,
                                      ),
                                      if (rating > 0) ...[
                                        const SizedBox(height: 10),
                                        Row(
                                          children:
                                              List.generate(5, (starIndex) {
                                            int ratingValue = int.tryParse(
                                                    productData.rating
                                                        .toString()) ??
                                                0;
                                            return Icon(
                                              starIndex < ratingValue
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color: Color(0xffF79009),
                                              size: 14,
                                            );
                                          }),
                                        ),
                                      ],

                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            '₹ ${productData.salePrice.toString() ?? ""}',
                                            style: TextStyle(
                                              color: Color(0xff121926),
                                              fontFamily: 'RozhaOne',
                                              fontSize: 16,
                                              height: 21 / 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(width: w * 0.03),
                                          Text(
                                            '₹ ${productData.mrp.toString() ?? ""}',
                                            style: TextStyle(
                                              color: Color(0xff617C9D),
                                              fontFamily: 'RozhaOne',
                                              fontSize: 14,
                                              height: 21 / 14,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor:
                                                  Color(0xff617C9D),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // const SizedBox(height: 10),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.start,
                                      //   children: colors.map((color) {
                                      //     return GestureDetector(
                                      //       onTap: () =>
                                      //           _toggleColorSelection(color),
                                      //       child: Container(
                                      //         padding: EdgeInsets.all(3),
                                      //         decoration: BoxDecoration(
                                      //           borderRadius:
                                      //               BorderRadius.circular(100),
                                      //           border: Border.all(
                                      //             color: selectedColors
                                      //                     .contains(color)
                                      //                 ? Colors.black
                                      //                 : Colors.transparent,
                                      //             width: 0.5,
                                      //           ),
                                      //         ),
                                      //         child: Container(
                                      //           width: 20,
                                      //           height: 20,
                                      //           decoration: BoxDecoration(
                                      //             color: color,
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     100),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     );
                                      //   }).toList(),
                                      // ),
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
            InkResponse(
              onTap: () {
                _bottomSheet(context);
              },
              child: Row(
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
                _bottomSheet1(context);
              },
              child: Row(
                children: [
                  Image.asset(
                    "assets/filter.png",
                    color: Color(0xff110B0F),
                    width: w*0.05,
                    height: h*0.04,
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

  void _bottomSheet(
    BuildContext context,
  ) {
    double h = MediaQuery.of(context).size.height * 0.35;
    double w = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                    height: h,
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 20),
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: w * 0.1,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                'Sort By',
                                style: TextStyle(
                                  color: Color(0xff1C1D22),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  fontFamily: 'RozhaOne',
                                  height: 18 / 16,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pop(); // Close the BottomSheet when tapped
                                },
                                child: Container(
                                  width: w * 0.05,
                                  height: w * 0.05,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE5E5E5),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/crossblue.png",
                                      fit: BoxFit.contain,
                                      width: w * 0.023,
                                      height: w * 0.023,
                                      color: Color(0xffCAA16C),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: sortOptions.length,
                            itemBuilder: (context, index) {
                              return RadioListTile<String>(
                                activeColor: Color(0xffCAA16C),
                                value: sortOptions[index],
                                groupValue: selectedSort,
                                onChanged: (value) {
                                  setState(() {
                                    selectedSort = value!;
                                    String sortValue =
                                        sortOptionToValue[selectedSort]!;

                                    GetProductcategoryList(
                                        widget.selectid, sortValue,"","");
                                  });
                                  Navigator.pop(
                                      context); // Close the dialog after selection
                                },
                                title: Text(sortOptions[index]),
                              );
                            },
                          ),
                        ])));
          });
        });
  }

  void _bottomSheet1(BuildContext context) {
    double h = MediaQuery.of(context).size.height * 0.35;
    double w = MediaQuery.of(context).size.width;



    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: h,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: w * 0.1,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Filter',
                          style: TextStyle(
                            color: Color(0xff1C1D22),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'RozhaOne',
                            height: 18 / 16,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pop(); // Close the BottomSheet when tapped
                          },
                          child: Container(
                            width: w * 0.05,
                            height: w * 0.05,
                            decoration: BoxDecoration(
                              color: Color(0xffE5E5E5),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/crossblue.png",
                                fit: BoxFit.contain,
                                width: w * 0.023,
                                height: w * 0.023,
                                color: Color(0xffCAA16C),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    // Price Range Slider
                    Text(
                      'Selected  Price Range',
                      style: TextStyle(
                        color: Color(0xff1C1D22),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: 'RozhaOne',
                        height: 18 / 16,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Min: \₹ ${selectedMinPrice.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Max: \₹ ${selectedMaxPrice.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    RangeSlider(
                      inactiveColor: Color(0xffE3E8EF),
                      activeColor: Color(0xffCAA16C),
                      min: minPrice,
                      max: maxPrice,
                      divisions: 100,
                      labels: RangeLabels(
                        '\₹ ${selectedMinPrice.toStringAsFixed(0)}',
                        '\₹${selectedMaxPrice.toStringAsFixed(0)}',
                      ),
                      values: RangeValues(selectedMinPrice, selectedMaxPrice),
                      onChanged: (RangeValues values) {
                        setState(() {
                          selectedMinPrice = values.start;
                          selectedMaxPrice = values.end;
                        });
                      },
                    ),
                    Spacer(),
                    Center(
                      child: InkResponse(onTap: (){

                        GetProductcategoryList(
                            widget.selectid,"",selectedMinPrice.toInt(),selectedMaxPrice.toInt());
                        Navigator.pop(context);
                        print("selectedMaxPrice>>>${selectedMaxPrice}");

                      },
                        child: Container(
                          width: w * 0.45,
                          padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xff110B0F),
                              borderRadius: BorderRadius.circular(6),
                            ),

                          child: Center(
                            child: Text(
                              "Apply",
                              style: TextStyle(
                                color: Color(0xffE7C6A0),
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
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
