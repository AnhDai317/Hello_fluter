import 'package:new_project/data/dtos/user_management/managed_user_dto.dart';
import 'package:new_project/data/interfaces/mapper/imapper.dart';
import 'package:new_project/domain/entities/managed_user.dart';

class ManagedUserMapper implements Imapper<ManagedUserDto, ManagedUser> {
  
  @override // Sửa lỗi viết sai: @override (có 2 chữ r)
  ManagedUser map(ManagedUserDto input) {
    return ManagedUser(
      id: input.id ?? 0, 
      fullName: input.fullName,
      dob: input.dob,
      address: input.address,
      createdAt: input.createdAt, 
    ); 
  }
}

