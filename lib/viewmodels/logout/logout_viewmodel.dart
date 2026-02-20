import 'package:flutter/material.dart';
import 'package:new_project/domain/entities/auth_session.dart';

/// ViewModel riêng cho chức năng Logout
/// File: lib/viewmodels/logout/logout_viewmodel.dart
class LogoutViewModel extends ChangeNotifier {
  bool _isLoggingOut = false;

  bool get isLoggingOut => _isLoggingOut;

  /// Thực hiện logout
  Future<void> logout() async {
    _isLoggingOut = true;
    notifyListeners();

    // Giả lập xử lý logout (gọi API nếu cần)
    await Future.delayed(const Duration(milliseconds: 300));

    _isLoggingOut = false;
    notifyListeners();

    print('✅ [LogoutViewModel] Logout thành công');
  }

  /// Reset state
  void reset() {
    _isLoggingOut = false;
    notifyListeners();
  }
}
