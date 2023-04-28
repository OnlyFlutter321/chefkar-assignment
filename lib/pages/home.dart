import 'package:chefkart/constants/app_colors.dart';
import 'package:chefkart/models/dish.dart';
import 'package:chefkart/models/popular_dish.dart';
import 'package:chefkart/pages/dish_detail.dart';
import 'package:chefkart/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  List<String> areas = [];
  List<Dish> dishes = [];
  List<PopularDish> popularDishes = [];
  String selectedArea = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      areas = await ApiService.instance.getAreas();
      final dishesAndPouplarDishes = await ApiService.instance.getDishes();
      setState(() {
        dishes = dishesAndPouplarDishes.item1;
        popularDishes = dishesAndPouplarDishes.item2;
        selectedArea = areas.first;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 16.r,
        ),
        titleSpacing: 0,
        title: Text(
          "Select Dishes",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
      ),
      body: Visibility(
        visible: !_isLoading,
        replacement: const Center(
          child: CircularProgressIndicator(color: AppColors.blackColor),
        ),
        child: Stack(
          children: [
            Container(
              height: 42.h,
              decoration: const BoxDecoration(
                color: AppColors.blackColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 22.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 22.w),
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.boxShadowColor,
                          offset: Offset(0, 1.h),
                          blurRadius: 4.r,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Image.asset(
                          "assets/icons/date.png",
                          height: 18.h,
                          width: 18.h,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "21 May 2021",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        VerticalDivider(
                          indent: 22.h,
                          endIndent: 15.h,
                        ),
                        const Spacer(),
                        Image.asset(
                          "assets/icons/time.png",
                          height: 18.h,
                          width: 18.h,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "10:30 Pm-12:30 Pm",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 24.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: areas.length,
                      itemBuilder: (context, index) {
                        final area = areas[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 16.w : 0,
                            right: index == areas.length - 1 ? 16.w : 0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() => selectedArea = area);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 18.w),
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: BoxDecoration(
                                color: selectedArea == area
                                    ? const Color(0xFFFFF9F2)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: selectedArea == area
                                      ? const Color(0xFFFF941A)
                                      : const Color(0xFFBDBDBD),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  area,
                                  style: TextStyle(
                                    color: selectedArea == area
                                        ? const Color(0xFFFF941A)
                                        : const Color(0xFFBDBDBD),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Text(
                      "Popular Dishs",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 62.r,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popularDishes.length,
                      itemBuilder: (context, index) {
                        final popularDish = popularDishes[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 16.w : 0,
                            right: index == areas.length - 1 ? 16.w : 0,
                          ),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    DishDetailPage(id: popularDish.id),
                              ),
                            ),
                            child: Container(
                              height: 62.r,
                              width: 62.r,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFFF941A),
                                  width: 1.r,
                                ),
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(2.r),
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(popularDish.image),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.4),
                                      BlendMode.luminosity,
                                    ),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    popularDish.name,
                                    style: TextStyle(
                                      color: AppColors.textColorAccent,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    color: const Color(0xFFF2F2F2),
                    height: 32.h,
                    thickness: 3.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Row(
                      children: [
                        Text(
                          "Recomended",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        const Icon(Icons.arrow_drop_down),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            fixedSize: Size.fromHeight(18.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.r)),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Menu",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.0.w),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          color: Color(0xFFF2F2F2),
                        ),
                        itemCount: dishes.length,
                        itemBuilder: (context, index) {
                          final dish = dishes[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            dish.name,
                                            style: TextStyle(
                                              color: AppColors.textColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Icon(
                                            Icons.adjust_rounded,
                                            size: 12.r,
                                            color: Colors.green,
                                          ),
                                          SizedBox(width: 8.w),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w, vertical: 2.h),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    dish.rating.toString(),
                                                    style: TextStyle(
                                                      fontSize: 8.sp,
                                                      color: AppColors
                                                          .textColorAccent,
                                                    ),
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  Icon(
                                                    Icons.star_rounded,
                                                    size: 8.r,
                                                    color: AppColors.whiteColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 4.h),
                                      Row(
                                        children: [
                                          Row(
                                            children: List.generate(
                                              dish.equipments.length,
                                              (index) => Padding(
                                                padding: EdgeInsets.only(
                                                    right: 8.0.w),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      dish.equipments[index] ==
                                                              "Refrigerator"
                                                          ? Icons
                                                              .kitchen_rounded
                                                          : Icons
                                                              .microwave_rounded,
                                                    ),
                                                    Text(
                                                      dish.equipments[index],
                                                      style: TextStyle(
                                                        fontSize: 6.sp,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 20.h,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 12.w,
                                            ),
                                            child: const VerticalDivider(
                                              width: 2,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    DishDetailPage(id: dish.id),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Ingredients",
                                                  style: TextStyle(
                                                    fontSize: 8.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "View List",
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xFFFF8800),
                                                      ),
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    const Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      size: 10,
                                                      color: Color(0xFFFF8800),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        dish.description,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.network(
                                    dish.image,
                                    height: 68.h,
                                    width: 92.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
