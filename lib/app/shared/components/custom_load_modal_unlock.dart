import 'package:flutter/material.dart';

class CustomLoadModalUnlock extends StatelessWidget {
  final String message;

  const CustomLoadModalUnlock({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ajusta o tamanho da modal ao conteúdo
          children: [
            const CircularProgressIndicator(
              color: Colors.blue, // Cor do indicador de progresso
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}