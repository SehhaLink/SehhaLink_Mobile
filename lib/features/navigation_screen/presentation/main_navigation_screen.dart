import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_logic/current_user_cubit.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_logic/current_user_state.dart';
import 'package:sehhalink/core/helpers/spacing.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/features/home/presentation/home_screen.dart';
import 'package:sehhalink/features/profile/presentation/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primaryBlue),
            ),
          );
        }

        if (state.error != null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  verticalSpace(16),
                  Text(
                    'navigation.error_occurred'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  verticalSpace(8),
                  Text(state.error!),
                  verticalSpace(16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<CurrentUserCubit>().loadUser(),
                    child: Text('navigation.try_again'.tr()),
                  ),
                ],
              ),
            ),
          );
        }

        if (state.user == null) {
          return Scaffold(
            body: Center(child: Text('navigation.no_user_found'.tr())),
          );
        }

        return const _MainNavigationContent();
      },
    );
  }
}

class _MainNavigationContent extends StatefulWidget {
  const _MainNavigationContent();

  @override
  State<_MainNavigationContent> createState() => _MainNavigationContentState();
}

class _MainNavigationContentState extends State<_MainNavigationContent> {
  int _currentIndex = 0;

  final _screens = const <Widget>[HomeScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundMain,
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: _buildNavBar(),
      ),
    );
  }

  Widget _buildNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            selectedItemColor: AppColors.backgroundMain, //
            unselectedItemColor: AppColors.backgroundMain.withOpacity(0.5),
            itemPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            items: [
              SalomonBottomBarItem(
                icon: Icon(Icons.home_outlined, size: 24.sp),
                activeIcon: Icon(Icons.home_rounded, size: 24.sp),
                title: Text(
                  'navigation.home'.tr(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                selectedColor: AppColors.backgroundMain,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.person_outline_rounded, size: 24.sp),
                activeIcon: Icon(Icons.person_rounded, size: 24.sp),
                title: Text(
                  'navigation.profile'.tr(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                selectedColor: AppColors.backgroundMain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
