import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';

class DropZone extends StatelessWidget {
  const DropZone({
    required this.isDragging,
    required this.onDragEnter,
    required this.onDragExit,
    required this.onTap,
    super.key,
  });

  final bool isDragging;
  final VoidCallback onDragEnter;
  final VoidCallback onDragExit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 32.h),
        decoration: BoxDecoration(
          color: isDragging
              ? const Color(0xFFE8F4F8)
              : AppColors.backgroundSoft,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isDragging ? AppColors.primaryBlue : AppColors.borderLight,
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: isDragging
                    ? AppColors.primaryBlue.withOpacity(0.12)
                    : const Color(0xFFE8F4F8),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cloud_upload_outlined,
                size: 32.sp,
                color: AppColors.primaryBlue,
              ),
            ),
            verticalSpace(16),
            Text(
              'Tap to upload or drag & drop',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: AppColors.textPrimary,
              ),
            ),
            verticalSpace(6),
            Text(
              'PDF, JPG, PNG, DICOM up to 50 MB',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeightHelper.regular,
                color: AppColors.textSecondary,
              ),
            ),
            verticalSpace(16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'Browse Files',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeightHelper.semiBold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}