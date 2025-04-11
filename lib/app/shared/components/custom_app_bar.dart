import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton; // Controla o botão de voltar
  final bool showLogoutButton; // Controla o botão de logout
  final VoidCallback? onBackButtonPressed; // Callback para o botão de voltar

  const CustomAppBar({
    super.key,
    this.showBackButton = false,
    this.showLogoutButton = false,
    this.onBackButtonPressed, // Adiciona o callback para o botão de voltar
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true, // Centraliza o conteúdo do título
      title: Image.asset(
        'assets/frotalog_logo_1.png',
        width: 120, // Caminho do logo
        height: 34, // Altura do logo
      ),
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.blue),
              onPressed: onBackButtonPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      actions: [
        if (showLogoutButton)
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.blue),
            onPressed: () {
              context.go('/login'); // Navega para a tela de login
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}