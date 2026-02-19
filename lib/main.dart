import 'package:flutter/material.dart';
import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/core/routing/app_route.dart';
import 'package:sehhalink/core/routing/routes.dart';
import 'package:sehhalink/sehha_link.dart';

void main() async {
  final initialRoute = await _determineInitialRoute();
  await _initializeApp();

  runApp(SehhaLink(appRouter: AppRoute(), initialRoute: initialRoute));
}

Future<String> _determineInitialRoute() async {
  return Routes.onboardingScreen;
}

Future<void> _initializeApp() async {
  setupDi();
}
