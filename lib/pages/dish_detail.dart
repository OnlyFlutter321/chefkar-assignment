import 'package:chefkart/constants/app_colors.dart';
import 'package:chefkart/models/dish_detail.dart';
import 'package:chefkart/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DishDetailPage extends StatefulWidget {
  const DishDetailPage({super.key, required this.id});

  final int id;

  @override
  State<DishDetailPage> createState() => _DishDetailPageState();
}

class _DishDetailPageState extends State<DishDetailPage> {
  late final DishDetail _dishDetail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _dishDetail = await ApiService.instance.getDish(id: widget.id);
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.blackColor),
            )
          : SizedBox.expand(
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 60.h,
                    child: Image.asset(
                      "assets/images/veg1.jpg",
                      width: 0.7.sw,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _dishDetail.name,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 182.w,
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac euismod quam. Duis vulputate lorem id ultrices mattis. Mauris a tincidunt nisl.",
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: const Color(0xFFA3A3A3),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            const Icon(Icons.watch_later_outlined),
                            SizedBox(width: 8.w),
                            Text(
                              _dishDetail.timeToPrepare,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          "Ingredients",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "For 2 people",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF8A8A8A),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        const Divider(),
                        SizedBox(height: 16.h),
                        Text(
                          "Vegetables (${_dishDetail.ingredients.vegetables.length})"
                              .padLeft(1, '0'),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount:
                                _dishDetail.ingredients.vegetables.length,
                            itemBuilder: (context, index) {
                              final vegtable =
                                  _dishDetail.ingredients.vegetables[index];
                              return ListTile(
                                title: Text(
                                  vegtable.name,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                trailing: Text(vegtable.quantity),
                              );
                            },
                          ),
                        ),
                        Text(
                          "Spices (${_dishDetail.ingredients.spices.length})"
                              .padLeft(1, '0'),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount:
                                _dishDetail.ingredients.vegetables.length,
                            itemBuilder: (context, index) {
                              final vegtable =
                                  _dishDetail.ingredients.vegetables[index];
                              return ListTile(
                                title: Text(
                                  vegtable.name,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                trailing: Text(vegtable.quantity),
                              );
                            },
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
