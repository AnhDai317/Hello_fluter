import 'package:new_project/data/dtos/login/login_request_dtos.dart';
import 'package:new_project/data/dtos/login/login_response_dto.dart';
import 'package:new_project/data/dtos/login/user_dto.dart';
import 'package:new_project/data/implementations/local/app_database.dart';
import 'package:new_project/data/implementations/local/password_hasher.dart';
import 'package:new_project/data/interfaces/api/iauth_api.dart';
import 'package:sqflite/sqflite.dart';

class AuthApi implements IauthApi {
  final AppDatabase database;
  AuthApi(this.database);
  @override
  Future<LoginResponseDto?> getCurrentSession() async {
    final db = await database.db;

    final s = await db.query('session', where: 'id = 1', limit: 1);
    if (s.isEmpty) return null;

    final sessionRow = s.first;
    final userId = sessionRow['user_id'] as int;
    final token = (sessionRow['token'] ?? '').toString();
    final u = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
      limit: 1,
    );

    if (u.isEmpty) return null;

    final userDto = UserDto.fromMap(u.first);
    return LoginResponseDto(token: token, user: userDto);
  }

  @override
  Future<void> logout() async {
    final db = await database.db;
    await db.delete('session');
  }

  @override
  Future<LoginResponseDto> login(LoginRequestDtos req) async {
    final db = await database.db;

    // 1. Tìm user
    final rows = await db.query(
      'users',
      where: 'user_name = ?',
      whereArgs: [req.userName],
      limit: 1,
    );

    if (rows.isEmpty) {
      throw Exception('Sai tài khoản hoặc mật khẩu');
    }

    final userRow = rows.first;
    final storeHash = (userRow['password_hash'] ?? '').toString();
    final inputHash = PasswordHasher.sha256Hash(req.passWord);

    if (storeHash != inputHash) {
      throw Exception("Sai tài khoản hoặc mật khẩu");
    }

    final userId = userRow['id'] as int;
    final token = 'token_${DateTime.now().microsecondsSinceEpoch}';
    final now = DateTime.now().toIso8601String();

    await db.insert('session', {
      'id': 1,
      'user_id': userId,
      'token': token,
      'created_at': now,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    final userDto = UserDto.fromMap(userRow);
    return LoginResponseDto(token: token, user: userDto);
  }
}
//   @override
//   Future<LoginResponseDto> login(LoginRequestDtos req) async {
//     await Future.delayed(const Duration(milliseconds: 600));

//     if (req.userName == 'admin' && req.passWord == '123456') {
//       final json = {
//         'token': 'fake_jwt_abc123',
//         'user': {
//           // ✅ ĐÚNG: Đây là Map<String, dynamic>
//           'id': '1',
//           'userName': 'admin',
//         },
//       };
//       return LoginResponseDto.fromJson(json);
//     }
//     throw Exception('Invalid username or password');
//   }
// }
