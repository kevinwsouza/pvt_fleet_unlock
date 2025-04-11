import 'package:flutter/material.dart';

class CustomLoadingOverlay extends StatelessWidget {
  final Color backgroundColor;
  final Color progressIndicatorColor;

  const CustomLoadingOverlay({
    super.key,
    this.backgroundColor = const Color(0x80000000), // Preto semi-transparente
    this.progressIndicatorColor = Colors.blue, // Cor padrão do indicador
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: CircularProgressIndicator(
          color: progressIndicatorColor,
        ),
      ),
    );
  }
}