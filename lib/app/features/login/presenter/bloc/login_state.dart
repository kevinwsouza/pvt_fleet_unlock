sealed class LoginState {}

final class LoginInitialState extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginErrorState extends LoginState {}

final class LoginSuccessState extends LoginState {}