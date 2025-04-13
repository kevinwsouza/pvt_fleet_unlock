import 'package:frotalog_gestor_v2/app/features/home/presenter/bloc/home_screen_state.dart';
import 'package:frotalog_gestor_v2/app/shared/mocks/vehicle_service.dart';
import 'package:frotalog_gestor_v2/app/utils/ecubit.dart';

class HomeScreenController extends ECubit<HomeScreenState> {
  final VehicleService _vehicleService;

  HomeScreenController(this._vehicleService) : super(HomeScreenInitialState());

Future<void> fetchVehicles() async {
  emit(HomeScreenLoading());
  try {
    print("Carregando veículos...");
    final vehicles = await _vehicleService.fetchVehicles();
    print("Veículos carregados: ${vehicles.length}");
    emit(HomeScreenSuccessState(vehicles));
  } catch (e) {
    print("Erro ao carregar veículos: $e");
    emit(HomeScreenErrorState(e.toString()));
  }
}
}