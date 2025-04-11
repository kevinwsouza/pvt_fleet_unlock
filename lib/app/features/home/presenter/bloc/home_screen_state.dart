import '../../../../shared/mocks/vehicle_model.dart';

sealed class HomeScreenState {}

final class HomeScreenInitialState extends HomeScreenState {}

final class HomeScreenLoading extends HomeScreenState {}

final class HomeScreenErrorState extends HomeScreenState {
  final String errorMessage;

  HomeScreenErrorState(this.errorMessage);
}

final class HomeScreenSuccessState extends HomeScreenState {
  final List<VehicleModel> vehicles;

  HomeScreenSuccessState(this.vehicles);
}