import 'package:flutter/material.dart';
import 'package:frotalog_gestor_v2/app/shared/routes/routes_app.dart';

import 'package:go_router/go_router.dart';

class RouterRegister {
  static RouterRegister? _instance;
  static GlobalKey<NavigatorState> globalContext = GlobalKey<NavigatorState>();

  static RouterRegister getInstance() {
    return _instance ??= RouterRegister();
  }

  final RouterConfig<Object> router = GoRouter(
    navigatorKey: globalContext,
    initialLocation: '/',
    routes: <ShellRoute>[
      ShellRoute(
        builder: (context, state, child) => child,
        routes: [
          ...RoutesApp.getInstance().routes,
        ],
      )
    ],
  );
}
