import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:run_away_admin/presentation/home_page/admin_home.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(useMaterial3: true),
      home: const AdminHome(),
      debugShowCheckedModeBanner: false,
    );
    
  }
}
