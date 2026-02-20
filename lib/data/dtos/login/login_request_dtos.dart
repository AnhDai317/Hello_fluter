class LoginRequestDtos {
  final String userName;
  final String passWord;
  const LoginRequestDtos({required this.userName, required this.passWord});
  //Class này đại diện cho dữ liệu GỬI LÊN SERVER khi user đăng nhập , Chuyển object thành Map để gửi API
  Map<String, dynamic> toJson() => {'userName': userName, 'passWord': passWord};
}
