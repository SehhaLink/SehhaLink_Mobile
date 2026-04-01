import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/current_user/domain/entity/user.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/features/profile/presentation/widgets/profile_info_tile.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.h),

          Text(
            'profile.personal_information'.tr(),
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: 0.2,
            ),
          ),

          SizedBox(height: 14.h),

          ProfileInfoTile(
            icon: Icons.person_rounded,
            label: 'profile.full_name'.tr(),
            value: user.fullName,
          ),
          SizedBox(height: 10.h),

          ProfileInfoTile(
            icon: Icons.email_rounded,
            label: 'profile.email'.tr(),
            value: user.email,
          ),
          SizedBox(height: 10.h),

          ProfileInfoTile(
            icon: Icons.phone_rounded,
            label: 'profile.phone'.tr(),
            value: user.phoneNumber,
          ),
          SizedBox(height: 10.h),

          ProfileInfoTile(
            icon: Icons.cake_rounded,
            label: 'profile.birth_date'.tr(),
            value: user.birthDate,
          ),
          SizedBox(height: 10.h),

          ProfileInfoTile(
            icon: Icons.wc_rounded,
            label: 'profile.gender'.tr(),
            value: user.gender,
          ),
          SizedBox(height: 10.h),

          ProfileInfoTile(
            icon: Icons.calendar_today_rounded,
            label: 'profile.age'.tr(),
            value: '${user.age} years',
          ),
          SizedBox(height: 10.h),

          ProfileInfoTile(
            icon: Icons.badge_rounded,
            label: 'profile.role'.tr(),
            value: user.role,
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}