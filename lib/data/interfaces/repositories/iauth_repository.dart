import 'package:new_project/domain/entities/auth_session.dart';

abstract class IauthRepository {
  Future<AuthSession> login(String userName, String passWord);
  Future<AuthSession?> getCurrentSession();
  Future<void> logout();
}
