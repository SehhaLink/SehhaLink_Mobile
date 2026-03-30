// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';

class CaregiverCheckbox extends StatelessWidget {
  final bool isCaregiver;
  final VoidCallback onTap;

  const CaregiverCheckbox({
    super.key,
    required this.isCaregiver,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: isCaregiver
                    ? AppColors.primaryBlue
                    : AppColors.borderLight, // ✅
                width: 1.5,
              ),
              color: isCaregiver
                  ? AppColors.primaryBlue.withOpacity(0.1)
                  : Colors.transparent,
            ),
            child: isCaregiver
                ? Icon(Icons.check, color: AppColors.primaryBlue, size: 14)
                : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "I am a caregiver/parent",
                  style: TextStyle(
                    color: AppColors.textPrimary, // ✅
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.semiBold,
                  ),
                ),
                verticalSpace(4),
                Text(
                  "Check this to enable family profile management and health tracking for others.",
                  style: TextStyle(
                    color: AppColors.textSecondary, // ✅
                    fontSize: 12.sp,
                    fontWeight: FontWeightHelper.regular,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}