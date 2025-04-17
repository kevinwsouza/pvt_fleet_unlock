import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:app_settings/app_settings.dart';
import 'package:frotalog_gestor_v2/app/features/home/presenter/bloc/home_screen_state.dart';
import 'package:frotalog_gestor_v2/app/shared/mocks/vehicle_service.dart';
import 'package:go_router/go_router.dart';

import '../components/custom_active_bluetooth_popup.dart';
import '../../../../shared/components/custom_app_bar.dart';
import '../../../../shared/routes/routes_app.dart';
import '../bloc/home_screen_controller.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  bool isBluetoothLoading = false;
  late AnimationController _animationController;
  late HomeScreenController _controller;
  bool isPopupOpen = false; // Tracks the state of the popup

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addObserver(this); // Adiciona o observador do ciclo de vida
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Duração da pulsação
    );
    _controller = HomeScreenController(VehicleService());
  }

  @override
  void dispose() {
    WidgetsBinding.instance
        .removeObserver(this); // Remove o observador do ciclo de vida
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // Verifica o estado do Bluetooth quando o app retorna ao primeiro plano
      final isBluetoothEnabled =
          await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;

      if (!mounted) return; // Verifica se o widget ainda está montado

      if (isBluetoothEnabled) {
        // Se o Bluetooth estiver ativado, feche a popup se ela estiver aberta
        if (isPopupOpen) {
          Navigator.of(context, rootNavigator: true).pop(); // Fecha a popup
          isPopupOpen = false; // Atualiza o estado da popup
        }

        // Exibe uma mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bluetooth ativado!')),
        );
      } else {
        // Se o Bluetooth ainda estiver desativado, exiba a popup novamente
        if (!isPopupOpen) {
          isPopupOpen = true; // Atualiza o estado da popup
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomActiveBluetoothPopup(
              content: 'Bluetooth ainda está desativado. Por favor, ative-o.',
              onPressed: () {
                AppSettings.openAppSettings(type: AppSettingsType.bluetooth);
              },
            ),
          );
        }
      }
    }
  }

  void handleBluetoothAction() {
    setState(() {
      isBluetoothLoading = true; // Inicia o carregamento
      _animationController.repeat(reverse: true); // Inicia a animação
    });

    _controller
        .checkBluetoothAndFetchVehicles(); // Chama o método da Controller
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenController, HomeScreenState>(
      bloc: _controller,
      builder: (context, state) {
        // Controle da animação baseado no estado
        if (state is HomeScreenLoading) {
          if (!_animationController.isAnimating) {
            _animationController.repeat(reverse: true); // Inicia a animação
          }
        } else {
          if (_animationController.isAnimating) {
            _animationController.stop(); // Para a animação
          }
        }

        if (state is HomeScreenSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              context.go(
                RoutesApp.vehicleList,
                extra: state.vehicles, // Passa os veículos para a próxima tela
              );
            }
          });
        }

        if (state is HomeScreenErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              if (state.errorMessage.contains('Bluetooth')) {
                // Exibe a Popup para erros relacionados ao Bluetooth
                if (!isPopupOpen) {
                  isPopupOpen = true; // Atualiza o estado da popup
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => CustomActiveBluetoothPopup(
                      content: state.errorMessage, // Mensagem de erro
                      onPressed: () {
                        AppSettings.openAppSettings(
                            type: AppSettingsType.bluetooth);
                      },
                    ),
                  );
                }
              } else {
                // Exibe uma SnackBar para erros genéricos
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            }
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
                if (state is HomeScreenLoading)
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
                  onTap:
                      state is HomeScreenLoading ? null : handleBluetoothAction,
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
                          state is HomeScreenLoading
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
