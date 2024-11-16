import 'package:flutter/material.dart';
import 'package:outfitter/Screens/UploderProfile.dart';
import 'package:outfitter/providers/CartProvider.dart';
import 'package:outfitter/providers/ProductDetailsProvider.dart';
import 'package:outfitter/utils/CustomSnackBar.dart';
import 'package:provider/provider.dart';

import '../Model/ProductsDetailsModel.dart';
import '../Services/UserApi.dart';
import '../utils/CustomAppBar.dart';
import '../utils/CustomAppBar1.dart';

class ProductDetailsScreen extends StatefulWidget {
  String productid;
  ProductDetailsScreen({super.key,required this.productid});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 0;
  final List<Map<String, String>> grid = [
    {"image": 'assets/c1.png', 'name': 'Peaked Collar'},
    {"image": 'assets/c2.png', 'name': 'Spread Collar'},
    {"image": 'assets/c3.png', 'name': 'Small Peaked'},
    {"image": 'assets/c4.png', 'name': 'Button Down'},
    {"image": 'assets/c4.png', 'name': 'Pin Collar'},
  ];
  final List<Map<String, String>> grid1 = [
    {"image": 'assets/cuff1.png', 'name': 'Large Round '},
    {"image": 'assets/cuff2.png', 'name': 'Are-Shape'},
    {"image": 'assets/cuff3.png', 'name': 'Double Button '},
    {"image": 'assets/cuff4.png', 'name': 'Cham Fering '},

  ];
  final List<Map<String, String>> grid2 = [
    {"image": 'assets/planket1.png', 'name': 'Bow Pleat'},
    {"image": 'assets/planket2.png', 'name': 'Hidden Placket'},

  ];
  final List<Map<String, String>> grid3 = [
    {"image": 'assets/backbody1.png', 'name': 'Bow Pleat'},
    {"image": 'assets/backbody2.png', 'name': 'Both Sides'},
    {"image": 'assets/backbody3.png', 'name': 'Waist Pleat'},

  ];
  bool _isDescriptionVisible = false;
  final List<Map<String, String>> size = [
    {'name': 'XS'},
    {'name': 'S'},
    {'name': 'M'},
    {'name': 'L'},
    {'name': 'XL'},
    {'name': '2XL'},
    {'name': '3XL'},
    {'name': '4XL'},
    {'name': '5XL'},
  ];
  final List<Map<String, String>> grids = [
    {"image": 'assets/hoodie.png', 'name': 'HOODIE'},
    {"image": 'assets/jeans.png', 'name': 'JEANS'},
    {"image": 'assets/sleaves.png', 'name': 'HALF SLEEVES'},
    {"image": 'assets/cargo.png', 'name': 'CARGO'},
    {"image": 'assets/shirt.png', 'name': 'SHIRT'},
    {"image": 'assets/formals.png', 'name': 'FORMALS'},
    {"image": 'assets/polo.png', 'name': 'POLO'},
    {"image": 'assets/trousar.png', 'name': 'TROUSERS'},
  ];
  int _selectedIndex = 0;

  List<Color> colorss = [
    Colors.red,
    Colors.blue,
    Colors.green,
  ];

  List<Color> selectedColors = [];
  List<String> selectedSizes = [];


  Color hexToColor(String hexColor) {
    final hex = hexColor.replaceAll('#', '');
    if (hex.length == 6) {
      return Color(int.parse('FF$hex', radix: 16)); // Adding FF for full opacity
    } else {
      throw FormatException("Invalid Hex color code");
    }
  }

  void _toggleColorSelection(String colorHex) {
    setState(() {
      Color color = hexToColor(colorHex);
      if (selectedColors.contains(color)) {
        selectedColors.remove(color); // Deselect color
      } else {
        selectedColors
            .clear(); // Clear other selections if you want single selection
        selectedColors.add(color); // Select new color
      }
    });
  }


  void _toggleSizeSelection(String sizeName) {
    setState(() {
      selectedSizes.clear(); // Clear previous selection
      selectedSizes.add(sizeName); // Add the newly selected size
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

  Future<void>AddToCartApi(String productID,String quantity) async {
    final cart_provider =
    Provider.of<CartProvider>(context, listen: false);
    var msg =await cart_provider.addToCartApi(productID,quantity);
    if(msg!="" || msg!=null){
      CustomSnackBar.show(context, msg??"");
    }
  }
  final List<String> tabItems = ['Collar', 'CuffType', 'PlacketType', 'BackBody'];
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    GetProductDetails();

  }
  Future<void> GetProductDetails() async {
    final ProductdetailsProvider = Provider.of<ProductDetailsProvider>(context, listen: false);
    ProductdetailsProvider.fetchProductDetails(widget.productid);
  }

  List<Widget> _getProductWidgets(ProductDetails? productData) {
    switch (_selectedTabIndex) {
      case 0:
      // For the "neck" list
        return _generateWidgetsFromNeck(productData?.neck);
      case 1:
      // For the "sleeve" list
        return _generateWidgetsFromSleeve(productData?.sleeve);
      case 2:
      // For the "placket" list
        return _generateWidgetsFromPlacket(productData?.placket);
      case 3:
      // For the "pleat" list
        return _generateWidgetsFromPleat(productData?.pleat);
      default:
        return [];
    }
  }

  List<Widget> _generateWidgetsFromNeck(List<Neck>? neckList) {
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

        return _buildProductWidget(data.image, data.name, index);
      },
    );
  }

