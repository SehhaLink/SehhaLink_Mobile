import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_logic/current_user_cubit.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_logic/current_user_state.dart';
import 'package:sehhalink/core/routing/routes.dart';
import 'package:sehhalink/core/theme/app_colors.dart';
import 'package:sehhalink/features/profile/presentation/widgets/profile_drawer.dart';
import 'package:sehhalink/features/profile/presentation/widgets/profile_top_section.dart';
import 'package:sehhalink/features/profile/presentation/widgets/profile_body.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _drawerController = AdvancedDrawerController();

  @override
  void dispose() {
    _drawerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentUserCubit, CurrentUserState>(
      listener: (context, state) {
        if (state.user == null && !state.isLoading) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.onboardingScreen,
            (_) => false,
          );
          return;
        }
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<CurrentUserCubit, CurrentUserState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              backgroundColor: AppColors.backgroundMain,
              body: Center(
                child: CircularProgressIndicator(color: AppColors.primaryBlue),
              ),
            );
          }

          final user = state.user;
          if (user == null) {
            return Scaffold(
              backgroundColor: AppColors.backgroundMain,
              body: Center(child: Text('profile.no_user_data'.tr())),
            );
          }

          return AdvancedDrawer(
            controller: _drawerController,
            backdropColor: AppColors.primaryBlue,
            rtlOpening: false,
            openRatio: 0.75,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            drawer: ProfileDrawer(drawerController: _drawerController),
            child: Scaffold(
              backgroundColor: AppColors.backgroundSoft,
              body: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: ProfileTopSection(
                      user: user,
                      drawerController: _drawerController,
                    ),
                  ),
                  SliverToBoxAdapter(child: ProfileBody(user: user)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}