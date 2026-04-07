import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';

class TopErrorBanner extends StatelessWidget {
  const TopErrorBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final displayMessage = message == 'home.file_path_unavailable'
        ? message.tr()
        : message;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: const BoxDecoration(
        color: Color(0xFFFEE2E2),
        border: Border(
          bottom: BorderSide(color: Color(0xFFEF4444), width: 0.5),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Color(0xFFEF4444),
              size: 20,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                displayMessage,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFFEF4444),
                  fontWeight: FontWeightHelper.medium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}