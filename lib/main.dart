import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import các thành phần dữ liệu
import 'package:new_project/data/implementations/local/app_database.dart';
import 'package:new_project/data/implementations/api/auth_api.dart';
import 'package:new_project/data/implementations/mapper/auth_mapper.dart';
import 'package:new_project/data/implementations/repositories/auth_repository.dart';

// Import ViewModels
import 'package:new_project/viewmodels/login/login_viewmodel.dart';
import 'package:new_project/viewmodels/logout/logout_viewmodel.dart';

// Import Views
import 'package:new_project/views/login_page.dart';

void main() {
  // 1. BẮT BUỘC: Đảm bảo Flutter framework đã sẵn sàng trước khi gọi Database
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Setup dependencies (Dependency Injection thủ công)
  // Khởi tạo Api với instance của Database
  final authApi = AuthApi(AppDatabase.instance);

  // Khởi tạo Mapper để chuyển đổi DTO thành Entity
  final authMapper = AuthMapper();

  // Khởi tạo Repository làm cầu nối giữa Api và ViewModel
  final authRepository = AuthRepository(api: authApi, mapper: authMapper);

  runApp(
    MultiProvider(
      providers: [
        // Cung cấp LoginViewModel cho toàn bộ ứng dụng
        ChangeNotifierProvider(create: (_) => LoginViewModel(authRepository)),
        // Cung cấp LogoutViewModel
        ChangeNotifierProvider(create: (_) => LogoutViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Management',
      // Tắt biểu tượng Debug ở góc màn hình
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true, // Sử dụng giao diện Material 3 mới nhất
      ),
      // Màn hình khởi đầu là trang Đăng nhập
      home: const LoginPage(),
    );
  }
}
