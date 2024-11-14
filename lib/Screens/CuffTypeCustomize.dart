import 'package:flutter/material.dart';

class CuffTypeCustomize extends StatefulWidget {
  const CuffTypeCustomize({super.key});

  @override
  State<CuffTypeCustomize> createState() => _CuffTypeCustomizeState();
}

class _CuffTypeCustomizeState extends State<CuffTypeCustomize> {
  final List<Map<String, String>> grid = [
    {"image": 'assets/cuff1.png', 'name': 'Large Round '},
    {"image": 'assets/cuff2.png', 'name': 'Are-Shape'},
    {"image": 'assets/cuff3.png', 'name': 'Double Button '},
    {"image": 'assets/cuff4.png', 'name': 'Cham Fering '},

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

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.pink,
    Colors.brown,
    Colors.cyan,
    Colors.teal,
    Colors.indigo,
    Colors.grey,
  ];


  List<Color> colorss = [
    Colors.red,
    Colors.blue,
    Colors.green,

    // Add more colors as needed
  ];

  List<Color> selectedColors = [];
  List<String> selectedSizes = []; // Change to List<String>

  void _toggleColorSelection(Color color) {
    setState(() {
      selectedColors.clear();
      selectedColors.add(color);
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

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                InkResponse(
                  onTap: () {
                    // Handle tap event
                  },
                  child: Container(
                    height: h * 0.3,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    decoration: BoxDecoration(color: Color(0xffEDF4FB)),
                    child: Center(
                      child: Image.asset(
                        'assets/shirt.png',
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
                children: List.generate(
                  grid.length,
                      (index) {
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
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                  grid[index]['image']!,
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
                                grid[index]['name']!,
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
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                      CircleAvatar(
                        radius: 12,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/postedBY.png",
                            fit: BoxFit.contain,
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
                    itemCount: colors.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final color = colors[index];
                      return GestureDetector(
                        onTap: () => _toggleColorSelection(color),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: selectedColors.contains(color)
                                    ? Color(0xffCAA16C)
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
                      Spacer(),
                      Text(
                        "Size Chart",
                        style: TextStyle(
                          color: Color(0xff088AB2),
                          fontFamily: 'RozhaOne',
                          fontSize: 14,
                          height: 19.36 / 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.01),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      childAspectRatio: 1,
                    ),
                    itemCount: size.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final sizeItem = size[index];
                      return GestureDetector(
                        onTap: () {
                          _toggleSizeSelection(sizeItem['name']!);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: selectedSizes.contains(sizeItem['name'])
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
                                  sizeItem['name'] ?? "",
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
                          child: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.01),
                  if (_isDescriptionVisible)
                    Text(
                      "This stylish customizable shirt is designed for ultimate comfort and versatility. Made from a premium cotton blend, it features various collar styles and a range of vibrant colors. Perfect for any setting, it’s available in sizes from XS to 5XL.",
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

// Product Details
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
                          child: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.01),
                  if (_isProductDetailsVisible)
                    Text(
                      "Material: Premium Cotton Blend\nAvailable Colors: Red, Blue, Green, Black\nSizes: XS to 5XL\nCare Instructions: Machine wash cold, tumble dry low.",
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
                          child: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.01),
                  if (_isShippingDetailsVisible)
                    Text(
                      "Free shipping on orders over 50. Estimated delivery time: 5-7 business days. Expedited shipping options available at checkout.",
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

// Reviews
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
                          return Icon(index < 4 ? Icons.star : Icons.star_border, color: Color(0xffF79009), size: 20);
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
                          child: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white, size: 20),
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
                                  child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: colorss.map((color) {
                                          return GestureDetector(
                                            onTap: () =>
                                                _toggleColorSelection(color),
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(100),
                                                border: Border.all(
                                                  color:
                                                  selectedColors.contains(color)
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
                                                  BorderRadius.circular(100),
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
      ),
      bottomNavigationBar:
      Padding(
        padding: const EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: w * 0.45,
              height: h*0.06,
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
            InkResponse(onTap: (){

            },
              child: Container(
                width: w * 0.45,
                height: h*0.06,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Color(0xff110B0F),
                    borderRadius: BorderRadius.circular(6)),
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