  List<Widget> _generateWidgetsFromSleeve(List<Sleeve>? sleeveList) {
    return List.generate(
      sleeveList?.length ?? 0,
          (index) {
        final data = sleeveList?[index];
        return _buildProductWidget(data?.image, data?.name, index);
      },
    );
  }

  List<Widget> _generateWidgetsFromPlacket(List<Placket>? placketList) {
    return List.generate(
      placketList?.length ?? 0,
          (index) {
        final data = placketList?[index];
        return _buildProductWidget(data?.image, data?.name, index);
      },
    );
  }

  List<Widget> _generateWidgetsFromPleat(List<Pleat>? pleatList) {
    return List.generate(
      pleatList?.length ?? 0,
          (index) {
        final data = pleatList?[index];
        return _buildProductWidget(data?.image, data?.name, index);
      },
    );
  }

  Widget _buildProductWidget(String? imageUrl, String? name, int index) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        children: [
          InkResponse(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: _selectedIndex == index
                      ? Color(0xffCAA16C)
                      : Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(7)),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  imageUrl ?? "",
                  width: 45,
                  height: 45,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Container(
              width: w * 0.18,
              child: Text(
                name ?? "",
                style: TextStyle(
                  color: Color(0xff4B5565),
                  fontFamily: 'RozhaOne',
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.w400,
                ),
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
    return Scaffold(
      appBar: CustomApp(title: 'Product Details', w: w),
      body: Consumer<ProductDetailsProvider>(
          builder: (context, profileProvider, child) {
            final productData = profileProvider.productData;
            print("Image:${productData?.image}");
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
                    height: h * 0.14,
                    decoration: BoxDecoration(color: Color(0xffFCFCFD)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: w * 0.02),
                            Text(
                              productData?.title??"",
                              style: TextStyle(
                                color: Color(0xff110B0F),
                                fontFamily: 'RozhaOne',
                                fontSize: 24,
                                height: 32 / 24,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: h * 0.02),
                        Row(
                          children: [
                            Text(
                              productData?.mrp.toString()??"",
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
                            SizedBox(width: w * 0.01),
                            Text(
                              productData?.salePrice.toString()??"",
                              style: TextStyle(
                                color: Color(0xff4B5565),
                                fontFamily: 'RozhaOne',
                                fontSize: 16,
                                height: 28 / 16,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Spacer(),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                    index < 4 ? Icons.star : Icons.star_border,
                                    color: Color(0xffF79009),
                                    size: 20);
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: tabItems.asMap().entries.map((entry) {
                      int index = entry.key;
                      String label = entry.value;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTabIndex = index; // Update selected tab
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: h * 0.03, // Set height based on screen height
                          color: _selectedTabIndex == index
                              ? Color(0xffE7C6A0) // Selected color
                              : Colors.transparent,
                          child: Center(
                            child: Text(
                                label,
                                style: TextStyle( fontWeight: FontWeight.w400,fontFamily: 'RozhaOne',
                                  fontSize: 15,
                                  height: 1.6,
                                  color: Color(0xff110B0F),
                                  letterSpacing: 0.15,)

                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),


                  Stack(
                    children: [
                      InkResponse(
                        onTap: () {
                          // Handle tap event
                        },
                        child: Container(
                          height: h * 0.3,
                          padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          decoration: BoxDecoration(color: Color(0xffEDF4FB)),
                          child: Center(
                            child: Image.network(
                              productData?.image??"",
                              fit: BoxFit.contain,
                              height: h * 0.25,
                              width: w * 0.8,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: h * 0.15,
                        left: 8,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            // Handle left arrow tap
                          },
                        ),
                      ),
                      Positioned(
                        top: h * 0.15,
                        right: 8,
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            // Handle right arrow tap
                          },
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xffFCFCFD),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Image.asset(
                                "assets/fav.png",
                                width: 18,
                                height: 18,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: h * 0.01),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xffFCFCFD),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Image.asset(
                                "assets/share.png",
                                width: 18,
                                height: 18,
                                fit: BoxFit.contain,
                              ),
                            ),
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
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "POSTED BY",
                              style: TextStyle(
                                color: Color(0xff121926),
                                fontFamily: 'RozhaOne',
                                fontSize: 14,
                                height: 19.36 / 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UploaderProfile()));
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
                          ],
                        ),
                        SizedBox(height: h * 0.01),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: Color(0xffEEF2F6),
                        ),
                        if(productData?.colors.length != 0)...[
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
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              childAspectRatio: 1,
                            ),
                            itemCount: productData?.colors?.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final colorHex = productData?.colors?[index];
                              Color color = hexToColor(colorHex ?? "");
                              return GestureDetector(
                                onTap: () => _toggleColorSelection(colorHex ?? ""),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: selectedColors.contains(color)
                                            ? Color(
                                            0xffCAA16C) // Highlight selected color
                                            : Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                        if(productData?.size?.length != 0)...[
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
                              // Spacer(),
                              // Text(
                              //   "Size Chart",
                              //   style: TextStyle(
                              //     color: Color(0xff088AB2),
                              //     fontFamily: 'RozhaOne',
                              //     fontSize: 14,
                              //     height: 19.36 / 14,
                              //     fontWeight: FontWeight.w400,
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(height: h * 0.01),
                          GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              childAspectRatio: 1,
                            ),
                            itemCount: productData?.size.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final sizeItem = productData?.size[index];
                              return GestureDetector(
                                onTap: () {
                                  _toggleSizeSelection(sizeItem ?? "");
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: selectedSizes.contains(sizeItem ?? "")
                                            ? Color(0xffCAA16C)
                                            : Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Color(0xffFCFCFD),
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(
                                            color: Color(0xffEEF2F6), width: 1),
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
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Icon(
                                    _isDescriptionVisible ? Icons.keyboard_arrow_up_sharp:Icons.keyboard_arrow_down_sharp ,
                                    color: Colors.white,
                                    size: 20,
                                  )

                              ),
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
                        Divider(thickness: 1, height: 1, color: Color(0xffEEF2F6)),
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
                                child: Icon(_isProductDetailsVisible? Icons.keyboard_arrow_up_sharp:Icons.keyboard_arrow_down_sharp ,
                                    color: Colors.white, size: 20),
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
                        Divider(thickness: 1, height: 1, color: Color(0xffEEF2F6)),
                        SizedBox(height: h * 0.01),

// Shipping Details
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
                                child: Icon( _isShippingDetailsVisible?Icons.keyboard_arrow_up_sharp:Icons.keyboard_arrow_down_sharp ,
                                    color: Colors.white, size: 20),
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
                        Divider(thickness: 1, height: 1, color: Color(0xffEEF2F6)),
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
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                    index < 4 ? Icons.star : Icons.star_border,
                                    color: Color(0xffF79009),
                                    size: 20);
                              }),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: _toggleReviewsVisibility,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xff9AA4B2),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(_isReviewsVisible?Icons.keyboard_arrow_up_sharp:Icons.keyboard_arrow_down_sharp ,
                                    color: Colors.white, size: 20),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h * 0.01),
                        if (_isReviewsVisible)
                          Text(
                            "Customers love this shirt! 'Fits perfectly and the fabric is so soft!' - Jane D.\n'Great value for the price!' - John S.",
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
                        Divider(thickness: 1, height: 1, color: Color(0xffEEF2F6)),
                        SizedBox(height: h * 0.01),
                        Text(
                          "YOU MAY ALSO LIKE",
                          style: TextStyle(
                            color: Color(0xff121926),
                            fontFamily: 'RozhaOne',
                            fontSize: 14,
                            height: 19.36 / 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: h * 0.02),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.46,
                          ),
                          itemCount: grid.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    InkResponse(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => Home(),
                                        //   ),
                                        // );
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
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Container(
                                                  child: Image.asset(
                                                    grids[index]['image']!,
                                                    fit: BoxFit.contain,
                                                    width: w * 0.3,
                                                    height: h * 0.2,
                                                  )),
                                            ),
                                            const SizedBox(height: 15),
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 12,
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      "assets/postedBY.png",
                                                      fit: BoxFit.contain,
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
                                              "Straight Regular Jeans",
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
                                                  "₹2340.00",
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
                                                  "₹2340.00",
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
                                              children: colorss.map((color) {
                                                return GestureDetector(
                                                  onTap: () {

                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          100),
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
                                                        color:
                                                        // selectedColors.contains(color)
                                                        //     ?
                                                        color,
                                                        // : Colors.grey[300],
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
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFE5E6),
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: Image.asset(
                                          "assets/fav.png",
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
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: w * 0.45,
              height: h * 0.06,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffCAA16C), width: 1),
                  borderRadius: BorderRadius.circular(6)),
              child: Center(
                child: Text(
                  "BUY NOW",
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
      ),
    );
  }
}