import 'package:permission_handler/permission_handler.dart';

class PermissionManagerBluetooth {
  // Singleton instance
  static final PermissionManagerBluetooth _instance = PermissionManagerBluetooth._internal();

  // Construtor privado
  PermissionManagerBluetooth._internal();

  // Método para acessar a instância
  factory PermissionManagerBluetooth() => _instance;

  // Método para solicitar permissões de Bluetooth e localização
  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    // Verifica se todas as permissões foram concedidas
    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (!allGranted) {
      print('Permissões necessárias não foram concedidas.');
    }

    return allGranted;
  }
}