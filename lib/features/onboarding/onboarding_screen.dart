// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/extensions.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/routing/routes.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/core/utils/app_assets.dart';
import 'package:sehhalink/core/widgets/app_button.dart';
import 'package:sehhalink/features/onboarding/widgets/feature_card.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundMain,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
              ),
              padding: EdgeInsets.fromLTRB(28.w, 40.h, 28.w, 48.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'SehhaLink',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeightHelper.medium,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.25),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        Assets.assetsImagesSehhaLinkLogo,
                        width: 48.w,
                        height: 48.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  verticalSpace(20),
                  Text(
                    'Your health,\nall in one place',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeightHelper.bold,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                  verticalSpace(8),
                  Text(
                    'Manage your family\'s healthcare\nsmarter and simpler',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white.withOpacity(0.65),
                      fontWeight: FontWeightHelper.regular,
                    ),
                  ),
                ],
              ),
            ),

            verticalSpace(20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  verticalSpace(24),

                  Row(
                    children: [
                      Expanded(
                        child: FeatureCard(
                          icon: Icons.folder_copy_rounded,
                          iconColor: AppColors.primaryBlue,
                          iconBg: const Color(0xFFE8F4F8),
                          title: 'All in one place',
                          subtitle:
                              'All your medical reports & scans in one spot',
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: FeatureCard(
                          icon: Icons.insights_rounded,
                          iconColor: AppColors.accentOrange,
                          iconBg: const Color(0xFFFEF3E8),
                          title: 'Easy summary',
                          subtitle:
                              'Understand your health with simple insights',
                        ),
                      ),
                    ],
                  ),

                  verticalSpace(35),

                  AppButton(
                    buttonHeight: 54.h,
                    onPressed: () => context.pushNamed(Routes.registerScreen),
                    backgroundColor: AppColors.primaryBlue,
                    radius: 14.r,
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 15.sp,
                        fontWeight: FontWeightHelper.semiBold,
                      ),
                    ),
                  ),

                  verticalSpace(12),

                  AppButton(
                    buttonHeight: 54.h,
                    onPressed: () => context.pushNamed(Routes.loginScreen),
                    backgroundColor: AppColors.backgroundMain,
                    radius: 14.r,
                    borderSide: BorderSide(
                      color: AppColors.primaryBlue,
                      width: 1.5,
                    ),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: 15.sp,
                        fontWeight: FontWeightHelper.medium,
                      ),
                    ),
                  ),

                  verticalSpace(20),

                  Text(
                    'Privacy  •  Terms',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.textLight,
                      fontWeight: FontWeightHelper.regular,
                    ),
                  ),

                  verticalSpace(16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
