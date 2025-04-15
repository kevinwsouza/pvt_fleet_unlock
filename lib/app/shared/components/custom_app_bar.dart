import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton; 
  final bool showLogoutButton; 
  final VoidCallback? onBackButtonPressed; 

  const CustomAppBar({
    super.key,
    this.showBackButton = false,
    this.showLogoutButton = false,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true, 
      title: Image.asset(
        'assets/frotalog_logo_1.png',
        width: 120, 
        height: 34, 
      ),
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.blue),
              onPressed: onBackButtonPressed ??
                  () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop(); 
                    } else {
                      context.go('/home'); 
                    }
                  },
            )
          : null,
      actions: [
        if (showLogoutButton)
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.blue),
            onPressed: () {
              context.go('/login'); 
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}