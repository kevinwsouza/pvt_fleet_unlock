import 'package:flutter/material.dart';

import '../../../../shared/components/custom_app_bar.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage>
    with SingleTickerProviderStateMixin {
  bool isBluetoothLoading = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Duração da pulsação
    )..repeat(reverse: true); // Repetição da animação
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void handleBluetoothAction() async {
    setState(() {
      isBluetoothLoading = true; // Inicia o carregamento e muda o texto para "Pareando veículos"
    });

    // Simula uma ação de requisição ou conexão Bluetooth
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      isBluetoothLoading = false; // Finaliza o carregamento e volta o texto para "Conexão Bluetooth"
    });

    // Exemplo: Mostra um snackbar após a ação
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ação Bluetooth concluída!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: false, // Não exibe o botão de voltar
        showLogoutButton: true, // Exibe o botão de logout
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animação de borda pulsante
            if (isBluetoothLoading)
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Container(
                    width: 250 + (_animationController.value * 120), // Largura pulsante aumentada
                    height: 250 + (_animationController.value * 120), // Altura pulsante aumentada
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withAlpha(100), // Cor da pulsação
                    ),
                  );
                },
              ),
            // Botão principal
            GestureDetector(
              onTap: isBluetoothLoading ? null : handleBluetoothAction,
              child: Container(
                width: 250, // Largura maior do botão
                height: 250, // Altura maior do botão
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.bluetooth, // Ícone de Bluetooth
                      color: Colors.white,
                      size: 60, // Tamanho do ícone
                    ),
                    const SizedBox(height: 8), // Espaçamento entre o ícone e o texto
                    Text(
                      isBluetoothLoading ? "Pareando veículos" : "Conexão Bluetooth",
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
  }
}