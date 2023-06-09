import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trello_clone_appwrite/auth/repo/auth_repo.dart';
import '../auth/view/sign_in.dart';
import '../auth/view/sign_up.dart';
import '../cards/card_view.dart';
import '../home/views/create_borad_view.dart';
import '../home/views/home_view.dart';
import '../home/views/select_backgrand_view.dart';
import '../home/views/work_space_view.dart';
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
        ),
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
          guards: [
            AuthGuard(ref),
          ],
        ),
        AutoRoute(
          page: CreateBoardRoute.page,
          type: const RouteType.adaptive(),
          path: "/create-board",
        ),
        AutoRoute(
          page: SelectBackgroundRoute.page,
          type: const RouteType.adaptive(),
          path: "/select-backgrand",
        ),
        AutoRoute(
          page: WorkSpaceRoute.page,
          type: const RouteType.adaptive(),
          path: "/work-space",
        ),
        AutoRoute(
          page: CardRouteList.page,
          type: const RouteType.adaptive(),
          path: "/card-view",
        ),


      ];
}

class AuthGuard extends AutoRouteGuard {
  final Ref ref;

  AuthGuard(this.ref);
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    try {
      final data = await ref.read(AuthRepo.provider).currentUser();

      if (data != null) {
        resolver.next(true);
      } else {
        resolver.redirect(const SignInRoute());
      }
    } catch (e) {
      resolver.redirect(const SignInRoute());
    }
  }
}
