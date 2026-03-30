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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SehhaLink',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeightHelper.medium,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'v2.0',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white.withOpacity(0.5),
                          ),
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

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  verticalSpace(24),

                  _FeatureCard(
                    icon: Icons.calendar_month_rounded,
                    iconColor: AppColors.primaryBlue,
                    iconBg: const Color(0xFFE8F4F8),
                    title: 'Appointments',
                    subtitle: 'Track & manage medications',
                  ),
                  verticalSpace(12),
                  _FeatureCard(
                    icon: Icons.family_restroom_rounded,
                    iconColor: AppColors.accentOrange,
                    iconBg: const Color(0xFFFEF3E8),
                    title: 'Family profiles',
                    subtitle: 'Everyone\'s health in one view',
                  ),
                  verticalSpace(12),
                  _FeatureCard(
                    icon: Icons.smart_toy_rounded,
                    iconColor: AppColors.successGreen,
                    iconBg: const Color(0xFFEAFAF0),
                    title: 'AI assistant',
                    subtitle: 'Smart guidance for your health',
                  ),

                  verticalSpace(28),

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

// ─── Feature Card ─────────────────────────────────────────────────────────────

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundSoft,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(width: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeightHelper.semiBold,
                  color: AppColors.textPrimary,
                ),
              ),
              verticalSpace(2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeightHelper.regular,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
