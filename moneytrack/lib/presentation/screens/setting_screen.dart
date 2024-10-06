import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
//import 'package:moneytrack/Constants/days.dart';
import '../screens/login_screen.dart';
import '/Constants/limits.dart'; 

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String userName = "";
  String _selectedLanguage = 'en'; 
  late TextEditingController _limitPerExpenseController;
  late TextEditingController _limitTotalController;

  @override
  void initState() {
    super.initState();

    final userBox = Hive.box('user');
    userName = userBox.get('name', defaultValue: 'User');

    _limitPerExpenseController = TextEditingController(text: limitPerExpense.toString());
    _limitTotalController = TextEditingController(text: limitTotal.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    _selectedLanguage = context.locale.languageCode; 
  }

  @override
  void dispose() {
    _limitPerExpenseController.dispose();
    _limitTotalController.dispose();
    super.dispose();
  }

  void _saveLimits() {
    setState(() {
      limitPerExpense = int.tryParse(_limitPerExpenseController.text) ?? limitPerExpense;
      limitTotal = int.tryParse(_limitTotalController.text) ?? limitTotal;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Limits updated successfully".tr())));
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      _selectedLanguage = languageCode;
      context.setLocale(Locale(languageCode)); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings".tr()),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text("User Profile".tr()),
              subtitle: Text("${'username'.tr()}: $userName"),
              leading: Icon(Icons.person),
            ),
            Divider(),
            ListTile(
              title: Text("Limit Per Expense".tr()),
              subtitle: TextField(
                controller: _limitPerExpenseController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter limit per expense".tr(),
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Total Limit".tr()),
              subtitle: TextField(
                controller: _limitTotalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter total limit".tr(),
                ),
              ),
            ),
            Divider(),
            ElevatedButton(
              onPressed: _saveLimits,
              child: Text("Save Limits".tr()),
            ),
            Divider(),
            
            ListTile(
              title: Text("Select Language".tr()),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _changeLanguage(newValue);
                  }
                },
                items: <String>['en', 'vi'] 
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value == 'en' ? 'English' : 'Tiếng Việt'),
                  );
                }).toList(),
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Log Out".tr()),
              leading: Icon(Icons.logout),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
