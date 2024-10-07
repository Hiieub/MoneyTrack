import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneytrack/presentation/screens/login_screen.dart';
//import 'package:moneytrack/presentation/widgets/bottom_navbar.dart'; 
import 'package:moneytrack/domain/models/category_model.dart';
import 'package:moneytrack/domain/models/transaction_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();
  
  
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(CategoryModelAdapter());

  
  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<CategoryModel>('categories');
  await Hive.openBox('user'); 

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale("vi"),
        Locale("en"),
      ],
      path: "assets/translations",
      child: const MyApp()
      )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      home: LoginPage(), 
    );
  }
}
