import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/core/dependency_Injection/login_screen_di.dart';
import 'package:sehhalink/core/dependency_Injection/register_screen_di.dart';
import 'package:sehhalink/core/routing/routes.dart';
import 'package:sehhalink/features/auth/login/presentation/logic/login_cubit.dart';
import 'package:sehhalink/features/auth/login/presentation/login_screen.dart';
import 'package:sehhalink/features/auth/register/presentation/logic/register_cubit.dart';
import 'package:sehhalink/features/auth/register/presentation/register_screen.dart';
import 'package:sehhalink/features/onboarding/onboarding_screen.dart';

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
      case Routes.loginScreen:
        loginScreenDi();
        page = BlocProvider(
          create: (_) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        );
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
