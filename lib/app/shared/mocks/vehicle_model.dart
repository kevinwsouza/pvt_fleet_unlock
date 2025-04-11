class VehicleModel {
  final String fleet; // Frota do veículo
  final String carId; // Placa do veículo
  final String serialCoPilot; // Serial do hardware (co-pilot)

  VehicleModel({
    required this.fleet,
    required this.carId,
    required this.serialCoPilot,
  });
}