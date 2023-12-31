import 'package:flutter/material.dart';
import 'package:agilizadiarista/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agiliza Diarista',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: LoginView(),
    );
  }
}

