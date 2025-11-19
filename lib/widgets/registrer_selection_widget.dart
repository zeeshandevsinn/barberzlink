import 'dart:developer';

import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterSelection extends StatelessWidget {
  const RegisterSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: Injections.instance.registrationOptions.map((option) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          width: double.infinity,
          height: 280.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            image: DecorationImage(
              image: AssetImage(option['image']!),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.45),
                BlendMode.darken,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  option['title']!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  option['subtitle']!,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: InkWell(
                        onTap: () {
                          log("Register for ${option['title']}");
                          AppRoutes.goTo(context, option['route']!);
                        },
                        child: Text(
                          'REGISTER TODAY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 160,
                      height: 60,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),

                      child: CustomButton(
                        buttonText: 'SEARCH',
                        fontSize: 14,
                        onTap: () {
                          log("Learn more about ${option['title']}");
                          AppRoutes.goTo(context, option['route_search']!);
                        },
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     log("Search for ${option['title']}");
                      //     AppRoutes.goTo(context, option['route_search']!);
                      //   },
                      //   child: Center(
                      //     child: Text(
                      //       'SEARCH',
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 13.sp,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
