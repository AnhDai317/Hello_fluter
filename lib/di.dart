import 'package:new_project/data/implementations/api/auth_api.dart';
import 'package:new_project/data/implementations/api/managed_user_api.dart';
import 'package:new_project/data/implementations/local/app_database.dart';
import 'package:new_project/data/implementations/mapper/auth_mapper.dart';
import 'package:new_project/data/implementations/mapper/manage_user_mapper.dart';
import 'package:new_project/data/implementations/repositories/auth_repository.dart';
import 'package:new_project/data/implementations/repositories/managed_user_repository.dart';
import 'package:new_project/viewmodels/login/login_viewmodel.dart';
import 'package:new_project/viewmodels/user/user_viewmodel.dart';

LoginViewModel buildLogin() {
  final api = AuthApi(AppDatabase.instance);
  final mapper = AuthMapper();
  final repo = AuthRepository(api: api, mapper: mapper);
  return LoginViewModel(repo);
}
ManagedUserRepository buildManagedUserRepository(){
  final api = ManagedUserApi(AppDatabase.instance);
  final mapper = ManagedUserMapper();
  return ManagedUserRepository(api: api, mapper: mapper);
}
UsersViewModel buildUsersViewModel(){
  return UsersViewModel(repo: buildManagedUserRepository());
}
