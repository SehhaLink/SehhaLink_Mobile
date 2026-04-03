import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhalink/features/auth/register/data/models/register_request_body.dart';
import 'package:sehhalink/features/auth/register/domain/use_cse/register_use_case.dart';
import 'package:sehhalink/features/auth/register/presentation/logic/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;
  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  Future<void> register(RegisterRequestBody requestBody) async {
    emit(RegisterLoading());
    final result = await registerUseCase.register(requestBody);
    result.when(
      onSuccess: (_) {
        emit(RegisterSuccess());
      },
      onError: (err) {
        emit(RegisterError(err.message));
      },
    );
  }
}
