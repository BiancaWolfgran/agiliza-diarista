import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agilizadiarista/model/homeParceiro_model.dart';

class HomeParceiroController with ChangeNotifier {
  final FirebaseAuth auth;
  final HomeParceiroModel model;

  HomeParceiroController({required this.model, required this.auth});

  // Método para carregar dados na inicialização da página
  Future<void> carregarDados() async {
    try {
      await model.buscarInformacoesParceiro();
      notifyListeners(); // Notifica os ouvintes de uma mudança no modelo
    } catch (e) {
      // Tratar erros de carregamento de dados
      // Por exemplo, notificar a UI para mostrar uma mensagem de erro
      notifyListeners();
    }
  }

  // Método para tratar a ação quando um item do menu é selecionado
  void executarAcaoMenu(String opcao, BuildContext context) {
    switch (opcao) {
      case 'Gerenciar agenda':
      /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AgendaPage()),
        );*/
        break;
      case 'Gerenciar solicitações':
      // Implement navigation or functionality for managing requests
        break;
      case 'Histórico de serviços':
      // Implement navigation or functionality for service history
        break;
      case 'Pagamentos':
      // Implement navigation or functionality for payments
        break;
      default:
      // Implement default action or show error
        break;
    }
  }
}
