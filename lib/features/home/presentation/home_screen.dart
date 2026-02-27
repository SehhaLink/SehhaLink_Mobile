// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:sehhalink/features/home/presentation/widgets/next_medication_card.dart';
import 'package:sehhalink/features/home/presentation/widgets/quick_action_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(name: "John Doe"),
      backgroundColor: AppColors.backgroundMain,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeightHelper.medium,
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
                children: [
                  const TextSpan(text: "Everything you need to\nmanage your "),
                  TextSpan(
                    text: "family's health,",
                    style: TextStyle(color: AppColors.primaryBlue),
                  ),
                  const TextSpan(text: "\nall in one place."),
                ],
              ),
            ),

            verticalSpace(20.h),

            NextMedicationCard(
              medicationName: "Aspirin (81mg)",
              time: "8:00 AM",
              note: "Take with a full glass of water after breakfast.",
              onMarkAsTaken: () {},
            ),

            verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Family Members",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeightHelper.semiBold,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeightHelper.medium,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: AppColors.backgroundCard,
                      child: Icon(
                        Icons.person,
                        color: AppColors.textWhite,
                        size: 24,
                      ),
                    ),
                    verticalSpace(8),
                    Text(
                      "John Doe",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeightHelper.medium,
                      ),
                    ),
                  ],
                ),
                horizontalSpace(16),
                // Add Button
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryBlue,
                            width: 1.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          color: AppColors.primaryBlue,
                          size: 24.sp,
                        ),
                      ),
                    ),
                    verticalSpace(8),
                    Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeightHelper.medium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            verticalSpace(12),
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: AppColors.textPrimary,
              ),
            ),
            Row(
              children: [
                QuickActionCard(
                  icon: Icons.smart_toy_outlined,
                  title: "Ask AI Bot",
                  subtitle: "Check symptoms",
                  iconBackgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                  iconColor: AppColors.primaryBlue,
                  onTap: () {},
                ),
                horizontalSpace(12),
                QuickActionCard(
                  icon: Icons.cloud_upload_outlined,
                  title: "Upload Report",
                  subtitle: "Analyze results",
                  iconBackgroundColor: const Color(0xFFFFF0E6),
                  iconColor: AppColors.accentOrange,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
