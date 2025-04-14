import 'package:flutter/material.dart';

class CustomPopupUnlockCar extends StatelessWidget {
  final String carId; // Placa do veículo
  final String fleet; // Frota do veículo
  final VoidCallback onUnlock; // Callback para o botão "Desbloquear"

  const CustomPopupUnlockCar({
    super.key,
    required this.carId,
    required this.fleet,
    required this.onUnlock,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Centraliza o conteúdo
        children: [
          Text(
            'Deseja desbloquear o veículo',
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),
            textAlign: TextAlign.center, // Centraliza o texto
          ),
          const SizedBox(height: 8),
          Text(
            '$carId / $fleet ?',
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center, // Centraliza o texto
          ),
        ],
      ),
      content: const Text(
        'Lembre-se: essa operação pode ser utilizada apenas uma vez por tentativa de arranque do veículo.',
        style: TextStyle(fontSize: 14.0, color: Colors.black54),
        textAlign: TextAlign.center, // Centraliza o texto
      ),
      actionsAlignment: MainAxisAlignment.center, // Centraliza os botões
      actions: [
        Column(
          children: [
            SizedBox(
              width: double.infinity, // Ocupa toda a largura da modal
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha a popup
                  onUnlock(); // Executa a ação de desbloqueio
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Fundo azul
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Desbloquear',
                  style: TextStyle(color: Colors.white), // Texto branco
                ),
              ),
            ),
            const SizedBox(height: 8), // Espaçamento entre os botões
            SizedBox(
              width: double.infinity, // Ocupa toda a largura da modal
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha a popup
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue), // Borda azul
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.blue), // Texto azul
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}