import 'package:new_project/data/dtos/login/login_response_dto.dart';
import 'package:new_project/data/interfaces/mapper/imapper.dart';
import 'package:new_project/domain/entities/auth_session.dart';
import 'package:new_project/domain/entities/user.dart';

class AuthMapper implements Imapper<LoginResponseDto, AuthSession> {
  @override
  AuthSession map(LoginResponseDto input) {
    // TODO: implement map
    return AuthSession(
      token: input.token,
      user: User(id: input.user.id, userName: input.user.userName),
    );
  }
}
