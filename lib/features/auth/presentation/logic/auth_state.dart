import 'package:equatable/equatable.dart';

enum AuthStatus {
  initial,
  loading,
  loginSuccess,
  registerSuccess,
  forgetPasswordEmailSent,
  resetPasswordSuccess,
  failure,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final String? errorMessage;
  final String? userEmail;

  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.userEmail,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    String? userEmail,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, userEmail];
}