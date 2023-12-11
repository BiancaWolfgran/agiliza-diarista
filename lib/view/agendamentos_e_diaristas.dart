import 'package:flutter/material.dart';
import 'package:agilizadiarista/Model/diarista_model.dart';
import 'package:agilizadiarista/controller/diarista_controller.dart';
import '../Model/agendamento_model.dart';
import '../Model/login_model.dart';
import '../controller/cadastro_controller.dart';
import 'diarista_detail_view.dart';

class AgendamentosEDiaristasView extends StatefulWidget {
  @override
  _AgendamentosEDiaristasViewState createState() => _AgendamentosEDiaristasViewState();
}

class _AgendamentosEDiaristasViewState extends State<AgendamentosEDiaristasView> {
  final diaristaController = DiaristaController();
  final cadastroController = CadastroController();
  late Future<List<Agendamento>> futureAgendamentos;
  late Future<List<Diarista>> futureDiaristas;
  final loginModel = LoginModel();

  @override
  void initState() {
    super.initState();
    String? currentUserId = loginModel.getCurrentUserId();

    if (currentUserId != null) {
      futureAgendamentos = cadastroController.getAgendamentos(currentUserId);
      futureDiaristas = diaristaController.getDiaristas();
    } else {
      // Handle the case where there is no logged-in user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamentos e Diaristas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Agendamento>>(
              future: futureAgendamentos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error loading agendamentos");
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var agendamento = snapshot.data![index];
                      return ListTile(
                        title: Text("Agendamento com ${agendamento.nomeDiarista}"),
                        subtitle: Text("${agendamento.data} às ${agendamento.horario}\n${agendamento.confirmado ? "Confirmado" : "Aguardando confirmação"}"),
                      );
                    },
                  );
                } else {
                  return Text('Sem agendamentos');
                }
              },
            ),
            FutureBuilder<List<Diarista>>(
              future: futureDiaristas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error loading diaristas");
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var diarista = snapshot.data![index];
                      return ListTile(
                        leading: Image.network(diarista.urlFotoPerfil),
                        title: Text(diarista.nome),
                        subtitle: Text("${diarista.cidade}, ${diarista.uf}\nAvaliação: ${diarista.avaliacao}\n${diarista.sobre}"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DiaristaDetailView(diarista: diarista)),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return Text('No diaristas found');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}