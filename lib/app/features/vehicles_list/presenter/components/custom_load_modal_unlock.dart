import 'package:flutter/material.dart';

class CustomLoadModalUnlock extends StatelessWidget {

  const CustomLoadModalUnlock({super.key});

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
              color: Colors.blue,
              strokeWidth: 6.0, // Aumenta a largura da animação
            ),
            const SizedBox(height: 16),
            const Text(
              'Desbloqueando\n    o veículo', // Texto quebrado em duas linhas
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center, // Centraliza o texto
            ),
          ],
        ),
      ),
    );
  }
}