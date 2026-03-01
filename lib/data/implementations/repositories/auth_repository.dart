import 'package:new_project/data/dtos/login/login_request_dtos.dart';
import 'package:new_project/data/dtos/login/login_response_dto.dart';
import 'package:new_project/data/implementations/api/auth_api.dart';
import 'package:new_project/data/interfaces/mapper/imapper.dart';
import 'package:new_project/data/interfaces/repositories/iauth_repository.dart';

import 'package:new_project/domain/entities/auth_session.dart';

class AuthRepository implements IauthRepository {
  final AuthApi api;
  final Imapper<LoginResponseDto, AuthSession> mapper;
  AuthRepository({required this.api, required this.mapper});
  @override
  Future<AuthSession> login(String userName, String passWord) async {
    final req = LoginRequestDtos(userName: userName, passWord: passWord);
    final dto = await api.login(req);
    return mapper.map(dto);
  }

  @override
  Future<AuthSession?> getCurrentSession() async {
    // TODO: implement getCurrentSession
    final dto = await api.getCurrentSession();
    if (dto == null) return null;
    return mapper.map(dto);
  }

  @override
  Future<void> logout() => api.logout();
}
