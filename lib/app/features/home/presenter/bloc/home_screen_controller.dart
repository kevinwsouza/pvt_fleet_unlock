import 'package:frotalog_gestor_v2/app/features/home/presenter/bloc/home_screen_state.dart';
import 'package:frotalog_gestor_v2/app/shared/mocks/vehicle_service.dart';
import 'package:frotalog_gestor_v2/app/utils/ecubit.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart'; // Biblioteca para verificar o Bluetooth

class HomeScreenController extends ECubit<HomeScreenState> {
  final VehicleService _vehicleService;

  HomeScreenController(this._vehicleService) : super(HomeScreenInitialState());

  // Método para verificar o Bluetooth e buscar os veículos
  Future<void> checkBluetoothAndFetchVehicles() async {
    emit(HomeScreenLoading()); // Emite o estado de carregamento

    try {
      // Verifica o estado do adaptador Bluetooth
      final isBluetoothEnabled = await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;

      if (!isBluetoothEnabled) {
        emit(HomeScreenErrorState('Bluetooth está desativado. Por favor, ative-o.'));
        return;
      }

      // Busca os veículos se o Bluetooth estiver ativado
      final vehicles = await _vehicleService.fetchVehicles();
      emit(HomeScreenSuccessState(vehicles));
    } catch (e) {
      emit(HomeScreenErrorState('Erro ao buscar veículos: $e'));
    }
  }
}