import 'package:frotalog_gestor_v2/app/features/home/presenter/bloc/home_screen_state.dart';
import 'package:frotalog_gestor_v2/app/shared/mocks/vehicle_service.dart';
import 'package:frotalog_gestor_v2/app/utils/ecubit.dart';

class HomeScreenController extends ECubit<HomeScreenState> {
  final VehicleService vehicleService;

  HomeScreenController(this.vehicleService) : super(HomeScreenInitialState());

  Future<void> fetchVehicles() async {
    emit(HomeScreenLoading());

    try {
      final vehicles = await vehicleService.fetchVehicles();
      emit(HomeScreenSuccessState(vehicles));
    } catch (e) {
      emit(HomeScreenErrorState('Erro ao buscar os veículos!'));
    }
  }
}