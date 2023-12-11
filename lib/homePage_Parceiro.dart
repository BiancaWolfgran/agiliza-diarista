import 'package:agilizadiarista/controller/homeParceiro_controller.dart';
import 'package:agilizadiarista/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParceiroHomePage extends StatelessWidget {
  final HomeParceiroController controller;

  const ParceiroHomePage({Key? key, required this.controller}) : super(key: key);

  void _navigateToAgendaPage(BuildContext context) {
    // Assuming '/agendaPage' is a named route defined in your MaterialApp widget
    Navigator.of(context).pushNamed('/agendaPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.teal.shade300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToAgendaPage(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade300,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Gerenciar agenda'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement navigation or functionality for managing requests
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade300,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Gerenciar solicitações'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement navigation or functionality for service history
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade300,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Histórico de serviços'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement navigation or functionality for payments
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade300,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Pagamentos'),
            ),
          ],
        ),
      ),
    );
  }
}
