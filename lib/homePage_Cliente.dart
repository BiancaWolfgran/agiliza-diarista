import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agilizadiarista/controller/login_controller.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Cliente',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const ClienteHomePage(),
    );
  }
}

class ClienteHomePage extends StatelessWidget {
  const ClienteHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.teal.shade300,
      appBar: AppBar(
        title: const Text('Bem vindo'),
        backgroundColor: Colors.teal.shade300,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () async {
              final authService = Provider.of<LoginController>(context, listen: false);
              await authService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Text(
          'Hoje é dia de faxina?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
          SizedBox(height: 10),
        ]
      ),
    )
    );
  }
}
