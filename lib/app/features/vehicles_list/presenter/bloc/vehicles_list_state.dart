sealed class VehiclesListState {}

final class VehiclesListInitialState extends VehiclesListState {}

final class VehiclesListLoading extends VehiclesListState {
  final String? message; 

  VehiclesListLoading({this.message});
}

final class VehiclesListErrorState extends VehiclesListState {
  final String message; 
  VehiclesListErrorState({required this.message});
}

final class VehiclesListSuccessState extends VehiclesListState {
  final String? message;

  VehiclesListSuccessState({this.message});
}