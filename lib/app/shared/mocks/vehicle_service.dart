import 'package:frotalog_gestor_v2/app/shared/mocks/vehicle_model.dart';

class VehicleService {
  // Simula a chamada da API para obter os veículos
  Future<List<VehicleModel>> fetchVehicles() async {
    // Simula um atraso para imitar uma chamada de API
    await Future.delayed(const Duration(seconds: 1));

    // Dados mockados
    return [
      VehicleModel(
        fleet: 'Fleet 123',
        carId: 'ABC1234',
        serialCoPilot: 'VIRTEC_VL8_GOAO',
      ),
      VehicleModel(
        fleet: 'Fleet 456',
        carId: 'DEF5678',
        serialCoPilot: 'VIRTEC_VL8_G5DH',
      ),
      VehicleModel(
        fleet: 'Fleet 789',
        carId: 'GHI9012',
        serialCoPilot: 'COPILOT-003',
      ),
      // Novos veículos adicionados
      VehicleModel(
        fleet: 'Fleet 321',
        carId: 'JKL3456',
        serialCoPilot: 'COPILOT-004',
      ),
      VehicleModel(
        fleet: 'Fleet 654',
        carId: 'MNO7890',
        serialCoPilot: 'COPILOT-005',
      ),
      VehicleModel(
        fleet: 'Fleet 987',
        carId: 'PQR1234',
        serialCoPilot: 'COPILOT-006',
      ),
      VehicleModel(
        fleet: 'Fleet 987',
        carId: 'PTR1234',
        serialCoPilot: 'COPILOT-007',
      ),
    ];
  }

  // Verifica se um veículo com os parâmetros fornecidos existe
  Future<bool> checkVehicleExists({
    required String fleet,
    required String carId,
    required String serialCoPilot,
  }) async {
    final vehicles = await fetchVehicles();

    // Verifica se existe um veículo que corresponde aos parâmetros
    return vehicles.any((vehicle) =>
        vehicle.fleet == fleet &&
        vehicle.carId == carId &&
        vehicle.serialCoPilot == serialCoPilot);
  }
}