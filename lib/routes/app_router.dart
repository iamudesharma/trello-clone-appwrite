import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trello_clone_appwrite/auth/controller/auth_controller.dart';
import '../auth/view/sign_in.dart';
import '../auth/view/sign_up.dart';
import '../home/views/home_view.dart';

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
            path: "/sign-in",
            type: const RouteType.adaptive(),
            guards: [
              AuthGuard(ref),
            ]),
        AutoRoute(
          page: SignUpRoute.page,
          type: const RouteType.adaptive(),
          path: "/sign-up",
        ),
        AutoRoute(
          page: HomeRoute.page,
          type: const RouteType.adaptive(),
          path: "/",
          initial: true,
        ),
      ];
}

class AuthGuard extends AutoRouteGuard {
  final Ref ref;

  AuthGuard(this.ref);
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (ref.read(authControllerProvider).value != null) {
      resolver.next(true);
    } else {
      resolver.redirect(const SignInRoute());
    }
  }
}
