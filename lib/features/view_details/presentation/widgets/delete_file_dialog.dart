// widgets/delete_file_dialog.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';

class DeleteFileDialog extends StatelessWidget {
  final String fileName;
  const DeleteFileDialog({super.key, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundMain,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Row(
        children: [
          Icon(
            Icons.delete_outline_rounded,
            color: Colors.redAccent,
            size: 22.sp,
          ),
          horizontalSpace(8),
          Text(
            'view_details.delete_title'.tr(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      content: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
          children: [
            TextSpan(text: 'view_details.delete_confirm'.tr()),
            TextSpan(
              text: '"$fileName"',
              style: TextStyle(
                fontWeight: FontWeightHelper.semiBold,
                color: AppColors.textPrimary,
              ),
            ),
            TextSpan(text: 'view_details.delete_suffix'.tr()),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            'view_details.cancel'.tr(),
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13.sp,
              fontWeight: FontWeightHelper.medium,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: AppColors.textWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          ),
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            'view_details.delete'.tr(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeightHelper.semiBold,
            ),
          ),
        ),
      ],
    );
  }
}
