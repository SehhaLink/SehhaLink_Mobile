import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/core/current_user/presentation/logic/current_user_cubit.dart';
import 'package:sehhalink/core/dependency_Injection/forget_password_screen_di.dart';
import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/core/dependency_Injection/home_screen_di.dart';
import 'package:sehhalink/core/dependency_Injection/login_screen_di.dart';
import 'package:sehhalink/core/dependency_Injection/register_screen_di.dart';
import 'package:sehhalink/core/routing/routes.dart';
import 'package:sehhalink/features/auth/forget_password/presentation/forget_password_screen.dart';
import 'package:sehhalink/features/auth/forget_password/presentation/logic/forget_password_cubit.dart';
import 'package:sehhalink/features/auth/login/presentation/logic/login_cubit.dart';
import 'package:sehhalink/features/auth/login/presentation/login_screen.dart';
import 'package:sehhalink/features/auth/register/presentation/logic/register_cubit.dart';
import 'package:sehhalink/features/auth/register/presentation/register_screen.dart';
import 'package:sehhalink/features/home/presentation/home_screen.dart';
import 'package:sehhalink/features/navigation_screen/presentation/main_navigation_screen.dart';
import 'package:sehhalink/features/onboarding/onboarding_screen.dart';
import 'package:sehhalink/features/view_details/presentation/view_details_screen.dart';

class AppRoute {
  Route generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case Routes.onboardingScreen:
        page = const OnboardingScreen();
        break;

      case Routes.registerScreen:
        registerScreenDi();
        page = BlocProvider(
          create: (_) => getIt<RegisterCubit>(),
          child: const RegisterScreen(),
        );
        break;
      case Routes.homeScreen:
        homeScreenDi();
        page = const HomeScreen();
        break;
      case Routes.loginScreen:
        loginScreenDi();
        page = BlocProvider(
          create: (_) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        );
        break;
      case Routes.forgetPasswordScreen:
        forgetPasswordScreenDi();
        page = BlocProvider(
          create: (_) => getIt<ForgetPasswordCubit>(),
          child: const ForgetPasswordScreen(),
        );
        break;

      case Routes.navigationScreen:
        page = BlocProvider(
          create: (_) => getIt<CurrentUserCubit>()..loadUser(),
          child: const MainNavigationScreen(),
        );
        break;

      case Routes.viewDetailsScreen:
        page = const ViewDetailsScreen();
        break;
      default:
        page = const Scaffold(body: Center(child: Text('Route not found')));
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
