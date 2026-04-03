import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sehhalink/core/dependency_Injection/current_user_di.dart';
import 'package:sehhalink/core/dependency_Injection/get_it.dart';
import 'package:sehhalink/core/routing/app_route.dart';
import 'package:sehhalink/core/routing/routes.dart';
import 'package:sehhalink/core/service/isar_service.dart';
import 'package:sehhalink/core/service/secure_storage_service.dart';
import 'package:sehhalink/sehha_link.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await IsarService.instance;
  await _initializeApp();
  final initialRoute = await _determineInitialRoute();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: SehhaLink(appRouter: AppRoute(), initialRoute: initialRoute),
    ),
  );
}

Future<String> _determineInitialRoute() async {
  final hasToken = await SecureStorageService.hasValidToken();
  if (hasToken) {
    return Routes.navigationScreen;
  }
  return Routes.onboardingScreen;
}

Future<void> _initializeApp() async {
  setupDi();
  currentUserDi();
}
