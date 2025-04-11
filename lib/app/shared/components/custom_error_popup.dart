import 'package:flutter/material.dart';

class CustomErrorPopup extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final VoidCallback onPressed;
  final double? width; // Largura opcional
  final double? height; // Altura opcional

  const CustomErrorPopup({
    super.key,
    required this.title,
    required this.content,
    required this.buttonText,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: width ?? MediaQuery.of(context).size.width * 0.8, // Largura padrão: 80% da tela
        height: height, // Altura opcional
        child: Text(content),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(buttonText),
        ),
      ],
    );
  }
}