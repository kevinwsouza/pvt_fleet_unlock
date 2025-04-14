import 'package:flutter/material.dart';

class CustomActiveBluetoothPopup extends StatelessWidget {
  final String content;
  final VoidCallback onPressed;
  final double? width; // Largura opcional
  final double? height; // Altura opcional

  const CustomActiveBluetoothPopup({
    super.key,
    required this.content,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: width ?? MediaQuery.of(context).size.width * 0.8, // Largura padrão: 80% da tela
        height: height, // Altura opcional
        child: Text(content),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text('ativar'),
        ),
      ],
    );
  }
}