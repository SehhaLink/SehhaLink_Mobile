abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {}

class LoginFailuer extends LoginState {
  final String errMessage;

  LoginFailuer({required this.errMessage});
}
