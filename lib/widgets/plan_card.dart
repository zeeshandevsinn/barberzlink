import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final List<String> features;
  final String price;
  final String? priceSubtext;
  final bool isPopular;
  final bool isSelected;
  final VoidCallback onTap;

  const PlanCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.features,
    required this.price,
    this.priceSubtext,
    required this.isPopular,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? AppColors.black
                : isPopular
                    ? Colors.amber.shade400
                    : Colors.grey.shade300,
            width: isSelected ? 2.5 : isPopular ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.black.withOpacity(0.15)
                  : Colors.black.withOpacity(0.08),
              blurRadius: isSelected ? 12 : 8,
              offset: Offset(0, isSelected ? 6 : 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Popular Badge
                if (isPopular)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber.shade700,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'MOST POPULAR',
                          style: AppTextStyle.semiBold(
                            fontSize: 12.sp,
                            color: Colors.amber.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),

                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title & Subtitle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: AppTextStyle.bold(
                                    fontSize: 20.sp,
                                    color: AppColors.black,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  subtitle,
                                  style: AppTextStyle.medium(
                                    fontSize: 14.sp,
                                    color: AppColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Selection Indicator
                          if (isSelected)
                            Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: AppColors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16.sp,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      // Description
                      Text(
                        description,
                        style: AppTextStyle.regular(
                          fontSize: 14.sp,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Features
                      ...features.map((feature) => Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.black,
                                  size: 18.sp,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: AppTextStyle.regular(
                                      fontSize: 13.sp,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(height: 20.h),

                      // Price Section
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  price,
                                  style: AppTextStyle.bold(
                                    fontSize: 24.sp,
                                    color: AppColors.black,
                                  ),
                                ),
                                if (priceSubtext != null) ...[
                                  SizedBox(height: 4.h),
                                  Text(
                                    priceSubtext!,
                                    style: AppTextStyle.regular(
                                      fontSize: 12.sp,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.black,
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

