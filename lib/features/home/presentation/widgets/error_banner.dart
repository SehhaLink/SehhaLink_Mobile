
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';

class ErrorBanner extends StatelessWidget {
  const ErrorBanner({required this.message,super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    final displayMessage = message == 'home.file_path_unavailable'
        ? message.tr()
        : message;
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFEF4444).withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Color(0xFFEF4444),
            size: 18,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              displayMessage,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFFEF4444),
                fontWeight: FontWeightHelper.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}