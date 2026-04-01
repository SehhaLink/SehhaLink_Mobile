import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_cubit.dart';
import 'package:sehhalink/core/routing/routes.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/core/theme/font_weight_helper.dart';
import 'package:sehhalink/core/helpers/spacing.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key, required this.drawerController});

  final AdvancedDrawerController drawerController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'settings.title'.tr(),
              style: TextStyle(
                color: AppColors.textWhite,
                fontSize: 22.sp,
                fontWeight: FontWeightHelper.bold,
              ),
            ),
            verticalSpace(8),
            Divider(color: AppColors.textWhite.withOpacity(0.2)),
            verticalSpace(16),

            _DrawerItem(
              icon: Icons.security_rounded,
              label: 'settings.privacy_security'.tr(),
              onTap: () {
                drawerController.hideDrawer();
              },
            ),

            verticalSpace(12),

            
            _DrawerItem(
              icon: Icons.language_rounded,
              label: 'settings.language'.tr(),
              onTap: () => _showLanguageDialog(context),
            ),

            const Spacer(),

            Divider(color: AppColors.textWhite.withOpacity(0.2)),
            verticalSpace(12),

            // Logout
            _DrawerItem(
              icon: Icons.logout_rounded,
              label: 'profile.logout'.tr(),
              color: Colors.redAccent.shade100,
              onTap: () {
                drawerController.hideDrawer();
                _showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.backgroundMain,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'settings.language'.tr(),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeightHelper.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LanguageTile(
              flag: '🇺🇸',
              label: 'settings.language_english'.tr(),
              locale: const Locale('en'),
            ),
            verticalSpace(8),
            _LanguageTile(
              flag: '🇪🇬',
              label: 'settings.language_arabic'.tr(),
              locale: const Locale('ar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'profile.logout'.tr(),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeightHelper.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          'profile.logout_confirm'.tr(),
          style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'profile.cancel'.tr(),
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await context.read<CurrentUserCubit>().logout();
              Navigator.pushNamedAndRemoveUntil(
                // ignore: use_build_context_synchronously
                context,
                Routes.onboardingScreen,
                (_) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'profile.logout'.tr(),
              style: const TextStyle(color: AppColors.textWhite),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final itemColor = color ?? AppColors.textWhite;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        child: Row(
          children: [
            Icon(icon, color: itemColor, size: 22.sp),
            horizontalSpace(16),
            Text(
              label,
              style: TextStyle(
                color: itemColor,
                fontSize: 15.sp,
                fontWeight: FontWeightHelper.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.flag,
    required this.label,
    required this.locale,
  });

  final String flag;
  final String label;
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final isSelected = context.locale == locale;
    return InkWell(
      onTap: () {
        context.setLocale(locale);
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryBlue.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.borderLight,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 20.sp)),
            horizontalSpace(12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected
                    ? FontWeightHelper.semiBold
                    : FontWeightHelper.regular,
                color: isSelected
                    ? AppColors.primaryBlue
                    : AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.primaryBlue,
                size: 18.sp,
              ),
          ],
        ),
      ),
    );
  }
}
