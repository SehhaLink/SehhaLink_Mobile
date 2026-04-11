import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color linkTextColor;
  final Color backButtonBgColor;

  const AuthAppBar({
    super.key,
    this.linkTextColor = AppColors.textPrimary,
    this.backButtonBgColor = AppColors.backgroundSoft,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundMain,
      elevation: 0,
      centerTitle: true,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Sehha",
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontSize: 18.sp,
                fontWeight: FontWeightHelper.bold,
              ),
            ),
            TextSpan(
              text: "Link",
              style: TextStyle(
                color: linkTextColor,
                fontSize: 18.sp,
                fontWeight: FontWeightHelper.bold,
              ),
            ),
          ],
        ),
      ),
      leading: Container(
        margin: EdgeInsets.only(left: 16.w),
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: backButtonBgColor,
          borderRadius: BorderRadius.circular(36.r),
        ),
        child: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryBlue,
            size: 18,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}