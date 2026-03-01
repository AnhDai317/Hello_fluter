class UpdateUserRequestDto {
  final int? id;
  final String? fullName;
  final String? dob;
  final String? address;

  UpdateUserRequestDto({this.id, this.fullName, this.dob, this.address});

  Map<String, dynamic> toMapForInsert() => {
    'full_name': fullName,
    'dob': dob,
    'address': address,
    'created_at': DateTime.now().toIso8601String(),
  };
  Map<String, dynamic> toMapForUpdate() => {
    'full_name': fullName,
    'dob': dob,
    'address': address,
  };
}
