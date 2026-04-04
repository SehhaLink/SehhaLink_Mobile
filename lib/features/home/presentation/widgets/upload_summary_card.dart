// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';

class UploadSummaryCard extends StatelessWidget {
  const UploadSummaryCard({
    super.key,
    this.totalReports = 0,
    this.lastUpload = '',
    this.onViewDetails,
  });

  final int totalReports;
  final String lastUpload;
  final VoidCallback? onViewDetails;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == ui.TextDirection.rtl;

    final reportsItem = _StatItem(
      icon: Icons.description_outlined,
      label: 'home.upload_summary_reports'.tr(),
      value: '$totalReports',
    );

    final lastUploadItem = _StatItem(
      icon: Icons.schedule_outlined,
      label: 'home.upload_summary_last_data_upload'.tr(),
      value: lastUpload,
    );

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'home.upload_summary'.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeightHelper.semiBold,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 6.sp,
                      color: const Color(0xFF4ADE80),
                    ),
                    horizontalSpace(4),
                    Text(
                      'home.active'.tr(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white,
                        fontWeight: FontWeightHelper.medium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          verticalSpace(16),

          Row(
            children: isRtl
                ? [lastUploadItem, _Divider(), reportsItem]
                : [reportsItem, _Divider(), lastUploadItem],
          ),

          verticalSpace(16),

          GestureDetector(
            onTap: onViewDetails,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.white.withOpacity(0.25)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'home.upload_summary_view_details'.tr(),
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeightHelper.semiBold,
                      color: Colors.white,
                    ),
                  ),
                  horizontalSpace(6),
                  Icon(
                    isRtl
                        ? Icons.arrow_back_rounded
                        : Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.75), size: 18.sp),
          verticalSpace(6),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.bold,
              color: Colors.white,
            ),
          ),
          verticalSpace(2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.white.withOpacity(0.65),
              fontWeight: FontWeightHelper.regular,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40.h,
      color: Colors.white.withOpacity(0.2),
    );
  }
}
