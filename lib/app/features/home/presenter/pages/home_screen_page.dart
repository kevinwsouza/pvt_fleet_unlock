import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frotalog_gestor_v2/app/features/home/presenter/bloc/home_screen_state.dart';
import 'package:frotalog_gestor_v2/app/shared/mocks/vehicle_service.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/components/custom_app_bar.dart';
import '../../../../shared/routes/routes_app.dart';
import '../bloc/home_screen_controller.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage>
    with SingleTickerProviderStateMixin {
  bool isBluetoothLoading = false;
  late AnimationController _animationController;
  late HomeScreenController _controller;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Duração da pulsação
    );
    _controller = HomeScreenController(VehicleService());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void handleBluetoothAction() {
    setState(() {
      isBluetoothLoading = true; // Inicia o carregamento
      _animationController.repeat(reverse: true); // Inicia a animação
    });

    _controller.fetchVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenController, HomeScreenState>(
      bloc: _controller,
      builder: (context, state) {
        if (state is HomeScreenInitialState) {}

        if (state is HomeScreenLoading) {
          isBluetoothLoading = true;
          _animationController.repeat(reverse: true);
        } else {
          isBluetoothLoading = false;
          _animationController.stop();
        }

        if (state is HomeScreenSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(
              RoutesApp.vehicleList,
              extra: state.vehicles, // Passa os veículos para a próxima tela
            );
          });
        }

        if (state is HomeScreenErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          });
        }

        return Scaffold(
          appBar: const CustomAppBar(
            showBackButton: false,
            showLogoutButton: true,
          ),
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isBluetoothLoading)
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Container(
                        width: 250 + (_animationController.value * 120),
                        height: 250 + (_animationController.value * 120),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.withAlpha(100),
                        ),
                      );
                    },
                  ),
                GestureDetector(
                  onTap: isBluetoothLoading ? null : handleBluetoothAction,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.bluetooth,
                          color: Colors.white,
                          size: 60,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isBluetoothLoading
                              ? "Pareando veículos"
                              : "Conexão Bluetooth",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
