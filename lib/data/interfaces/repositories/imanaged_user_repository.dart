import 'package:new_project/domain/entities/managed_user.dart';

abstract class ImanagedUserRepository {
  Future<void> seedDemoIfEmpty();
  Future<List<ManagedUser>> getAll();
  Future<ManagedUser?> getById(int id);
  Future<ManagedUser> create(String fullName,String dob, String address);
  Future<ManagedUser> update(int id,String fullName,String dob, String address);
  Future<void> delete(int id);
}