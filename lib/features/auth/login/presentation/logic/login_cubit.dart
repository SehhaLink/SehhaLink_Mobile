import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/features/auth/login/data/models/login_request_body.dart';
import 'package:sehhalink/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:sehhalink/features/auth/login/presentation/logic/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(LoginRequestBody loginRequest) async {
    emit(LoginLoading());
    try {
      final result = await loginUseCase(loginRequest);
      result.when(
        onSuccess: (_) => emit(LoginLoaded()),
        onError: (error) => emit(LoginFailuer(errMessage: error.message)),
      );
    } catch (e) {
      emit(LoginFailuer(errMessage: e.toString()));
    }
  }
}
