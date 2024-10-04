import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../screens/login_screen.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isVietnamese = true; // Trạng thái ngôn ngữ mặc định (Tiếng Việt)
  String userName = ""; // Biến để lưu tên người dùng

  @override
  void initState() {
    super.initState();
    // Lấy tên người dùng từ Hive
    final userBox = Hive.box('user');
    setState(() {
      userName = userBox.get('name', defaultValue: 'User'); // Lấy tên người dùng
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isVietnamese ? 'Cài đặt' : 'Settings'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Thông tin hồ sơ người dùng
            ListTile(
              title: Text(isVietnamese ? 'Hồ sơ người dùng' : 'User Profile'),
              subtitle: Text('${isVietnamese ? 'Tên người dùng:' : 'Username:'} $userName'), // Hiển thị tên người dùng
              leading: Icon(Icons.person),
            ),
            Divider(),
            
            // Tùy chọn đổi ngôn ngữ
            ListTile(
              title: Text(isVietnamese ? 'Ngôn ngữ' : 'Language'),
              subtitle: Text(isVietnamese ? 'Tiếng Việt' : 'English'),
              leading: Icon(Icons.language),
              trailing: Switch(
                value: isVietnamese,
                onChanged: (value) {
                  setState(() {
                    isVietnamese = value;
                    // Thay đổi ngôn ngữ toàn ứng dụng (có thể sử dụng gói localization)
                  });
                },
              ),
            ),
            Divider(),

            // Nút đăng xuất
            ListTile(
              title: Text(isVietnamese ? 'Đăng xuất' : 'Log Out'),
              leading: Icon(Icons.logout),
              onTap: () {
                // Xử lý đăng xuất, ví dụ như điều hướng về màn hình đăng nhập
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
