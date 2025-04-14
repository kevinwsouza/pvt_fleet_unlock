import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:frotalog_gestor_v2/app/features/vehicles_list/presenter/bloc/vehicles_list_state.dart';
import 'package:frotalog_gestor_v2/app/utils/ecubit.dart';

class VehiclesListController extends ECubit<VehiclesListState> {
  VehiclesListController() : super(VehiclesListInitialState());

  Future<void> loadVehicles() async {
    emit(VehiclesListLoading());
    try {
      // Simula carregamento de veículos
      await Future.delayed(const Duration(seconds: 2));
      emit(VehiclesListSuccessState());
    } catch (e) {
      emit(VehiclesListErrorState(message: 'Nenhum veículo encontrado.'));
    }
  }

  Future<void> connectToDevice(String platformName) async {
    emit(VehiclesListLoading());

    try {
      // Verifica se o Bluetooth está ligado
      final isBluetoothEnabled =
          await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;

      if (!isBluetoothEnabled) {
        emit(VehiclesListErrorState(
            message:
                'Bluetooth está desligado. Por favor, ligue o Bluetooth.'));
        return;
      }

      // Obtém a lista de dispositivos já emparelhados
      final List<BluetoothDevice> bondedDevices =
          await FlutterBluePlus.bondedDevices;

      if (bondedDevices.isEmpty) {
        emit(VehiclesListErrorState(
            message: 'Nenhum dispositivo emparelhado encontrado.'));
        return;
      }

      // Encontra o dispositivo correspondente ao platformName
      final BluetoothDevice? matchedDevice = bondedDevices.firstWhere(
        (device) => device.platformName == platformName,
        orElse: () =>
            throw Exception('Dispositivo correspondente não encontrado.'),
      );

// Verifica se o dispositivo foi encontrado
      if (matchedDevice == null) {
        emit(VehiclesListErrorState(
            message: 'Dispositivo correspondente não encontrado.'));
        return;
      }

      // Conecta ao dispositivo correspondente
      emit(VehiclesListLoading(
          message:
              'Conectando ao dispositivo ${matchedDevice.platformName}...'));

      await matchedDevice.connect(); // Realiza a conexão com o dispositivo

      emit(VehiclesListSuccessState(
        message: 'Conectado ao dispositivo: ${matchedDevice.platformName}',
      ));
    } catch (e) {
      emit(VehiclesListErrorState(message: 'Erro ao conectar: $e'));
    }
  }
}









/*
bool permissionsGranted = await PermissionManagerBluetooth().requestPermissions();
  if (!permissionsGranted) {
    emit(DetailsScreenErrorState(message: 'Permissões não concedidas.'));
    return false;
  }
  */