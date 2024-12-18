import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outfitter/AddRating.dart';
import 'package:outfitter/Screens/ReviewListScreen.dart';
import 'package:outfitter/Screens/UploderProfile.dart';
import 'package:outfitter/providers/CartProvider.dart';
import 'package:outfitter/providers/ProductDetailsProvider.dart';
import 'package:outfitter/providers/ProductListProvider.dart';
import 'package:outfitter/utils/CustomSnackBar.dart';
import 'package:provider/provider.dart';

import '../Model/ProductsDetailsModel.dart';
import '../Services/UserApi.dart';
import '../Services/otherservices.dart';
import '../providers/WishlistProvider.dart';
import '../utils/CustomAppBar1.dart';
import 'Cart.dart';
import 'dart:developer' as developer;
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ProductDetailsScreen extends StatefulWidget {
  String productid;
  String category_id;
  ProductDetailsScreen(
      {super.key, required this.productid, required this.category_id});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 0;
  int rating = 0;
  final spinkits = Spinkits3();
  bool _isDescriptionVisible = false;

  int _selectedIndex = 0;

  List<Color> colorss = [
    Colors.red,
    Colors.blue,
    Colors.green,
  ];

  int? selectedIndex;
  int? selectedSizeIndex;
  String? selectedSizeItem;
  String? selectedColor;

  String? selectedNeck;
  String? selectedSleeve;
  String? selectedPlacket;
  String? selectedPleat;

  Color hexToColor(String hexColor) {
    final hex = hexColor.replaceAll('#', '');
    if (hex.length == 6) {
      return Color(
          int.parse('FF$hex', radix: 16)); // Adding FF for full opacity
    } else {
      throw FormatException("Invalid Hex color code");
    }
  }

// Function to toggle the color selection
  void _toggleColorSelection(int index, String hexColor) {
    setState(() {
      // If the tapped color is already selected, deselect it (set to null)
      if (selectedIndex == index) {
        selectedIndex = null;
        selectedColor = null;
      } else {
        selectedIndex = index; // Select new color based on index
        selectedColor =
            hexColor; // Set the selected color based on the hex value
      }
    });
  }

// Toggling the selection
  void _toggleSizeSelection(int index, String sizeItem) {
    setState(() {
      // If the tapped size is already selected, deselect it (set selectedIndex to null)
      if (selectedSizeIndex == index) {
        selectedSizeIndex = null;
        selectedSizeItem = null;
      } else {
        selectedSizeIndex = index; // Select the new index
        selectedSizeItem = sizeItem; // Select the new size based on index
      }
      print("Selected Size: $selectedSizeItem, Index: $selectedSizeIndex");
    });
  }

  void _toggleDescriptionVisibility() {
    setState(() {
      _isDescriptionVisible = !_isDescriptionVisible;
    });
  }

  bool _isProductDetailsVisible = false;
  bool _isShippingDetailsVisible = false;
  bool _isReviewsVisible = false;

  void _toggleProductDetailsVisibility() {
    setState(() {
      _isProductDetailsVisible = !_isProductDetailsVisible;
    });
  }

  void _toggleShippingDetailsVisibility() {
    setState(() {
      _isShippingDetailsVisible = !_isShippingDetailsVisible;
    });
  }

  void _toggleReviewsVisibility() {
    setState(() {
      _isReviewsVisible = !_isReviewsVisible;
    });
  }

  Future<void> AddToCartApi(String productID, String quantity) async {
    final cart_provider = Provider.of<CartProvider>(context, listen: false);
    var msg = await cart_provider.addToCartApi(
        productID,
        quantity,
        selectedColor ?? "",
        selectedSizeItem ?? "",
        selectedSleeve ?? "",
        selectedNeck ?? "",
        selectedPleat ?? "",
        selectedPlacket ?? "");
    if (msg != "" || msg != null) {
      CustomSnackBar.show(context, msg ?? "");
    }
  }

  final List<String> tabItems = [
    'Collar',
    'CuffType',
    'PlacketType',
    'BackBody'
  ];
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    GetProductDetails();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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

  Future<void> GetProductDetails() async {
    final ProductdetailsProvider =
        Provider.of<ProductDetailsProvider>(context, listen: false);
    final ProductlistProvider =
        Provider.of<ProductListProvider>(context, listen: false);
    ProductdetailsProvider.fetchProductDetails(widget.productid);
    ProductlistProvider.fetchProductsList(widget.category_id, "", "", "");
  }

  List<Widget> _getProductWidgets(ProductDetails? productData) {
    switch (_selectedTabIndex) {
      case 0:
        // For the "neck" list
        return _generateWidgetsFromNeck(productData?.neck, 0);
      case 1:
        // For the "sleeve" list
        return _generateWidgetsFromSleeve(productData?.sleeve, 1);
      case 2:
        // For the "placket" list
        return _generateWidgetsFromPlacket(productData?.placket, 2);
      case 3:
        // For the "pleat" list
        return _generateWidgetsFromPleat(productData?.pleat, 3);
      default:
        return [];
    }
  }

  List<Widget> _generateWidgetsFromNeck(List<Neck>? neckList, int tabIndex) {
    print("_generateWidgetsFromNeck called");

    if (neckList == null || neckList.isEmpty) {
      print("neckList is null or empty");
      return [];
    }

    print("neckList has ${neckList.length} items.");

    return List.generate(
      neckList
          .length, // No need for `?? 0` because we've already checked for null/empty
      (index) {
        final data = neckList[index];
        if (data != null) {
          print(
              "Data at index $index: name = ${data.name}, image = ${data.image}");
        } else {
          print("Data at index $index is null");
        }

        return _buildProductWidget(
            data.id, data.image, data.name, index, tabIndex);
      },
    );
  }

  List<Widget> _generateWidgetsFromSleeve(
      List<Sleeve>? sleeveList, int tabIndex) {
    return List.generate(
      sleeveList?.length ?? 0,
      (index) {
        final data = sleeveList?[index];
        return _buildProductWidget(
            data?.id, data?.image, data?.name, index, tabIndex);
      },
    );
  }

  List<Widget> _generateWidgetsFromPlacket(
      List<Placket>? placketList, int tabIndex) {
    return List.generate(
      placketList?.length ?? 0,
      (index) {
        final data = placketList?[index];
        return _buildProductWidget(
            data?.id, data?.image, data?.name, index, tabIndex);
      },
    );
  }

  List<Widget> _generateWidgetsFromPleat(List<Pleat>? pleatList, int tabIndex) {
    return List.generate(
      pleatList?.length ?? 0,
      (index) {
        final data = pleatList?[index];
        return _buildProductWidget(
            data?.id, data?.image, data?.name, index, tabIndex);
      },
    );
  }

  Widget _buildProductWidget(
      String? id, String? imageUrl, String? name, int index, int tabIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        children: [
          InkResponse(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                // Update the selected string based on the tab index
                if (tabIndex == 0) {
                  selectedNeck = id; // Update neck customization
                } else if (tabIndex == 1) {
                  selectedSleeve = id; // Update sleeve customization
                } else if (tabIndex == 2) {
                  selectedPlacket = id; // Update placket customization
                } else if (tabIndex == 3) {
                  selectedPleat = id; // Update pleat customization
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: _selectedIndex == index
                      ? Color(0xffCAA16C) // Highlight selected item
                      : Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                imageUrl ?? "",
                width: 45,
                height: 45,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.15,
              child: Text(
                "${name ?? ""}",
                style: TextStyle(
                  color: Color(0xff4B5565),
                  fontFamily: 'RozhaOne',
                  fontSize: 12,
                  height: 20 / 14,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return (isDeviceConnected == "ConnectivityResult.wifi" ||
            isDeviceConnected == "ConnectivityResult.mobile")
        ? Scaffold(
            appBar: CustomApp(title: 'Product Details', w: w),
            body: Consumer<ProductDetailsProvider>(
                builder: (context, productDetailsProvider, child) {
              final productData = productDetailsProvider.productData;
              final wishlist_status = productDetailsProvider.isInWishlist;
              print("Image:${productData?.image}");

              // Helper function to check if a list is not empty
              bool _isListNotEmpty(List? list) {
                return list != null && list.isNotEmpty;
              }

              // Helper function to return only visible tabs
              List<String> _getVisibleTabItems() {
                List<String> visibleTabs = [];
                if (_isListNotEmpty(productData?.neck ?? []))
                  visibleTabs.add('Collar');
                if (_isListNotEmpty(productData?.sleeve ?? []))
                  visibleTabs.add('CuffType');
                if (_isListNotEmpty(productData?.placket ?? []))
                  visibleTabs.add('PlacketType');
                if (_isListNotEmpty(productData?.pleat ?? []))
                  visibleTabs.add('BackBody');
                return visibleTabs;
              }

              if (productDetailsProvider.isLoading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Color(0xffE7C6A0),
                ));
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Row(children: [
                      //   Container(
                      //       padding: EdgeInsets.only(left: 8, right: 8),
                      //       height: h * 0.03,
                      //       color: _selectedTabIndex == index
                      //           ? Color(0xffE7C6A0)
                      //           : Colors.transparent,
                      //       child: Text("Coller", fontFamily: 'RozhaOne',
                      //         fontWeight: FontWeight.w400,
                      //         fontSize: 15,
                      //         height: 1.6,
                      //         color: Color(0xff110B0F),
                      //         letterSpacing: 0.15,
                      //       ),))
                      //
                      // ],),
                      // Container(
                      //   padding: EdgeInsets.only(top: 8, bottom: 8),
                      //   height: h * 0.04,
                      //   decoration: BoxDecoration(color: Color(0xffE7C6A0)),
                      //   child: Center(
                      //     child: Text(
                      //       "Available until 10hrs 30mins 20secs",
                      //       style: TextStyle(
                      //         color: Color(0xff110B0F),
                      //         fontFamily: 'RozhaOne',
                      //         fontSize: 16,
                      //         height: 20 / 16,
                      //         fontWeight: FontWeight.w400,
                      //       ),
                      //       textAlign: TextAlign.center,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Color(0xffFCFCFD)),
                        child: Column(
                          children: [
                            Container(
                              width: w,
                              child: Text(
                                productData?.title ?? "",
                                style: TextStyle(
                                  color: Color(0xff110B0F),
                                  fontFamily: 'RozhaOne',
                                  fontSize: 22,
                                  height: 32 / 24,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "₹${productData?.salePrice}",
                                  style: TextStyle(
                                    color: Color(0xff4B5565),
                                    fontFamily: 'RozhaOne',
                                    fontSize: 24,
                                    height: 28 / 24,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: w * 0.01),
                                Text(
                                  "₹${productData?.mrp}",
                                  style: TextStyle(
                                    color: Color(0xffF04438),
                                    fontFamily: 'RozhaOne',
                                    fontSize: 16,
                                    height: 24 / 16,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Color(0xffF04438),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Spacer(),
                                if (productData?.ratingStats.averageRating !=
                                    0) ...[
                                  Row(
                                    children: List.generate(5, (starIndex) {
                                      int ratingValue = int.tryParse(productData
                                                  ?.ratingStats.averageRating
                                                  .toString() ??
                                              "") ??
                                          0;
                                      print("RAting:${ratingValue}");
                                      return Icon(
                                        starIndex < ratingValue
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Color(0xffF79009),
                                        size: 14,
                                      );
                                    }),
                                  ),
                                ]
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (productData?.category == "shirts") ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _getVisibleTabItems()
                              .asMap()
                              .entries
                              .map((entry) {
                            int index = entry.key;
                            String label = entry.value;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedTabIndex =
                                      index; // Update selected tab
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                height: h *
                                    0.03, // Set height based on screen height
                                color: _selectedTabIndex == index
                                    ? Color(0xffE7C6A0) // Selected color
                                    : Colors.transparent,
                                child: Center(
                                  child: Text(label,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'RozhaOne',
                                        fontSize: 15,
                                        height: 1.6,
                                        color: Color(0xff110B0F),
                                        letterSpacing: 0.15,
                                      )),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],

                      Stack(
                        children: [
                          InkResponse(
                            onTap: () {
                              // Handle tap event
                            },
                            child: Container(
                              height: h * 0.3,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              decoration:
                                  BoxDecoration(color: Color(0xffEDF4FB)),
                              child: Center(
                                  child: CachedNetworkImage(
                                imageUrl: productData?.image ?? "",
                                height: h * 0.25,
                                width: w * 0.8,
                                fit: BoxFit.contain,
                                placeholder:
                                    (BuildContext context, String url) {
                                  return Center(
                                    child: spinkits.getSpinningLinespinkit(),
                                  );
                                },
                                errorWidget: (BuildContext context, String url,
                                    dynamic error) {
                                  // Handle error in case the image fails to load
                                  return Icon(Icons.error);
                                },
                              )),
                            ),
                          ),
                          // Positioned(
                          //   top: h * 0.15,
                          //   left: 8,
                          //   child: IconButton(
                          //     icon: Icon(Icons.arrow_back_ios),
                          //     onPressed: () {
                          //       // Handle left arrow tap
                          //     },
                          //   ),
                          // ),
                          // Positioned(
                          //   top: h * 0.15,
                          //   right: 8,
                          //   child: IconButton(
                          //     icon: Icon(Icons.arrow_forward_ios),
                          //     onPressed: () {
                          //       // Handle right arrow tap
                          //     },
                          //   ),
                          // ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Column(
                              children: [
                                InkResponse(
                                  onTap: () {
                                    if (wishlist_status ?? false) {
                                      print(
                                          "wishlist Status:${wishlist_status}");
                                      // Remove from wishlist
                                      context
                                          .read<WishlistProvider>()
                                          .removeFromWishlist(widget.productid);
                                      productDetailsProvider
                                          .toggleWishlistStatus();
                                    } else {
                                      print(
                                          "wishlist Status:${wishlist_status}");
                                      // Add to wishlist
                                      context
                                          .read<WishlistProvider>()
                                          .addToWishlist(widget.productid);

                                      productDetailsProvider
                                          .toggleWishlistStatus();
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: wishlist_status == true
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
                                // SizedBox(height: h * 0.01),
                                // Container(
                                //   padding: EdgeInsets.all(8),
                                //   decoration: BoxDecoration(
                                //     color: Color(0xffFCFCFD),
                                //     borderRadius: BorderRadius.circular(100),
                                //   ),
                                //   child: Image.asset(
                                //     "assets/share.png",
                                //     width: 18,
                                //     height: 18,
                                //     fit: BoxFit.contain,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.01),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _getProductWidgets(productData),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row(
                            //   children: [
                            //     Text(
                            //       "POSTED BY",
                            //       style: TextStyle(
                            //         color: Color(0xff121926),
                            //         fontFamily: 'RozhaOne',
                            //         fontSize: 14,
                            //         height: 19.36 / 14,
                            //         fontWeight: FontWeight.w400,
                            //       ),
                            //     ),
                            //     Spacer(),
                            //     InkWell(
                            //       onTap: () {
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (context) => UploaderProfile()));
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
                            //   ],
                            // ),
                            // SizedBox(height: h * 0.01),
                            Divider(
                              thickness: 1,
                              height: 1,
                              color: Color(0xffEEF2F6),
                            ),
                            if (productData?.colors.isNotEmpty ?? false) ...[
                              SizedBox(height: h * 0.01),
                              Text(
                                "COLORS",
                                style: TextStyle(
                                  color: Color(0xff121926),
                                  fontFamily: 'RozhaOne',
                                  fontSize: 14,
                                  height: 19.36 / 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6,
                                  childAspectRatio: 1,
                                ),
                                itemCount: productData?.colors.length ?? 0,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final colorHex = productData?.colors[index];
                                  Color color = hexToColor(colorHex ?? "");
                                  // Set default selection if the list is not empty
                                  if (productData?.colors.isNotEmpty ?? false) {
                                    if (selectedIndex == null) {
                                      selectedIndex =
                                          0; // Default to the first color if no selection
                                      selectedColor = productData?.colors[
                                          selectedIndex ??
                                              0]; // Set the default color
                                    }
                                  }
                                  return GestureDetector(
                                    onTap: () => _toggleColorSelection(
                                        index, colorHex ?? ""),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: selectedIndex == index
                                                ? Color(
                                                    0xffCAA16C) // Highlight selected color with a border
                                                : Colors.transparent,
                                            width: 1,
                                          ),
                                        ),
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color:
                                                color, // Set the color of the container
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],

                            if (productData?.size.isNotEmpty ?? false) ...[
                              SizedBox(height: h * 0.01),
                              Row(
                                children: [
                                  Text(
                                    "SIZE",
                                    style: TextStyle(
                                      color: Color(0xff121926),
                                      fontFamily: 'RozhaOne',
                                      fontSize: 14,
                                      height: 19.36 / 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  // Optionally show "Size Chart" link here if needed.
                                ],
                              ),
                              SizedBox(height: h * 0.01),
                              GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6,
                                  childAspectRatio: 1,
                                ),
                                itemCount: productData?.size.length ?? 0,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final sizeItem = productData?.size[index];

                                  // Default selection to the first index if no size is selected
                                  if (productData?.size.isNotEmpty ?? false) {
                                    if (selectedSizeIndex == null) {
                                      selectedSizeIndex =
                                          0; // Default to the first index
                                      selectedSizeItem = productData?.size[
                                          selectedSizeIndex ??
                                              0]; // Select default size
                                    }
                                  }

                                  return GestureDetector(
                                    onTap: () {
                                      _toggleSizeSelection(
                                          index,
                                          sizeItem ??
                                              ""); // Pass index and size value
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(6),
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: selectedSizeIndex == index
                                                ? Color(
                                                    0xffCAA16C) // Selected item color
                                                : Colors.transparent,
                                            width: 1,
                                          ),
                                        ),
                                        child: Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: Color(0xffFCFCFD),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                color: Color(0xffEEF2F6),
                                                width: 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              sizeItem ?? "",
                                              style: TextStyle(
                                                color: Color(0xff000000),
                                                fontFamily: 'RozhaOne',
                                                fontSize: 16,
                                                height: 19.36 / 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],

                            SizedBox(height: h * 0.01),
                            Row(
                              children: [
                                Text(
                                  "DESCRIPTION",
                                  style: TextStyle(
                                    color: Color(0xff121926),
                                    fontFamily: 'RozhaOne',
                                    fontSize: 14,
                                    height: 19.36 / 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: _toggleDescriptionVisibility,
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Color(0xff9AA4B2),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Icon(
                                        _isDescriptionVisible
                                            ? Icons.keyboard_arrow_up_sharp
                                            : Icons.keyboard_arrow_down_sharp,
                                        color: Colors.white,
                                        size: 20,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(height: h * 0.01),
                            if (_isDescriptionVisible)
                              Text(
                                productData?.description ?? "",
                                style: TextStyle(
                                  color: Color(0xff4B5565),
                                  fontFamily: 'RozhaOne',
                                  fontSize: 14,
                                  height: 19.36 / 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            SizedBox(height: h * 0.01),
                            Divider(
                                thickness: 1,
                                height: 1,
                                color: Color(0xffEEF2F6)),
                            SizedBox(height: h * 0.01),
                            Row(
                              children: [
                                Text(
                                  "PRODUCT DETAILS",
                                  style: TextStyle(
                                    color: Color(0xff121926),
                                    fontFamily: 'RozhaOne',
                                    fontSize: 14,
                                    height: 19.36 / 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: _toggleProductDetailsVisibility,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Color(0xff9AA4B2),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(
                                        _isProductDetailsVisible
                                            ? Icons.keyboard_arrow_up_sharp
                                            : Icons.keyboard_arrow_down_sharp,
                                        color: Colors.white,
                                        size: 20),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: h * 0.01),
                            if (_isProductDetailsVisible)
                              Text(
                                productData?.productDetails ?? "",
                                style: TextStyle(
                                  color: Color(0xff4B5565),
                                  fontFamily: 'RozhaOne',
                                  fontSize: 14,
                                  height: 19.36 / 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            SizedBox(height: h * 0.01),
                            Divider(
                                thickness: 1,
                                height: 1,
                                color: Color(0xffEEF2F6)),
                            SizedBox(height: h * 0.01),
                            Row(
                              children: [
                                Text(
                                  "SHIPPING DETAILS",
                                  style: TextStyle(
                                    color: Color(0xff121926),
                                    fontFamily: 'RozhaOne',
                                    fontSize: 14,
                                    height: 19.36 / 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: _toggleShippingDetailsVisibility,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Color(0xff9AA4B2),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(
                                        _isShippingDetailsVisible
                                            ? Icons.keyboard_arrow_up_sharp
                                            : Icons.keyboard_arrow_down_sharp,
                                        color: Colors.white,
                                        size: 20),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: h * 0.01),
                            if (_isShippingDetailsVisible)
                              Text(
                                productData?.shippingDetails ?? "",
                                style: TextStyle(
                                  color: Color(0xff4B5565),
                                  fontFamily: 'RozhaOne',
                                  fontSize: 14,
                                  height: 19.36 / 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            SizedBox(height: h * 0.01),
                            Divider(
                                thickness: 1,
                                height: 1,
                                color: Color(0xffEEF2F6)),
                            SizedBox(height: h * 0.01),
                            Row(
                              children: [
                                Text(
                                  "REVIEWS",
                                  style: TextStyle(
                                    color: Color(0xff121926),
                                    fontFamily: 'RozhaOne',
                                    fontSize: 14,
                                    height: 19.36 / 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: w * 0.01),
                                Spacer(),
                                GestureDetector(
                                  onTap: _toggleReviewsVisibility,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Color(0xff9AA4B2),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(
                                        _isReviewsVisible
                                            ? Icons.keyboard_arrow_up_sharp
                                            : Icons.keyboard_arrow_down_sharp,
                                        color: Colors.white,
                                        size: 20),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: h * 0.01),
                            if (_isReviewsVisible) ...[
                              if (productData?.ratingStats.averageRating !=
                                  0.0) ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Reviews",
                                      style: TextStyle(
                                        color: Color(0xff121926),
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                        height: 19.36 / 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    InkResponse(
                                      onTap: () async {
                                        var res = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddProductRating(
                                                    id: productData?.id),
                                          ),
                                        );
                                        if (res == true) {
                                          if (res == true) {
                                            final ProductdetailsProvider =
                                                Provider.of<
                                                        ProductDetailsProvider>(
                                                    context,
                                                    listen: false);
                                            ProductdetailsProvider
                                                .fetchProductDetails(
                                                    widget.productid);
                                          }
                                        }
                                      },
                                      child: Text(
                                        "Write review",
                                        style: TextStyle(
                                          color: Color(0xff088AB2),
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                          height: 19.36 / 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ] else ...[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkResponse(
                                      onTap: () async {
                                        var res = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddProductRating(
                                                      id: productData?.id ??
                                                          ""),
                                            ));
                                        if (res == true) {
                                          final ProductdetailsProvider =
                                              Provider.of<
                                                      ProductDetailsProvider>(
                                                  context,
                                                  listen: false);
                                          ProductdetailsProvider
                                              .fetchProductDetails(
                                                  widget.productid);
                                        }
                                      },
                                      child: Container(
                                          height: 40,
                                          width: w * 0.88,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                              color: Color(0xff110B0F),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                8,
                                              )),
                                          child: Center(
                                            child: Text(
                                              "Write a Review",
                                              style: TextStyle(
                                                  fontFamily: "RozhaOne",
                                                  color: Color(0xffCAA16C),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            ),
                                          )),
                                    ),
                                  ],
                                )
                              ],
                              if (productData?.ratingStats.averageRating !=
                                  0.0) ...[
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Container(
                                      width: w * 0.4,
                                      decoration: BoxDecoration(),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  productData?.ratingStats
                                                          .averageRating
                                                          .toString() ??
                                                      '',
                                                  style: TextStyle(
                                                    color: Color(0xff110B0F),
                                                    fontFamily: 'RozhaOne',
                                                    fontSize: 70,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Icon(
                                                size: 22,
                                                Icons.star_rate_rounded,
                                                color: Colors.orangeAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 115,
                                      width: w * 0.001,
                                      color: Color(0xff000000),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: w * 0.5,
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              for (int i = 5; i > 0; i--) ...[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 2),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "$i",
                                                        style: TextStyle(
                                                            fontFamily: "Inter",
                                                            fontSize: 14.5),
                                                      ),
                                                      Icon(
                                                        size: 12,
                                                        Icons.star_rate_rounded,
                                                        color:
                                                            Colors.orangeAccent,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                          SizedBox(
                                            width: w * 0.4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Generate the rating progress bars
                                                for (int i = 5; i > 0; i--) ...[
                                                  _buildRatingRow(
                                                    index: i.toString(),
                                                    percentage: productData
                                                                ?.ratingStats
                                                                .ratingsGroup[
                                                            i.toString()] ??
                                                        0.0,
                                                    width: w,
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ReviewsListScreen(
                                            productID: productData?.id ?? "",
                                          ),
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "See All Reviews",
                                        style: TextStyle(
                                          color: Color(0xff088AB2),
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                          height: 19.36 / 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              if (productData?.recentReviews != null &&
                                  productData!.recentReviews.isNotEmpty) ...[
                                SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    itemCount:
                                        productData.recentReviews.length ?? 0,
                                    scrollDirection: Axis.horizontal,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var data =
                                          productData.recentReviews[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          elevation: 4.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Rounded corners
                                          ),
                                          child: Container(
                                            width: 300,
                                            padding: EdgeInsets.all(
                                                12), // Padding inside the card
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // Name wrapped with an Expanded widget to handle overflow
                                                    Expanded(
                                                      child: Text(
                                                        "${data.customer ?? ''}",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff121926),
                                                          fontFamily:
                                                              'RozhaOne',
                                                          fontSize: 14,
                                                          height: 19.36 / 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        maxLines:
                                                            1, // Allow the text to span multiple lines
                                                        overflow: TextOverflow
                                                            .ellipsis, // Ellipsis for overflow text
                                                        softWrap:
                                                            true, // Ensure text wraps to the next line
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            5), // Space between customer and date
                                                    Text(
                                                      "Posted on: ${data.createdAt ?? ''}",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff617C9D),
                                                        fontFamily: 'RozhaOne',
                                                        fontSize: 15,
                                                        height: 19.36 / 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                if (data.rating != 0.0) ...[
                                                  Row(
                                                    children: List.generate(5,
                                                        (starIndex) {
                                                      int ratingValue =
                                                          int.tryParse(data
                                                                      .rating
                                                                      .toString() ??
                                                                  "") ??
                                                              0;
                                                      print(
                                                          "Rating value:${ratingValue}");
                                                      return Icon(
                                                        starIndex < ratingValue
                                                            ? Icons.star
                                                            : Icons.star_border,
                                                        color:
                                                            Color(0xffF79009),
                                                        size: 14,
                                                      );
                                                    }),
                                                  ),
                                                ],
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${data.comment ?? ''}",
                                                  style: TextStyle(
                                                    color: Color(0xff121926),
                                                    fontFamily: 'RozhaOne',
                                                    fontSize: 14,
                                                    height: 19.36 / 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ],
                            SizedBox(height: h * 0.01),
                            Divider(
                                thickness: 1,
                                height: 1,
                                color: Color(0xffEEF2F6)),
                            SizedBox(height: h * 0.03),
                            Consumer<ProductListProvider>(
                                builder: (context, profileProvider, child) {
                              final products_list = profileProvider.productList;
                              return Column(
                                children: [
                                  if (products_list.length != 0) ...[
                                    Text(
                                      "YOU MAY ALSO LIKE",
                                      style: TextStyle(
                                        color: Color(0xff121926),
                                        fontFamily: 'RozhaOne',
                                        fontSize: 22,
                                        height: 19.36 / 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: h * 0.02),
                                    SingleChildScrollView(
                                      scrollDirection: Axis
                                          .horizontal, // Enables horizontal scrolling
                                      child: Row(
                                        children: List.generate(
                                            products_list.length, (index) {
                                          var data = products_list[index];
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailsScreen(
                                                            productid:
                                                                data.id ?? "",
                                                            category_id: widget
                                                                .category_id),
                                                  ));
                                            },
                                            child: Stack(children: [
                                              Container(
                                                width: w * 0.45,
                                                padding: EdgeInsets.all(8.0),
                                                margin: EdgeInsets.only(
                                                    left: 10, right: 8.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Color(0xffEEF2F6),
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                        child:
                                                            CachedNetworkImage(
                                                      imageUrl:
                                                          data.image ?? "",
                                                      height: h * 0.2,
                                                      width: w * 0.45,
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
                                                        return Icon(
                                                            Icons.error);
                                                      },
                                                    )),
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
                                                        color:
                                                            Color(0xff121926),
                                                        fontFamily: 'RozhaOne',
                                                        fontSize: 16,
                                                        height: 24 / 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      maxLines:
                                                          2, // Limits the number of lines to 2
                                                      overflow: TextOverflow
                                                          .ellipsis, // Adds ellipsis when text overflows
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "₹${data.salePrice ?? ""}",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff121926),
                                                            fontFamily:
                                                                'RozhaOne',
                                                            fontSize: 18,
                                                            height: 24 / 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: w * 0.03),
                                                        Text(
                                                          "₹${data.mrp ?? ""}",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff617C9D),
                                                            fontFamily:
                                                                'RozhaOne',
                                                            fontSize: 15,
                                                            height: 24 / 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            decorationColor:
                                                                Color(
                                                                    0xff617C9D),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: 8,
                                                right: 8,
                                                child: InkResponse(
                                                  onTap: () {
                                                    if (data.isInWishlist ??
                                                        false) {
                                                      // Remove from wishlist
                                                      context
                                                          .read<
                                                              WishlistProvider>()
                                                          .removeFromWishlist(
                                                              data.id ?? "");
                                                    } else {
                                                      // Add to wishlist
                                                      context
                                                          .read<
                                                              WishlistProvider>()
                                                          .addToWishlist(
                                                              data.id ?? "");
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: data.isInWishlist ??
                                                            false
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
                                      ),
                                    ),
                                  ]
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
            bottomNavigationBar: Consumer<ProductDetailsProvider>(
                builder: (context, productDetailsProvider, child) {
              if (productDetailsProvider.isLoading) {
                return SizedBox
                    .shrink(); // Hide the bottom navigation bar when data is null or empty
              } else {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Cart(),
                              ));
                        },
                        child: Container(
                          width: w * 0.45,
                          height: h * 0.06,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xffCAA16C), width: 1),
                              borderRadius: BorderRadius.circular(6)),
                          child: Center(
                            child: Text(
                              "VIEW CART",
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
                      InkResponse(
                          onTap: () {
                            AddToCartApi(widget.productid, "1");
                          },
                          child: Container(
                              width: w * 0.45,
                              height: h * 0.06,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Color(0xff110B0F),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                  child: Text(
                                "ADD TO CART",
                                style: TextStyle(
                                  color: Color(0xffE7C6A0),
                                  fontFamily: 'RozhaOne',
                                  fontSize: 16,
                                  height: 21.06 / 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              )
                                  //     :
                                  // Row(
                                  //         mainAxisAlignment: MainAxisAlignment.center,
                                  //         children: [
                                  //           Container(width:w*0.06,height: h*0.03,
                                  //             decoration: BoxDecoration(
                                  //                 border: Border.all(
                                  //                     color: Color(0xffffffff), width: 1)),
                                  //             child: IconButton( padding: EdgeInsets.all(0),
                                  //               icon: Icon(Icons.remove,
                                  //                   size: 20,    color: Color(0xffE7C6A0),), // color11
                                  //               onPressed: () {
                                  //                 setState(() {
                                  //                   if (quantity > 0) quantity--;
                                  //                 });
                                  //                 AddToCartApi(quantity.toString());
                                  //               },
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //               width:
                                  //                   8), // Space between the icon and quantity
                                  //           Text(
                                  //             "$quantity", // Show the quantity next to the cart icon
                                  //             style: TextStyle(
                                  //               color: Color(0xffE7C6A0),
                                  //               fontFamily: 'RozhaOne',
                                  //               fontSize: 16,
                                  //               height: 21.06 / 16,
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //             textAlign: TextAlign.center,
                                  //           ),
                                  //           SizedBox(width: 8),
                                  //           Container(width:w*0.06,height: h*0.03,
                                  //             decoration: BoxDecoration(
                                  //                 border: Border.all(
                                  //                     color: Color(0xffffffff), width: 1)),
                                  //             child: IconButton( padding: EdgeInsets.all(0),
                                  //               icon: Icon(Icons.add,
                                  //                 size: 20,    color: Color(0xffE7C6A0),), // color11
                                  //               onPressed: () {
                                  //                 setState(() {
                                  //                   if (quantity > 0) quantity++;
                                  //                 });
                                  //                 AddToCartApi(quantity.toString());
                                  //               },
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  )))
                    ],
                  ),
                );
              }
            }),
          )
        : NoInternetWidget();
  }

  Widget _buildRatingRow({
    required String index,
    required double percentage,
    required double width,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 6),
      width: width * 0.43, // Set the desired width for each rating bar
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // LinearProgressIndicator for each rating
          SizedBox(
            width: width * 0.26, // Progress bar width
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3.0),
              child: LinearProgressIndicator(
                value: percentage / 100.0, // Convert percentage to 0-1 range
                minHeight: 4.0,
                valueColor: AlwaysStoppedAnimation(Color(0xff8ECAE6)),
                backgroundColor: Colors.grey,
              ),
            ),
          ),
          // Text widget displaying the percentage value
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              "${percentage.toStringAsFixed(0)}%", // Show percentage
              style: TextStyle(
                color: Color(0xff697586),
                fontFamily: 'RozhaOne',
                fontSize: 14,
                height: 24 / 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
