import 'package:flutter/material.dart';

import 'app/shared/routes/router_register.dart';


class FrotaUnlockerApp extends StatelessWidget {
  const FrotaUnlockerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routerInstance = RouterRegister.getInstance().router;

    return MaterialApp.router(
      title: 'Flutter Bloc',
      routerConfig: routerInstance,
      debugShowCheckedModeBanner: false,
    );
  }
}