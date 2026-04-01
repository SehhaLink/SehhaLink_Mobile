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
            'Personal Information',
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
            label: 'Full Name',
            value: user.fullName,
          ),
          SizedBox(height: 10.h),

          ProfileInfoTile(
            icon: Icons.email_rounded,
            label: 'Email',
            value: user.email,
          ),
          SizedBox(height: 10.h),

          ProfileInfoTile(
            icon: Icons.phone_rounded,
            label: 'Phone',
            value: user.phoneNumber,
          ),
          SizedBox(height: 10.h),

          ProfileInfoTile(
            icon: Icons.cake_rounded,
            label: 'Birth Date',
            value: user.birthDate,
          ),
          SizedBox(height: 10.h),

          ProfileInfoTile(
            icon: Icons.wc_rounded,
            label: 'Gender',
            value: user.gender,
          ),
          SizedBox(height: 10.h),

          ProfileInfoTile(
            icon: Icons.calendar_today_rounded,
            label: 'Age',
            value: '${user.age} years',
          ),
          SizedBox(height: 10.h),

          ProfileInfoTile(
            icon: Icons.badge_rounded,
            label: 'Role',
            value: user.role,
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}