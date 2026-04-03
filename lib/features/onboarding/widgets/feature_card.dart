import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.backgroundSoft,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: iconColor, size: 18.sp),
          ),
          verticalSpace(10),
          Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: AppColors.textPrimary,
            ),
          ),
          verticalSpace(4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeightHelper.regular,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
