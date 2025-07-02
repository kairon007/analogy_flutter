import 'package:analogy_flutter/routes/router.gr.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: CreateRoute.page,initial: true),
    AutoRoute(page: ExploreRoute.page),
    AutoRoute(page: SavedRoute.page),
    AutoRoute(page: YouRoute.page),
  ];

  @override
  final List<AutoRouteGuard> guards = [];
}
