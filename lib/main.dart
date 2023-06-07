import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:trello_clone_appwrite/auth/view/sign_up.dart';
import 'package:trello_clone_appwrite/config/appwrite_config.dart';
import 'package:velocity_x/velocity_x.dart';

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
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.amber, brightness: Brightness.dark),
        ),
      );
    });
  }
}
