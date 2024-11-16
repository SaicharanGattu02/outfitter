import 'package:flutter/material.dart';
import 'package:outfitter/Services/UserApi.dart';
import '../Model/OrderDetailsModel.dart';
import '../utils/CustomAppBar1.dart';

class OrderDetailScreen extends StatefulWidget {
  String id;
  OrderDetailScreen({super.key, required this.id});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getOrderDetails();
  }

  OrderDetails? orderDetail;
  Future<void> getOrderDetails() async {
    var res = await Userapi.getOrderDetails(widget.id);
    if (res != null) {
      setState(() {
        if (res.settings?.status == 1) {
          orderDetail = res.orderDetail;  // Handle null here, no need to force unwrap
        }
        isLoading = false;  // Data has been fetched
      });
    } else {
      setState(() {
        isLoading = false;  // Data fetching failed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomApp(title: 'Order Details', w: w),
      body: isLoading
          ? Center(child: CircularProgressIndicator())  // Show a loading spinner while data is being fetched
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: w * 0.7,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
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
                              color: Color(0xff9E7BCA),
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
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "assets/filter.png",
                      width: 22,
                      height: 22,
                      color: Color(0xffCAA16C),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Filters",
                    style: TextStyle(
                      color: Color(0xffCAA16C),
                      fontFamily: 'RozhaOne',
                      fontSize: 16,
                      height: 19 / 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Order ID: 0D117216332413925000",
                    style: TextStyle(
                      color: Color(0xff181725),
                      fontFamily: 'RozhaOne',
                      fontSize: 16,
                      height: 19 / 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "21-11-2024",
                    style: TextStyle(
                      color: Color(0xff617C9D),
                      fontFamily: 'RozhaOne',
                      fontSize: 14,
                      height: 19 / 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: orderDetail?.items?.length ?? 0,  // Handle null safely
                itemBuilder: (context, index) {
                  final item = orderDetail?.items?[index];
                  return Container(
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
                                border: Border.all(color: Color(0xffE7C6A0), width: 1),
                              ),
                              child: Center(
                                child: Image.asset(
                                  item?.product?.image ?? "",
                                  width: w * 0.2,
                                  height: h * 0.1,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 3,
                              right: 3,
                              child: Image.asset(
                                'assets/favLove.png',
                                width: 10,
                                height: 10,
                                fit: BoxFit.contain,
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
                                item?.product?.title ?? "",  // Use default if null
                                style: TextStyle(
                                  color: Color(0xff181725),
                                  fontFamily: 'RozhaOne',
                                  fontSize: 16,
                                  height: 18 / 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: h * 0.008),
                              Row(
                                children: List.generate(5, (starIndex) {
                                  int rating = 0;
                                  if (item?.product?.rating != null) {
                                    rating = int.tryParse(item?.product?.rating??0.toString()) ?? 0;
                                  }
                                  return Icon(
                                    starIndex < rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Color(0xffF79009),
                                    size: 14,
                                  );
                                }),
                              ),
                              SizedBox(height: h * 0.008),
                              Row(
                                children: [
                                  Text(
                                    item?.product?.salePrice.toString() ?? "",  // Use default if null
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
                                    "M.R.P",
                                    style: TextStyle(
                                      color: Color(0xffCAA16C),
                                      fontFamily: 'RozhaOne',
                                      fontSize: 12,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Color(0xffED1C24),
                                      height: 18 / 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: w * 0.004),
                                  Text(
                                    item?.product?.mrp.toString() ?? "",  // Use default if null
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
