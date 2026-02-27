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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Column(
            children: [
              verticalSpace(20),
              ClipRRect(
                child: Image.asset(
                  Assets.assetsImagesSehhaLinkLogo,
                  height: 250.h,
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(flex: 1),

              // ── Content Section ──
              _buildFeatureRow(
                icon: Icons.calendar_month_rounded,
                color: AppColors.iconBlue,
                text: "Track appointments & medications",
              ),
              verticalSpace(16),
              _buildFeatureRow(
                icon: Icons.family_restroom_rounded,
                color: const Color(0xFF8B5CF6),
                text: "Manage your whole family's health",
              ),
              verticalSpace(16),
              _buildFeatureRow(
                icon: Icons.smart_toy_rounded,
                color: const Color(0xFF10B981),
                text: "AI assistant for health guidance",
              ),

              const Spacer(flex: 2),

              // ── Title ──
              Text(
                "Your Family's Health,\nAll in One Place",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 22.sp,
                  fontWeight: FontWeightHelper.bold,
                  height: 1.4,
                ),
              ),
              verticalSpace(32),

              AppButton(
                buttonHeight: 56.h,
                onPressed: () {
                  context.pushNamed(Routes.registerScreen);
                },
                backgroundColor: AppColors.primaryBlue,
                radius: 16.r,
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16.sp,
                    fontWeight: FontWeightHelper.semiBold,
                  ),
                ),
              ),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontWeight: FontWeightHelper.regular,
                      fontSize: 14.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(Routes.loginScreen);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.semiBold,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(8),
              Text(
                'Privacy   •   Terms',
                style: TextStyle(
                  fontWeight: FontWeightHelper.regular,
                  fontSize: 13.sp,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              verticalSpace(8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: color, size: 20.sp),
        ),
        SizedBox(width: 14.w),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.regular,
          ),
        ),
      ],
    );
  }
}
