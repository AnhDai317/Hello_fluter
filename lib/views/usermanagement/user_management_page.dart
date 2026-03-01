import 'package:flutter/material.dart';
import 'user_management_header.dart';
import 'user_item_card.dart';
import 'user_detail_page.dart';
import 'user_form_page.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const UserManagementHeader(
            title: "Quản lý người dùng",
            subtitle: "Danh sách • Thêm/Sửa/Xóa",
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              children: [
                // Người dùng A
                UserItemCard(
                  name: "Nguyễn Văn A",
                  dob: "01/01/1990",
                  address: "123 Đường A, Phường B, Quận T",
                  onTap: () => _navigateToDetail(
                    context,
                    "Nguyễn Văn A",
                    "01/01/1990",
                    "123 Đường A, Phường B, Quận T",
                  ),
                ),
                // Người dùng B
                UserItemCard(
                  name: "Trần Thị B",
                  dob: "10/03/1992",
                  address: "21 Nguyễn Trãi, Hà Nội",
                  onTap: () => _navigateToDetail(
                    context,
                    "Trần Thị B",
                    "10/03/1992",
                    "21 Nguyễn Trãi, Hà Nội",
                  ),
                ),
                // Người dùng C
                UserItemCard(
                  name: "Lê Văn C",
                  dob: "08/08/1995",
                  address: "30 Xã Đàn, Hà Nội",
                  onTap: () => _navigateToDetail(
                    context,
                    "Lê Văn C",
                    "08/08/1995",
                    "30 Xã Đàn, Hà Nội",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const UserFormPage()),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Hàm helper để viết code gọn hơn
  void _navigateToDetail(
    BuildContext context,
    String name,
    String dob,
    String address,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserDetailPage(name: name, dob: dob, address: address),
      ),
    );
  }
}
