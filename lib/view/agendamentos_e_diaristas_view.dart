import 'package:flutter/material.dart';
import 'package:agilizadiarista/model/diarista_model.dart';
import 'package:agilizadiarista/controller/diarista_controller.dart';
import '../model/agendamento_model.dart';
import '../model/login_model.dart';
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

  void _refreshAgendamentos() async {
    String? currentUserId = loginModel.getCurrentUserId();
    if (currentUserId != null) {
      var updatedAgendamentos = await cadastroController.getAgendamentos(currentUserId);
      setState(() {
        futureAgendamentos = Future.value(updatedAgendamentos);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshAgendamentos();
  }

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
        title: Text('Olá, ${loginModel.getCurrentUserName() ?? ""}',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
        backgroundColor: Colors.teal.shade200,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
          children: [
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text("Agendamentos", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
            ),
            // SizedBox(height: 8),
            FutureBuilder<List<Agendamento>>(
              future: futureAgendamentos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Erro ao carregar agendamentos...");
                } else if (snapshot.hasData) {
                  if (snapshot.data!.length > 0) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var agendamento = snapshot.data![index];
                        return Padding(
                          padding: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // Background color
                              borderRadius: BorderRadius.circular(8), // Optional: rounded corners
                              // Add more decoration properties if needed
                            ),
                            child: ListTile(
                              title: Text("Agendamento com ${agendamento.nomeDiarista}"),
                              subtitle: Text("${agendamento.data} às ${agendamento.horario}\n${agendamento.confirmado ? "Confirmado" : "Aguardando confirmação"}"),
                            ),
                          ),
                        );
                        // return ListTile(
                        //   title: Text("Agendamento com ${agendamento.nomeDiarista}"),
                        //   subtitle: Text("${agendamento.data} às ${agendamento.horario}\n${agendamento.confirmado ? "Confirmado" : "Aguardando confirmação"}"),
                        // );
                      },
                    );
                  } else {
                    return Text("Sem agendamentos no momento...");
                  }
                } else {
                  return Text('Erro ao carregar agendamentos...');
                }
              },
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text("É dia de faxina?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
            ),
            // SizedBox(height: 8),
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
                      return Padding(
                        padding: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white, // Background color
                            borderRadius: BorderRadius.circular(8), // Optional: rounded corners
                            // Add more decoration properties if needed
                          ),
                          child: ListTile(
                            leading: Image.network(diarista.urlFotoPerfil),
                            title: Text(diarista.nome),
                            subtitle: Text("${diarista.cidade}, ${diarista.uf}\nAvaliação: ${diarista.avaliacao}\n${diarista.sobre}"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DiaristaDetailView(
                                        diarista: diarista,
                                        onAgendamentoAdded: () {
                                          _refreshAgendamentos();
                                        })),
                              );
                            },
                          ),
                        ),
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
      backgroundColor: Colors.grey.shade100,
    );
  }
}