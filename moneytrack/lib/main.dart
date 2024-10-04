import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneytrack/presentation/screens/login_screen.dart';
//import 'package:moneytrack/presentation/widgets/bottom_navbar.dart'; 
import 'package:moneytrack/domain/models/category_model.dart';
import 'package:moneytrack/domain/models/transaction_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Hive.initFlutter();
  
  
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(CategoryModelAdapter());

  
  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<CategoryModel>('categories');
  await Hive.openBox('user'); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(), 
    );
  }
}
