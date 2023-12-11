import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agilizadiarista/homePage_Cliente.dart';
import 'package:agilizadiarista/controller/cadastro_controller.dart';
import 'package:agilizadiarista/model/cadastro_model.dart';
import 'package:agilizadiarista/controller/homeParceiro_controller.dart';
import 'package:agilizadiarista/model/homeParceiro_model.dart';
import 'package:agilizadiarista/view/agendamentos_e_diaristas.dart';

class CadastroPage extends StatefulWidget {
  final User currentUser;
  const CadastroPage({super.key, required this.currentUser});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  String tipoUsuario = "Cliente"; // Valor inicial
  final CadastroController _controller = CadastroController();

  final nomeCompletoController = TextEditingController();
  final cpfCnpjController = TextEditingController();
  final telefoneController = TextEditingController();
  final cepController = TextEditingController();
  final ufController = TextEditingController();
  final enderecoController = TextEditingController();
  final complementoController = TextEditingController();
  final cidadeController = TextEditingController();
  final numeroController = TextEditingController();

  @override
  void dispose() {
    nomeCompletoController.dispose();
    cpfCnpjController.dispose();
    telefoneController.dispose();
    cepController.dispose();
    ufController.dispose();
    enderecoController.dispose();
    complementoController.dispose();
    cidadeController.dispose();
    numeroController.dispose();
    super.dispose();
  }

  void _onRegister() async {
    UserModel newUser = UserModel(
      uid: widget.currentUser.uid,
      nomeCompleto: nomeCompletoController.text,
      cpfCnpj: cpfCnpjController.text,
      telefone: telefoneController.text,
      cep: cepController.text,
      ufEstado: ufController.text,
      endereco: enderecoController.text,
      numeroLote: int.tryParse(numeroController.text) ?? 0,
      complemento: complementoController.text,
      cidade: cidadeController.text,
      tipoUsuario: tipoUsuario,
      agendamentos: [],
    );
    try {
      await _controller.registrar(newUser);
      FirebaseAuth auth = FirebaseAuth.instance;
      HomeParceiroModel model = HomeParceiroModel(nomeParceiro: "Nome");
      HomeParceiroController controller = HomeParceiroController(auth: auth, model: model);
      // Redirecionar para a página apropriada com base no tipo de cadastro
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => tipoUsuario == "Cliente" ? AgendamentosEDiaristasView() : const ClienteHomePage()),
      );
    } catch (e) {
      // Mostrar mensagem de erro
      // Exemplo: showDialog ou ScaffoldMessenger
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.teal.shade300,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: nomeCompletoController,
              decoration: const InputDecoration(labelText: 'Nome completo'),
            ),
            TextFormField(
              controller: cpfCnpjController,
              decoration: const InputDecoration(labelText: 'CPF/CNPJ'),
            ),
            TextFormField(
              controller: telefoneController,
              decoration: const InputDecoration(labelText: 'Telefone'),
            ),
            TextFormField(
              controller: cepController,
              decoration: const InputDecoration(labelText: 'CEP'),
            ),
            TextFormField(
              controller: enderecoController,
              decoration: const InputDecoration(labelText: 'Endereço'),
            ),
            TextFormField(
              controller: numeroController,
              decoration: const InputDecoration(labelText: 'Lote'),
            ),
            TextFormField(
              controller: complementoController,
              decoration: const InputDecoration(labelText: 'Complemento'),
            ),
            TextFormField(
              controller: cidadeController,
              decoration: const InputDecoration(labelText: 'Cidade'),
            ),
            TextFormField(
              controller: ufController,
              decoration: const InputDecoration(labelText: 'UF'),
            ),
            DropdownButton<String>(
              value: tipoUsuario,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    tipoUsuario = newValue;
                  });
                }
              },
              items: <String>['Cliente', 'Parceiro']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            ElevatedButton(
              onPressed: _onRegister,
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
