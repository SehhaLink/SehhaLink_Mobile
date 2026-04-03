// forget_password_header_icon.dart
// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/theme/app_colors.dart';

class ForgetPasswordHeaderIcon extends StatelessWidget {
  const ForgetPasswordHeaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryBlue.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Icon(
            Icons.lock_reset_rounded,
            size: 50.sp,
            color: AppColors.primaryBlue,
          ),
        ),
        Positioned(
          top: 0,
          right: -4.w,
          child: Container(
            width: 28.w,
            height: 28.h,
            decoration: const BoxDecoration(
              color: AppColors.primaryBlue,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.email_rounded, size: 14.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }
}