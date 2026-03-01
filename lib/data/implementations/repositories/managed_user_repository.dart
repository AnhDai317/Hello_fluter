import 'package:new_project/data/dtos/user_management/managed_user_dto.dart';
import 'package:new_project/data/dtos/user_management/update_user_request_dto.dart'; // Import thêm cái này
import 'package:new_project/data/interfaces/api/imanaged_user_api.dart';
import 'package:new_project/data/interfaces/mapper/imapper.dart';
import 'package:new_project/data/interfaces/repositories/imanaged_user_repository.dart';
import 'package:new_project/domain/entities/managed_user.dart';

class ManagedUserRepository implements ImanagedUserRepository {
  final ImanagedUserApi api;
  final Imapper<ManagedUserDto, ManagedUser> mapper;

  ManagedUserRepository({required this.api, required this.mapper});

@override
Future<ManagedUser> create(String fullName, String dob, String address) async {
  final dto = await api.create(fullName, dob, address);
  return mapper.map(dto);
}
  @override
  Future<void> delete(int id) async {
    await api.delete(id);
  }

  @override
  Future<List<ManagedUser>> getAll() async {
    final dtos = await api.getAll();
    return dtos.map((dto) => mapper.map(dto)).toList();
  }

  @override
  Future<ManagedUser?> getById(int id) async {
    final dto = await api.getById(id);
    return dto == null ? null : mapper.map(dto);
  }

  @override
  Future<void> seedDemoIfEmpty() => api.seedDemoIfEmpty();

  @override
Future<ManagedUser> update(int id, String fullName, String dob, String address) async {
  final updatedDto = await api.update(
    id, 
    fullName, 
    dob, 
    address,
  );
  return mapper.map(updatedDto);
}
}