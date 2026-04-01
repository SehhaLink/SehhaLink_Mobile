import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/features/profile/presentation/widgets/profile_image_section.dart';

class ProfileTopSection extends StatelessWidget {
  const ProfileTopSection({
    super.key,
    required this.user,
    required this.drawerController,
  });

  final User user;
  final AdvancedDrawerController drawerController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 32.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                  IconButton(
                    icon: ValueListenableBuilder(
                      valueListenable: drawerController,
                      builder: (_, value, __) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Icon(
                            value.visible
                                ? Icons.close_rounded
                                : Icons.menu_rounded,
                            key: ValueKey(value.visible),
                            color: AppColors.textWhite,
                            size: 26.sp,
                          ),
                        );
                      },
                    ),
                    onPressed: drawerController.toggleDrawer,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              const ProfileImageSection(),
              SizedBox(height: 14.h),
              Text(
                user.fullName,
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                user.email,
                style: TextStyle(
                  color: AppColors.textWhite.withOpacity(0.75),
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.textWhite.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  user.role,
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}