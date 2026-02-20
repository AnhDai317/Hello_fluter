import 'package:new_project/data/implementations/api/auth_api.dart';
import 'package:new_project/data/implementations/local/app_database.dart';
import 'package:new_project/data/implementations/mapper/auth_mapper.dart';
import 'package:new_project/data/implementations/repositories/auth_repository.dart';
import 'package:new_project/viewmodels/login/login_viewmodel.dart';

LoginViewModel buildLogin() {
  final api = AuthApi(AppDatabase.instance);
  final mapper = AuthMapper();
  final repo = AuthRepository(api: api, mapper: mapper);
  return LoginViewModel(repo);
}
