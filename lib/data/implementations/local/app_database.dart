import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:new_project/data/implementations/local/password_hasher.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

  Database? _db;

  Future<Database> get db async {
    _db ??= await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mvvm_project.db');

    return await openDatabase(
      path,
      version: 2, // Nâng lên version 2 vì bạn có thay đổi cấu trúc (thêm bảng managed_users)
      onCreate: (Database db, int version) async {
        // Tạo bảng users
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_name TEXT NOT NULL UNIQUE,
            password_hash TEXT NOT NULL
          )
        ''');

        // Tạo bảng session
        await db.execute('''
          CREATE TABLE session(
            id INTEGER PRIMARY KEY CHECK (id = 1),
            user_id INTEGER NOT NULL,
            token TEXT NOT NULL,
            created_at TEXT NOT NULL,
            FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
          )
        ''');

        await db.execute('''
          CREATE TABLE managed_users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            full_name TEXT NOT NULL,
            dob TEXT NOT NULL,
            address TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');

        await db.insert('users', {
          'user_name': 'admin',
          'password_hash': PasswordHasher.sha256Hash('Fu@2026'),
        });
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS managed_users(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              full_name TEXT NOT NULL,
              dob TEXT NOT NULL,
              address TEXT NOT NULL,
              created_at TEXT NOT NULL
            )
          ''');
        }
      },
    );
  }
}