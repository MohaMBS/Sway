// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../screens/dashboard.dart' as _i2;
import '../screens/login.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    Login.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.Login());
    },
    DashboardV.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.DashboardV());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(Login.name, path: '/'),
        _i3.RouteConfig(DashboardV.name, path: '/dashboard-v')
      ];
}

/// generated route for
/// [_i1.Login]
class Login extends _i3.PageRouteInfo<void> {
  const Login() : super(Login.name, path: '/');

  static const String name = 'Login';
}

/// generated route for
/// [_i2.DashboardV]
class DashboardV extends _i3.PageRouteInfo<void> {
  const DashboardV() : super(DashboardV.name, path: '/dashboard-v');

  static const String name = 'DashboardV';
}
