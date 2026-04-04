
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/features/home/domain/entities/upload_file_item.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.status,super.key});
  final UploadStatus status;

  @override
  Widget build(BuildContext context) {
    late Color bg;
    late Color fg;
    late String label;

    switch (status) {
      case UploadStatus.done:
        bg = const Color(0xFFDCFCE7);
        fg = AppColors.successGreen;
        label = 'home.status_done'.tr();
        break;
      case UploadStatus.failed:
        bg = const Color(0xFFFEE2E2);
        fg = const Color(0xFFEF4444);
        label = 'home.status_failed'.tr();
        break;
      case UploadStatus.uploading:
        bg = const Color(0xFFE8F4F8);
        fg = AppColors.primaryBlue;
        label = 'home.status_uploading'.tr();
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeightHelper.semiBold,
          color: fg,
        ),
      ),
    );
  }
}