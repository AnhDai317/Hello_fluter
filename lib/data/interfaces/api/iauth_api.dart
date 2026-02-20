import 'package:new_project/data/dtos/login/login_request_dtos.dart';
import 'package:new_project/data/dtos/login/login_response_dto.dart';

abstract class IauthApi {
  Future<LoginResponseDto> login(LoginRequestDtos req);
  Future<LoginResponseDto?> getCurrentSession();
  Future<void> logout();
}
