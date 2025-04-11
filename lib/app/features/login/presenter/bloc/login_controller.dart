import 'package:frotalog_gestor_v2/app/features/login/presenter/bloc/login_state.dart';
import '../../../../shared/mocks/login_mock.dart';
import '../../../../utils/ecubit.dart';

class LoginController extends ECubit<LoginState> {
  LoginController() : super(LoginInitialState());

  void login(String username, String password) {
    emit(LoginLoading());

    // Simula uma chamada de API com um pequeno atraso
    Future.delayed(const Duration(seconds: 2), () {
      if (username == LoginMock.username && password == LoginMock.password) {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState());
      }
    });
  }

  void handleErrorAcknowledged() {
    // Retorna automaticamente ao estado inicial após o erro
    emit(LoginInitialState());
  }
}