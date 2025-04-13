import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frotalog_gestor_v2/app/features/home/presenter/bloc/home_screen_controller.dart';
import 'package:frotalog_gestor_v2/app/features/home/presenter/pages/home_screen_page.dart';
import 'package:frotalog_gestor_v2/app/features/login/presenter/bloc/login_controller.dart';
import 'package:frotalog_gestor_v2/app/features/login/presenter/pages/login_screen.dart';
import 'package:frotalog_gestor_v2/app/features/vehicles_list/presenter/pages/vehicles_list_screen.dart';
import 'package:go_router/go_router.dart';

import '../../../splash_screen.dart';
import '../../features/vehicles_list/presenter/bloc/vehicles_list_controller.dart';
import '../mocks/vehicle_model.dart';
import '../mocks/vehicle_service.dart';

class RoutesApp {
  static const login = '/login';
  static const home = '/home';
  static const vehicleList = '/veihicleList';

  static RoutesApp? _instance;

  static RoutesApp getInstance() {
    return _instance ??= RoutesApp();
  }

  final routes = [
    GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
              child: const SplashScreen(),
            )),
    GoRoute(
        path: login,
        pageBuilder: (context, state) => MaterialPage(
              child: BlocProvider(
                create: (_) => LoginController(),
                child: const LoginPage(),
              ),
            )),
    GoRoute(
      path: home,
      pageBuilder: (context, state) => MaterialPage(
          child: BlocProvider(
        create: (_) => HomeScreenController(VehicleService()),
        child: const HomeScreenPage(),
      )),
    ),
    // TO DO - AJUSTAR A ROTA PARA VEHICLE LIST
    GoRoute(
  path: vehicleList,
  pageBuilder: (context, state) {
    final vehicles = state.extra as List<VehicleModel>?; // Recebe os veículos
    return MaterialPage(
      child: BlocProvider(
        create: (_) => VehiclesListController(),
        child: VehiclesListPage(vehicles: vehicles ?? []),
      ),
    );
  },
),
  ];
}
