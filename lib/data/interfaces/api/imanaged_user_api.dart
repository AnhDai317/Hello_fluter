import 'package:new_project/data/dtos/user_management/managed_user_dto.dart';

abstract class ImanagedUserApi {
  Future<List<ManagedUserDto>> getAll();
  Future<ManagedUserDto?> getById(int id);
  Future<ManagedUserDto> create(String fullName,String dob, String address);
  Future<ManagedUserDto> update(int id,String fullName,String dob, String address);
  Future<void> delete(int id);

Future<void> seedDemoIfEmpty();

}