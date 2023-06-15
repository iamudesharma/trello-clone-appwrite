import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'routes/app_router.dart';

Client client = Client();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(
      desktop: 800,
      tablet: 550,
      watch: 200,
    ),
  );

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;

  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final _appRouter = ref.watch(appRouterProvider);
    return ResponsiveApp(builder: (context) {
      return MaterialApp.router(
        builder: EasyLoading.init(),
        routerConfig: _appRouter.config(),
        theme: ThemeData(
          primaryColor: Color(0xff007AC0),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xff007AC0), brightness: Brightness.dark),
        ),
      );
    });
  }
}
