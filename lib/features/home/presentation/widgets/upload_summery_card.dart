// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';

class UploadSummaryCard extends StatelessWidget {
  const UploadSummaryCard({
    super.key,
    this.totalReports = 12,
    this.lastUpload = 'Today',
    this.storageUsed = '48 MB',
    this.onViewDetails,
  });

  final int totalReports;
  final String lastUpload;
  final String storageUsed;
  final VoidCallback? onViewDetails;

  @override
  Widget build(BuildContext context) {
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
          // ── Header ──────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upload Summary',
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
                      'Active',
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

          // ── Stats Row ────────────────────────────────────
          Row(
            children: [
              _StatItem(
                icon: Icons.description_outlined,
                label: 'Reports',
                value: '$totalReports',
              ),
              _Divider(),
              _StatItem(
                icon: Icons.schedule_outlined,
                label: 'Last Upload',
                value: lastUpload,
              ),
            ],
          ),

          verticalSpace(16),

          // ── View Details Button ───────────────────────────
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
                    'View Details',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeightHelper.semiBold,
                      color: Colors.white,
                    ),
                  ),
                  horizontalSpace(6),
                  Icon(
                    Icons.arrow_forward_rounded,
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

// ─── Stat Item ────────────────────────────────────────────────────────────────

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
