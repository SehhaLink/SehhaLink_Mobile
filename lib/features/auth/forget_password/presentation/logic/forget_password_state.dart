abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {}

class ForgetPasswordError extends ForgetPasswordState {
  final String message;
  ForgetPasswordError(this.message);
}

class ResetPasswordLoading extends ForgetPasswordState {}

class ResetPasswordSuccess extends ForgetPasswordState {}

class ResetPasswordError extends ForgetPasswordState {
  final String message;
  ResetPasswordError(this.message);
}