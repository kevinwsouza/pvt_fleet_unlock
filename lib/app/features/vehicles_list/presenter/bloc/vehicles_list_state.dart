sealed class VehiclesListState {}

final class VehiclesListInitialState extends VehiclesListState {}

final class VehiclesListLoading extends VehiclesListState {}

final class VehiclesListErrorState extends VehiclesListState {}

final class VehiclesListSuccessState extends VehiclesListState {}