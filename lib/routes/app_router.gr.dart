// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    WorkSpaceRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WorkSpaceView(),
      );
    },
    SelectBackgroundRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SelectBackgroundView(),
      );
    },
    CreateBoardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateBoardView(),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInView(),
      );
    },
    SignUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpView(),
      );
    },
    CardRouteList.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CardViewList(),
      );
    },
  };
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WorkSpaceView]
class WorkSpaceRoute extends PageRouteInfo<void> {
  const WorkSpaceRoute({List<PageRouteInfo>? children})
      : super(
          WorkSpaceRoute.name,
          initialChildren: children,
        );

  static const String name = 'WorkSpaceRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SelectBackgroundView]
class SelectBackgroundRoute extends PageRouteInfo<void> {
  const SelectBackgroundRoute({List<PageRouteInfo>? children})
      : super(
          SelectBackgroundRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectBackgroundRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateBoardView]
class CreateBoardRoute extends PageRouteInfo<void> {
  const CreateBoardRoute({List<PageRouteInfo>? children})
      : super(
          CreateBoardRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateBoardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInView]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpView]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CardViewList]
class CardRouteList extends PageRouteInfo<void> {
  const CardRouteList({List<PageRouteInfo>? children})
      : super(
          CardRouteList.name,
          initialChildren: children,
        );

  static const String name = 'CardRouteList';

  static const PageInfo<void> page = PageInfo<void>(name);
}
