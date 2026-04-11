import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
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

  void _showComingSoonOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) =>
          _NotificationComingSoonToast(onDismiss: () => entry.remove()),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 3), () {
      if (entry.mounted) entry.remove();
    });
  }

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
            child: profileImagePath != null && profileImagePath!.isNotEmpty
                ? (profileImagePath!.startsWith('http')
                      ? Image.network(
                          profileImagePath!,
                          key: ValueKey(profileImagePath),
                          width: 50.w,
                          height: 50.h,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Image.asset(
                            Assets.assetsImagesUser,
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.file(
                          File(profileImagePath!),
                          key: ValueKey(profileImagePath),
                          width: 50.w,
                          height: 50.h,
                          fit: BoxFit.cover,
                        ))
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
          onTap: () => _showComingSoonOverlay(context),
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
                        notificationCount > 9 ? '9+' : '$notificationCount',
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
    if (hour >= 5 && hour < 12) return 'greeting.morning'.tr();
    if (hour >= 12 && hour < 17) return 'greeting.afternoon'.tr();
    if (hour >= 17 && hour < 21) return 'greeting.evening'.tr();
    return 'greeting.night'.tr();
  }
}

class _NotificationComingSoonToast extends StatefulWidget {
  const _NotificationComingSoonToast({required this.onDismiss});
  final VoidCallback onDismiss;

  @override
  State<_NotificationComingSoonToast> createState() =>
      _NotificationComingSoonToastState();
}

class _NotificationComingSoonToastState
    extends State<_NotificationComingSoonToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) _controller.reverse().then((_) => widget.onDismiss());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80.h,
      right: 16.w,
      left: 16.w,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _opacity,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: AppColors.primaryBlue.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F4F8),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: AppColors.primaryBlue,
                      size: 20.sp,
                    ),
                  ),
                  horizontalSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'notifications.coming_soon_title'.tr(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeightHelper.semiBold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        verticalSpace(3),
                        Text(
                          'notifications.coming_soon_sub'.tr(),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  horizontalSpace(8),
                  GestureDetector(
                    onTap: widget.onDismiss,
                    child: Icon(
                      Icons.close_rounded,
                      size: 16.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
