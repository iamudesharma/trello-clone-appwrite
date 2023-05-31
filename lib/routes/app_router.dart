import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../auth/view/sign_in.dart';
import '../auth/view/sign_up.dart';

part 'app_router.gr.dart';
part 'app_router.g.dart';

@Riverpod()
AppRouter appRouter(AppRouterRef ref) => AppRouter(ref);

@AutoRouterConfig(replaceInRouteName: 'View,Route', modules: [])
class AppRouter extends _$AppRouter {
  final Ref ref;

  AppRouter(this.ref);
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: SignInRoute.page,
            initial: true,
            path: "/sign-in",
            type: const RouteType.adaptive()),
        AutoRoute(
          page: SignUpRoute.page,
          type: const RouteType.adaptive(),
          path: "/sign-up",
        ),
      ];
}
