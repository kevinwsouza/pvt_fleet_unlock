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
      emit(VehiclesListErrorState());
    }
  }
}