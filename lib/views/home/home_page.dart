import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_project/viewmodels/login/login_viewmodel.dart';
import 'package:new_project/viewmodels/logout/logout_viewmodel.dart';
import 'package:new_project/views/login_page.dart';

// Import các component vừa tách và trang quản lý user
import 'home_header.dart';
import 'home_menu_button.dart';
import '../usermanagement/user_management_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginVm = context.watch<LoginViewModel>();
    final username = loginVm.session?.user.userName ?? 'User';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.blue.shade100],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Sử dụng component HomeHeader đã tách
              HomeHeader(username: username),
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      HomeMenuButton(
                        icon: Icons.person_outline,
                        iconColor: Colors.blue,
                        iconBgColor: Colors.blue.shade50,
                        title: 'Quản lý người dùng',
                        onTap: () {
                          // Đã chuyển hướng sang trang UserManagementPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserManagementPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      HomeMenuButton(
                        icon: Icons.calendar_today,
                        iconColor: Colors.orange,
                        iconBgColor: Colors.orange.shade50,
                        title: 'Quản lý nhắc việc',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Chức năng đang phát triển'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      HomeMenuButton(
                        icon: Icons.shopping_cart_outlined,
                        iconColor: Colors.blue,
                        iconBgColor: Colors.blue.shade50,
                        title: 'Đặt hàng',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Chức năng đang phát triển'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      HomeMenuButton(
                        icon: Icons.map_outlined,
                        iconColor: Colors.red,
                        iconBgColor: Colors.red.shade50,
                        title: 'Xem Bản Đồ',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Chức năng đang phát triển'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      HomeMenuButton(
                        icon: Icons.flutter_dash,
                        iconColor: Colors.blue.shade400,
                        iconBgColor: Colors.blue.shade50,
                        title: 'Tổng quan Flutter',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Chức năng đang phát triển'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      HomeMenuButton(
                        icon: Icons.power_settings_new,
                        iconColor: Colors.red.shade400,
                        iconBgColor: Colors.red.shade50,
                        title: 'Đăng xuất',
                        onTap: () {
                          _showLogoutDialog(context, username);
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Giữ nguyên logic hàm showDialog của bạn
  void _showLogoutDialog(BuildContext context, String username) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Xác nhận đăng xuất',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Text(
            'Bạn có chắc chắn muốn đăng xuất, $username?',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Hủy',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();

                final logoutVm = context.read<LogoutViewModel>();
                final loginVm = context.read<LoginViewModel>();

                await logoutVm.logout();
                loginVm.clearSession();

                if (!context.mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Đăng xuất',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
