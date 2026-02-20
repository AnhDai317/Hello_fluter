import 'package:flutter/material.dart';
import 'package:new_project/domain/entities/auth_session.dart';
import 'package:new_project/data/interfaces/repositories/iauth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final IauthRepository _repository;

  LoginViewModel(this._repository);

  bool _loading = false;
  String? _error;
  AuthSession? _session;

  bool get loading => _loading;
  String? get error => _error;
  AuthSession? get session => _session;

  Future<bool> login(String userName, String passWord) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _session = await _repository.login(userName, passWord);
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _loading = false;
      _session = null;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<void> logout() async {
    _loading = true;
    notifyListeners();

    try {
      await _repository.logout();
      _session = null;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Xóa session - được gọi bởi LogoutViewModel
  void clearSession() {
    _session = null;
    _error = null;
    _loading = false;
    notifyListeners();
  }
}
