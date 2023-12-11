import 'package:agilizadiarista/Model/diarista_model.dart';
import 'package:flutter/material.dart';

class DiaristaDetailView extends StatelessWidget {
  final Diarista diarista;

  DiaristaDetailView({Key? key, required this.diarista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(diarista.nome),
      ),
      body: SingleChildScrollView(  // Use SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(diarista.urlFotoPerfil),
              Text("Nome: ${diarista.nome}"),
              Text("Avaliação: ${diarista.avaliacao}"),
              Text("Cidade: ${diarista.cidade}, ${diarista.uf}"),
              Text("Sobre: ${diarista.sobre}"),
              Text("Comentários:"),
              ...diarista.comentarios.map((comentario) => ListTile(
                title: Text(comentario.nomeComentador),
                subtitle: Text(comentario.comentario),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
