import 'package:new_project/data/dtos/user_management/managed_user_dto.dart';
import 'package:new_project/data/dtos/user_management/update_user_request_dto.dart'; // Import để dùng toMap
import 'package:new_project/data/implementations/local/app_database.dart';
import 'package:new_project/data/interfaces/api/imanaged_user_api.dart';
import 'package:sqflite/sqflite.dart';

class ManagedUserApi implements ImanagedUserApi {
  final AppDatabase database;
  ManagedUserApi(this.database);

  @override
  Future<ManagedUserDto> create(String fullName, String dob, String address) async {
    final db = await database.db;
    final request = UpdateUserRequestDto(fullName: fullName, dob: dob, address: address);
    final id = await db.insert('managed_users', request.toMapForInsert());
    
    final result = await getById(id);
    if (result == null) throw Exception('Lỗi khi lấy dữ liệu sau khi tạo');
    return result;
  }

  @override
  Future<void> delete(int id) async {
    final db = await database.db;
    await db.delete(
      'managed_users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<ManagedUserDto>> getAll() async {
    final db = await database.db;
    final List<Map<String, dynamic>> maps = await db.query('managed_users', orderBy: 'id DESC');
    
    return maps.map((map) => ManagedUserDto.fromMap(map)).toList();
  }

  @override
  Future<ManagedUserDto?> getById(int id) async {
    final db = await database.db;
    final List<Map<String, dynamic>> maps = await db.query(
      'managed_users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1
    );

    if (maps.isNotEmpty) {
      return ManagedUserDto.fromMap(maps.first);
    }
    return null;
  }

 @override
  Future<void> seedDemoIfEmpty() async {
    final db = await database.db;
        final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM managed_users'));
    
    if ((count ?? 0) > 0) return; {
      await db.insert('managed_users', {
        'full_name': 'Nguyen Van A',
        'dob': '1990-01-01',
        'address': 'Hà Nội',
        'created_at': DateTime.now().toIso8601String(),
      });

     
      

    }
  }

  @override
  Future<ManagedUserDto> update(int id, String fullName, String dob, String address) async {
    final db = await database.db;
    
    final request = UpdateUserRequestDto(
      id: id,
      fullName: fullName,
      dob: dob,
      address: address,
    );

    await db.update(
      'managed_users',
      request.toMapForUpdate(),
      where: 'id = ?',
      whereArgs: [id],
    );

    final result = await getById(id);
    if (result == null) throw Exception('Không tìm thấy User sau khi cập nhật');
    return result;
  }
}