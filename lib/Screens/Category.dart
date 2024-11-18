import 'package:flutter/material.dart';
import 'package:outfitter/utils/CustomAppBar.dart';
import 'package:outfitter/utils/CustomAppBar1.dart';
import 'package:provider/provider.dart';

import '../Model/CategoriesModel.dart';
import '../Services/UserApi.dart';
import '../providers/CategoriesProvider.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  @override
  void initState() {
    // GetCategoriesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar2(title: 'Category', w: w),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              'assets/category_banner.png',
              fit: BoxFit.contain,
            ),
            SizedBox(height: h * 0.02),
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
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.51,
                ),
                itemCount: categories_list.length,
                itemBuilder: (context, index) {
                  final data = categories_list[index];
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff110B0F),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Image.network(
                            data.image ?? '',
                            // Default to an empty string if image is null
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          data.categoryName ?? '',
                          // Default to an empty string if image is null
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
              );
            }),
          ],
        ),
      ),
    );
  }
}
