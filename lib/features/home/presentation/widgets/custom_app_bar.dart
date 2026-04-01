import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/core/utils/app_assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.name,
    this.notificationCount = 0,
    this.onNotificationTap,
    this.profileImagePath,
  });

  final String name;
  final int notificationCount;
  final VoidCallback? onNotificationTap;
  final String? profileImagePath;

  @override
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 70.h,
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: profileImagePath != null
                ? Image.file(
                    File(profileImagePath!),
                    key: ValueKey(profileImagePath), // ✅ يمنع الكاش
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    Assets.assetsImagesUser,
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                  ),
          ),
          horizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getGreeting(),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeightHelper.regular,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeightHelper.semiBold,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: onNotificationTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.notifications,
                size: 28.sp,
                color: AppColors.textSecondary,
              ),
              if (notificationCount > 0)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 16.w,
                    height: 16.h,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        notificationCount > 9
                            ? '9+'
                            : '$notificationCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9.sp,
                          fontWeight: FontWeightHelper.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        horizontalSpace(16),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return 'Good Morning 🌅';
    if (hour >= 12 && hour < 17) return 'Good Afternoon ☀️';
    if (hour >= 17 && hour < 21) return 'Good Evening 🌆';
    return 'Good Night 🌙';
  }
}