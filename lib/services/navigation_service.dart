

import 'package:analogy_flutter/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../routes/router.dart';

class NavigationService {
  final AppRouter _router;

  NavigationService(this._router);

  // Get the navigator key for MaterialApp
  GlobalKey<NavigatorState> get navigatorKey => _router.navigatorKey;

  // Push a new page onto the stack
  Future<T?> push<T extends Object?>(PageRouteInfo routeInfo) {
    return _router.push(routeInfo);
  }

  // Replace current page with new page
  Future<T?> replace<T extends Object?>(PageRouteInfo routeInfo) {
    return _router.replace(routeInfo);
  }

  // Push and remove all previous pages
  Future<T?> pushAndPopAll<T extends Object?>(PageRouteInfo routeInfo) {
    return _router.pushAndPopUntil(
      routeInfo,
      predicate: (_) => false,
    );
  }

  // Pop the current page
  void pop<T extends Object?>([T? result]) {
    _router.pop(result);
  }

  // Navigate to home screen
  Future<void> navigateToHome() {
    return pushAndPopAll(const CreateRoute());
  }

  // Navigate to profile screen
  Future<void> navigateToProfile() {
    return push(YouRoute());
  }

  // Navigate to settings screen
  Future<void> navigateToSettings() {
    return push(SavedRoute());
  }

  // Check current route
  String? getCurrentRoute() {
    return _router.currentPath;
  }

  // Custom navigation with arguments
  Future<void> navigateToProfileWithArgs(int userId) {
    return push(ExploreRoute());
  }
}