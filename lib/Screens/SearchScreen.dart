import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:outfitter/Screens/ProductDetailsScreen.dart';

import '../Model/ProductsListModel.dart';
import '../Services/UserApi.dart';
import '../utils/CustomAppBar1.dart';
import '../utils/CustomSnackBar.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  List<ProductsList> products = [];
  bool isLoading = false;

  // Define the search query
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchProductsApi(String query) async {
    final res = await Userapi.fetchProducts(query);
    if (res != null) {
      setState(() {
        if (res.settings?.success == 1) {
          products = res.data ?? [];
          isLoading = false;
        } else {
          isLoading = false;
          products = [];
          CustomSnackBar.show(context, res.settings?.message ?? "");
        }
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
      print('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomApp(title: 'Search', w: w),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: w * 0.9,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
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
                          controller: _searchController,
                          onChanged: (query) {
                            if(query.length>0){
                              setState(() {
                                products = [];
                                isLoading=true;
                              });
                              fetchProductsApi(
                                  query);
                            }
                          },
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
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: "Nunito",
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.03),

            isLoading?
            Center(child: CircularProgressIndicator(
              color: Color(0xffCAA16C),
            )):
            products.length==0?
            Center(
              child: Column(
                children: [
                  SizedBox(height: w*0.5,),
                  Image.asset(
                    alignment: Alignment.center,
                    'assets/no_search.png',
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 30,),
                  Text("Enter text to search the products!",
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
            ):
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final item = products[index];
                    return InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(productid: item.id??"", category_id: ""),));
                      },
                      child: Container(
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
                                    border: Border.all(
                                        color: Color(0xffE7C6A0), width: 1),
                                  ),
                                  child: Center(
                                    child: Image.network(
                                      item.image ?? "",
                                      width: w * 0.2,
                                      height: h * 0.1,
                                      fit: BoxFit.cover,
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
                                    item.title ?? "",
                                    style: TextStyle(
                                        color: Color(0xff181725),
                                        fontFamily: 'RozhaOne',
                                        fontSize: 16,
                                        height: 18 / 16,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 3,
                                  ),
                                  // SizedBox(height: h * 0.008),
                                  // Row(
                                  //   children: List.generate(5, (starIndex) {
                                  //     return Icon(
                                  //       starIndex < item.rating
                                  //           ? Icons.star
                                  //           : Icons.star_border,
                                  //       color: Color(0xffF79009),
                                  //       size: 14,
                                  //     );
                                  //   }),
                                  // ),
                                  SizedBox(height: h * 0.008),
                                  Row(
                                    children: [
                                      Text(
                                        '₹${item.salePrice}',
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
                                        '₹ ${item.mrp}',
                                        style: TextStyle(
                                          color: Color(0xffED1C24),
                                          fontFamily: 'RozhaOne',
                                          fontSize: 12,
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: Color(0xffED1C24),
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
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Product model class
class Product {
  final String id;
  final String title;
  final String image;
  final String category;
  final int mrp;
  final int salePrice;
  final int rating;

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.category,
    required this.mrp,
    required this.salePrice,
    required this.rating,
  });

  // Factory constructor to create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      category: json['category'],
      mrp: json['mrp'],
      salePrice: json['sale_price'],
      rating: json['rating'],
    );
  }
}
