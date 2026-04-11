import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:sehhalink/features/auth/domain/use_cases/login_use_case.dart';
import 'package:sehhalink/features/auth/domain/use_cases/register_use_case.dart';
import 'package:sehhalink/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:sehhalink/features/auth/data/model/reset_password_model.dart';
import 'package:sehhalink/features/auth/data/model/login_request_body.dart';
import 'package:sehhalink/features/auth/data/model/register_request_body.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.forgetPasswordUseCase,
    required this.resetPasswordUseCase,
  }) : super(const AuthState());

  Future<void> login(LoginRequestBody loginRequest) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    try {
      final result = await loginUseCase(loginRequest);
      result.when(
        onSuccess: (_) => emit(state.copyWith(status: AuthStatus.loginSuccess)),
        onError: (error) => emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: error.message,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> register(RegisterRequestBody requestBody) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    final result = await registerUseCase.register(requestBody);
    result.when(
      onSuccess: (_) =>
          emit(state.copyWith(status: AuthStatus.registerSuccess)),
      onError: (error) => emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> forgetPassword(String email) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    final result = await forgetPasswordUseCase(email);
    result.when(
      onSuccess: (_) => emit(
        state.copyWith(
          status: AuthStatus.forgetPasswordEmailSent,
          userEmail: email,
        ),
      ),
      onError: (error) => emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: error.message,
        ),
      ),
    );
  }

  // ─── Reset Password ───────────────────────────────────────
  Future<void> resetPassword(ResetPasswordModel resetPasswordModel) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    final result = await resetPasswordUseCase(resetPasswordModel);
    result.when(
      onSuccess: (_) =>
          emit(state.copyWith(status: AuthStatus.resetPasswordSuccess)),
      onError: (error) => emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: error.message,
        ),
      ),
    );
  }

  void resetState() => emit(const AuthState());
}