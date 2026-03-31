// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_cubit.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_state.dart';
import 'package:sehhalink/core/dependency_Injection/get_it.dart';
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
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CurrentUserCubit>().loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CurrentUserCubit>(),
      child: BlocBuilder<CurrentUserCubit, CurrentUserState>(
        builder: (context, state) {
          // Loading
          if (state.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Error
          if (state.error != null) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    verticalSpace(16),
                    Text(
                      'Error Occurred',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    verticalSpace(8),
                    Text(state.error!),
                    verticalSpace(16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<CurrentUserCubit>().loadUser(),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          final user = state.user;

          if (user == null) {
            return const Scaffold(body: Center(child: Text("No user found")));
          }

        

        

        

          return _MainNavigationContent();
        },
      ),
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

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      const HomeScreen(),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: screens),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primaryBlue,
        selectedItemColor: AppColors.backgroundSoft,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 24.sp),
            activeIcon: Icon(Icons.home, size: 26.sp),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 24.sp),
            activeIcon: Icon(Icons.person, size: 26.sp),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}


