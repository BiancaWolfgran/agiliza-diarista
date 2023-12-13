import 'package:agilizadiarista/controller/cadastro_controller.dart';
import 'package:agilizadiarista/model/diarista_model.dart';
import 'package:agilizadiarista/model/login_model.dart';
import 'package:agilizadiarista/view/agendar_view.dart';
import 'package:flutter/material.dart';

class DiaristaDetailView extends StatelessWidget {
  final Diarista diarista;
  final Function() onAgendamentoAdded;

  DiaristaDetailView({
    Key? key,
    required this.diarista,
    required this.onAgendamentoAdded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(diarista.nome),
        backgroundColor: Colors.teal.shade200,
      ),
      body: SingleChildScrollView(  // Use SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(diarista.urlFotoPerfil),
              Text("Avaliação: ${diarista.avaliacao}"),
              Text("${diarista.cidade}, ${diarista.uf}"),
              Text("\n${diarista.sobre}"),
              Text("\nComentários:",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
              ...diarista.comentarios.map((comentario) => ListTile(
                title: Text(comentario.nomeComentador),
                subtitle: Text(comentario.comentario),
              )).toList(),
              SizedBox(height: 64),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AgendarView(
                    diarista: diarista,
                    userId: LoginModel().getCurrentUserId() ?? "",
                    cadastroController: CadastroController(),
                    onAgendamentoAdded: onAgendamentoAdded)),
          );
        },
        icon: Icon(Icons.calendar_today),
        label: Text('Agendar'),
        backgroundColor: Colors.teal.shade100,
      ),
    );
  }
}

