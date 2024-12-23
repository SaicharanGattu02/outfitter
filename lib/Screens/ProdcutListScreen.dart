import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outfitter/Screens/ProductDetailsScreen.dart';
import 'package:outfitter/Screens/Filters.dart';
import 'package:outfitter/Screens/UploderProfile.dart';
import 'package:outfitter/providers/ProductListProvider.dart';
import 'package:provider/provider.dart';
import '../Services/otherservices.dart';
import '../providers/CategoriesProvider.dart';
import '../providers/WishlistProvider.dart';
import '../utils/CustomAppBar1.dart';
import '../Services/UserApi.dart';
import 'dart:developer' as developer;
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../utils/CustomSnackBar.dart';

class ProdcutListScreen extends StatefulWidget {
  final String selectid;
  final String minprice;
  final String maxprice;
  ProdcutListScreen({super.key, required this.selectid,required this.minprice,required this.maxprice});

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
  final spinkits = Spinkits3();

  void _toggleColorSelection(Color color) {
    setState(() {
      selectedColors.clear();
      selectedColors.add(color);
    });
  }


  @override
  void initState() {
    _selectedIndex = widget.selectid;
    GetProductcategoryList(widget.selectid, "",widget.minprice,widget.maxprice);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedIndex();
    });
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }



  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  var isDeviceConnected = "";

  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();

  Future<void> initConnectivity() async {
    List<ConnectivityResult> result;
    try {

      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }


    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
      for (int i = 0; i < _connectionStatus.length; i++) {
        setState(() {
          isDeviceConnected = _connectionStatus[i].toString();
          print("isDeviceConnected:${isDeviceConnected}");
        });
      }
    });
    print('Connectivity changed: $_connectionStatus');
  }

  void _scrollToSelectedIndex() {
    final categoriesList = context.read<CategoriesProvider>().categoriesList;

    if (categoriesList.isNotEmpty && _selectedIndex.isNotEmpty) {
      final selectedIndex = categoriesList.indexWhere((category) => category.id == _selectedIndex);
      if (selectedIndex != -1) {
        // Calculate scroll position
        double position = selectedIndex * (96.0 + 16.0);
        print("Scrolling to position: $position");

        // Check if content width exceeds screen width
        final screenWidth = MediaQuery.of(context).size.width;
        final totalWidth = categoriesList.length * (96.0 + 16.0);
        print("Screen width: $screenWidth, Total content width: $totalWidth");

        if (totalWidth > screenWidth) {
          // Scroll if content is larger than screen width
          _scrollController.animateTo(
            position,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          print("Content width is smaller than screen width. No scroll needed.");
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

    return
      (isDeviceConnected == "ConnectivityResult.wifi" ||
          isDeviceConnected == "ConnectivityResult.mobile")
          ?
      Scaffold(
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
                                      selectedMinPrice = 0;
                                      selectedMaxPrice = 0;

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
                                      child: CachedNetworkImage(
                                        imageUrl: data.image ?? "",
                                        width: 64,
                                        height: 64,
                                        fit: BoxFit.contain,
                                        placeholder:
                                            (BuildContext context,
                                            String url) {
                                          return Center(
                                            child: spinkits
                                                .getSpinningLinespinkit(),
                                          );
                                        },
                                        errorWidget:
                                            (BuildContext context,
                                            String url,
                                            dynamic error) {
                                          // Handle error in case the image fails to load
                                          return Icon(Icons.error);
                                        },
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
                builder: (context, productListProvider, child) {
                  final product_list = productListProvider.productList;
                  print("Consumer product list:${product_list}");
                  if (productListProvider.isLoading) {
                    return Center(
                        child: Column(
                          children: [
                            SizedBox(height: w*0.6,),
                            CircularProgressIndicator(
                              color: Color(0xffE7C6A0),
                            ),
                          ],
                        ));
                  } else if (product_list.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(height: w*0.2,),
                          Image.asset(
                            alignment: Alignment.center,
                            'assets/no_product.png', // Your "no items" image
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 30,),
                          Text("No Product",
                            style: TextStyle(
                              color: Color(0xffCAA16C),
                              fontFamily: 'RozhaOne',
                              fontSize: 22,
                              height: 18 / 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("Come back for the product we are updating the product soon!",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontFamily: 'RozhaOne',
                              fontSize: 16,
                              height: 18 / 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),

                        ],
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
                      childAspectRatio:w* 0.001655,
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
                                          child:CachedNetworkImage(
                                            imageUrl: productData.image ?? "",
                                            width: w * 0.3,
                                            height: h * 0.2,
                                            fit: BoxFit.contain,
                                            placeholder:
                                                (BuildContext context,
                                                String url) {
                                              return Center(
                                                child: spinkits
                                                    .getSpinningLinespinkit(),
                                              );
                                            },
                                            errorWidget:
                                                (BuildContext context,
                                                String url,
                                                dynamic error) {
                                              // Handle error in case the image fails to load
                                              return Icon(Icons.error);
                                            },
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
      bottomNavigationBar: SafeArea(
        child: Container(
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
      ),
    ): NoInternetWidget();
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
            return SafeArea(
              child: Padding(
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
                                    padding: EdgeInsets.all(5),
                                    width: w * 0.06,
                                    height: w * 0.06,
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
                          ]))),
            );
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
            return SafeArea(
              child: Padding(
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
                              padding: EdgeInsets.all(5),
                              width: w * 0.06,
                              height: w * 0.06,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: InkResponse(
                              onTap: () async{
                               await GetProductcategoryList(
                                  widget.selectid,
                                  "",
                                  "",
                                 "",
                                );
              
                                setState(() {
                                  selectedMinPrice = 0;  // or null
                                  selectedMaxPrice = 0;  // or null
                                });
                                Navigator.pop(context);  // Close the filter modal
                              },
                              child: Container(
                                width: w * 0.4,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Color(0xff110B0F),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    "Clear Filter",
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
                          Center(
                            child: InkResponse(
                              onTap: () async {
                                // Apply the filter and fetch the data
                                await
                                GetProductcategoryList(
                                  widget.selectid,
                                  "",
                                  selectedMinPrice.toInt(),
                                  selectedMaxPrice.toInt(),
                                );
              
              
              
              
                                // Close the filter modal after applying
                                Navigator.pop(context);
              
                                print("Applied Filter: Min Price = $selectedMinPrice, Max Price = $selectedMaxPrice");
                              },
                              child: Container(
                                width: w * 0.4,
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
                        ],
                      ),
              
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
