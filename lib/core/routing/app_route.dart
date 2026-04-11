import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_logic/current_user_cubit.dart';
import 'package:sehhalink/core/current_user/presentation/logic/file_logic/files_cubit.dart';
import 'package:sehhalink/core/dependency_Injection/auth_di.dart';
import 'package:sehhalink/core/dependency_Injection/current_user_di.dart';
import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/core/dependency_Injection/home_screen_di.dart';
import 'package:sehhalink/core/dependency_Injection/privacy_security_di.dart';
import 'package:sehhalink/core/routing/routes.dart';
import 'package:sehhalink/features/auth/presentation/logic/auth_cubit.dart';
import 'package:sehhalink/features/auth/presentation/views/forget_password_screen.dart';
import 'package:sehhalink/features/auth/presentation/views/login_screen.dart';
import 'package:sehhalink/features/auth/presentation/views/register_screen.dart';
import 'package:sehhalink/features/home/presentation/home_screen.dart';
import 'package:sehhalink/features/navigation_screen/presentation/main_navigation_screen.dart';
import 'package:sehhalink/features/onboarding/onboarding_screen.dart';
import 'package:sehhalink/features/privacy_and_security/presentation/logic/privacy_and_security_cubit.dart';
import 'package:sehhalink/features/privacy_and_security/presentation/privacy_and_security.dart';
import 'package:sehhalink/features/view_details/presentation/view_details_screen.dart';

class AppRoute {
  Route generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case Routes.onboardingScreen:
        page = const OnboardingScreen();
        break;

      case Routes.registerScreen:
        authDi();
        page = BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: const RegisterScreen(),
        );
        break;

      case Routes.loginScreen:
        authDi();
        page = BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: const LoginScreen(),
        );
        break;

      case Routes.forgetPasswordScreen:
        authDi();
        page = BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: const ForgetPasswordScreen(),
        );
        break;

      case Routes.homeScreen:
        homeScreenDi();
        page = const HomeScreen();
        break;

      case Routes.navigationScreen:
        currentUserDi();
        page = BlocProvider(
          create: (_) => getIt<CurrentUserCubit>()..loadUser(),
          child: BlocProvider.value(
            value: getIt<FilesCubit>(),
            child: const MainNavigationScreen(),
          ),
        );

      case Routes.viewDetailsScreen:
        page = const ViewDetailsScreen();
        break;

      case Routes.privacySecurity:
        privacySecurityDi();
        page = BlocProvider(
          create: (context) => getIt<PrivacySecurityCubit>(),
          child: PrivacySecurityScreen(),
        );
        break;

      default:
        page = Scaffold(
          body: Center(child: Text('navigation.route_not_found'.tr())),
        );
    }

    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.05, 0),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }
}
