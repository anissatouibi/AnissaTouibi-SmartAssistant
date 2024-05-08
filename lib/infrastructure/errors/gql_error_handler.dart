import 'package:dio/dio.dart';

class GqlErrorHandler {
  static exceptionThrower(Response response) {
    final errors = response.data['errors'];
    if (errors != null) {
      if ((errors as List).any((element) => element["message"] != "Forbidden resource") ||
          response.data['data'] == null) {
        throw DioException(
            type: DioExceptionType.badResponse,
            response: Response(data: errors[0], requestOptions: RequestOptions()),
            requestOptions: RequestOptions());
      }
    }
  }
}
