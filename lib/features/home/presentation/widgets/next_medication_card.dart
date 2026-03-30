import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';

class NextMedicationCard extends StatelessWidget {
  const NextMedicationCard({
    super.key,
    required this.medicationName,
    required this.time,
    required this.note,
    this.onMarkAsTaken,
  });

  final String medicationName;
  final String time;
  final String note;
  final VoidCallback? onMarkAsTaken;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Next Medication",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white70,
                  fontWeight: FontWeightHelper.regular,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeightHelper.semiBold,
                  ),
                ),
              ),
            ],
          ),

          verticalSpace(8),

          // Medication Name
          Text(
            medicationName,
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeightHelper.bold,
            ),
          ),

          verticalSpace(10),

          // Note
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.accentOrange,
                size: 16.sp,
              ),
              horizontalSpace(6),
              Expanded(
                child: Text(
                  note,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white70,
                    fontWeight: FontWeightHelper.regular,
                  ),
                ),
              ),
            ],
          ),

          verticalSpace(16),

          // Button
          GestureDetector(
            onTap: onMarkAsTaken,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF4A84A),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                  horizontalSpace(8),
                  Text(
                    "Mark as Taken",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeightHelper.semiBold,
                    ),
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
