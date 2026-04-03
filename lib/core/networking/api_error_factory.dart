import 'package:sehhalink/core/networking/api_error_model.dart';
import 'package:sehhalink/core/networking/local_status_codes.dart';

class ApiErrorFactory {
  static ApiErrorModel get defaultError => const ApiErrorModel(
        message: "Something went wrong",
        type: ApiErrorType.defaultError,
        statusCode: LocalStatusCodes.defaultError,
      );
}