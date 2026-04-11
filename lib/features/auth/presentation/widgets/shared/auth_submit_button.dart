import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/core/widgets/app_button.dart';

class AuthSubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final String label;
  final IconData icon;

  const AuthSubmitButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      buttonHeight: 56.h,
      onPressed: isLoading ? null : onPressed,
      backgroundColor: AppColors.primaryBlue,
      radius: 16.r,
      child: isLoading
          ? SizedBox(
              height: 20.h,
              width: 20.w,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16.sp,
                    fontWeight: FontWeightHelper.semiBold,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(icon, color: Colors.white, size: 20.sp),
              ],
            ),
    );
  }
}