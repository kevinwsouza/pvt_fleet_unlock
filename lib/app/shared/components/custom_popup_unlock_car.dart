import 'package:flutter/material.dart';

class CustomPopupUnlockCar extends StatelessWidget {
  final String carId; 
  final String fleet; 
  final VoidCallback onUnlock; 

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
        borderRadius: BorderRadius.circular(12.0), 
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          Text(
            'Deseja desbloquear o veículo',
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),
            textAlign: TextAlign.center, 
          ),
          const SizedBox(height: 8),
          Text(
            '$carId / $fleet ?',
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center, 
          ),
        ],
      ),
      content: const Text(
        'Lembre-se: essa operação pode ser utilizada apenas uma vez por tentativa de arranque do veículo.',
        style: TextStyle(fontSize: 14.0, color: Colors.black54),
        textAlign: TextAlign.center, 
      ),
      actionsAlignment: MainAxisAlignment.center, 
      actions: [
        Column(
          children: [
            SizedBox(
              width: double.infinity, 
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                  onUnlock(); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Desbloquear',
                  style: TextStyle(color: Colors.white), 
                ),
              ),
            ),
            const SizedBox(height: 8), 
            SizedBox(
              width: double.infinity, 
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.blue), 
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}