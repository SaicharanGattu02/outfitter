import 'package:flutter/material.dart';

import '../Model/ReviewsModel.dart';
import '../Services/UserApi.dart';
import '../utils/CustomAppBar1.dart';
import '../utils/CustomSnackBar.dart';

class ReviewsListScreen extends StatefulWidget {
  final String productID;
  const ReviewsListScreen({super.key, required this.productID});

  @override
  _ReviewsListScreenState createState() => _ReviewsListScreenState();
}

class _ReviewsListScreenState extends State<ReviewsListScreen> {
  bool isLoading=true;
  @override
  void initState() {
    ReviewsListApi();
    super.initState();
  }
  List<Reviews> reviews=[];
  Future<void> ReviewsListApi() async {
    try {
      final res = await Userapi.fetchReviews(widget.productID);
      if (res != null) {
        setState(() {
          if (res.settings?.success == 1) {
            reviews = res.data ?? [];
            isLoading = false; // Hide loader if error occurs
          } else {
            CustomSnackBar.show(context, res.settings?.message ?? "");
            isLoading = false;
          }
        });
      }
    } catch (e) {
      CustomSnackBar.show(context, "Failed to load orders.");
    } finally {

    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF4F5FA),
      appBar: CustomApp(title: 'Reviews List', w: w),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: reviews.isNotEmpty
            ? ListView.builder(
          itemCount: reviews.length,
          scrollDirection: Axis.vertical, // Vertical scrolling (this is actually the default)
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var data = reviews[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4.0, // Add shadow/elevation to the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                child: Container(
                  padding: EdgeInsets.all(12), // Padding inside the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${data.customer ?? ''}",
                              style: TextStyle(
                                color: Color(0xff121926),
                                fontFamily: 'RozhaOne',
                                fontSize: 14,
                                height: 19.36 / 14,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1, // Allow the text to span multiple lines
                              overflow: TextOverflow.ellipsis, // Ellipsis for overflow text
                              softWrap: true, // Ensure text wraps to the next line
                            ),
                          ),
                          SizedBox(height: 5), // Space between customer and date
                          Text(
                            "Posted on: ${data.createdAt ?? ''}",
                            style: TextStyle(
                              color: Color(0xff617C9D),
                              fontFamily: 'RozhaOne',
                              fontSize: 12,
                              height: 19.36 / 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      if (data.rating != 0.0) ...[
                        Row(
                          children: List.generate(5, (starIndex) {
                            int ratingValue = int.tryParse(data.rating.toString() ?? "") ?? 0;
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
                      SizedBox(height: 5),
                      Text("${data.reviewText ?? ''}kbm lkg kg lkgnlokgjlkg lkgjre glkrgjreg lkrgnerolgknv ljnfa kjabgf kjbfg kjwefbrfgjbk ",
                        style: TextStyle(
                          color: Color(0xff121926),
                          fontFamily: 'RozhaOne',
                          fontSize: 14,
                          height: 19.36 / 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
            : Center(
          child: Text(
            'No reviews available.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

}