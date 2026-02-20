import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/features/auth/forget_password/data/models/reset_password_model.dart';
import 'package:sehhalink/features/auth/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:sehhalink/features/auth/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:sehhalink/features/auth/forget_password/presentation/logic/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  ForgetPasswordCubit(this.forgetPasswordUseCase, this.resetPasswordUseCase)
    : super(ForgetPasswordInitial());

  String userEmail = '';

  Future<void> forgetPassword(String email) async {
    emit(ForgetPasswordLoading());
    final result = await forgetPasswordUseCase(email);
    result.when(
      onSuccess: (_) {
        userEmail = email;
        emit(ForgetPasswordSuccess());
      },
      onError: (error) => emit(ForgetPasswordError(error.message)),
    );
  }

  Future<void> resetPassword(ResetPasswordModel resetPasswordModel) async {
    emit(ResetPasswordLoading());
    final result = await resetPasswordUseCase(resetPasswordModel);
    result.when(
      onSuccess: (_) => emit(ResetPasswordSuccess()),
      onError: (error) => emit(ResetPasswordError(error.message)),
    );
  }
}
