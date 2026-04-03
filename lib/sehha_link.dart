import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehhalink/core/routing/app_route.dart';

class SehhaLink extends StatelessWidget {
  const SehhaLink({
    super.key,
    required this.appRouter,
    required this.initialRoute,
  });
  final AppRoute appRouter;
  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute: initialRoute,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
