import 'package:flutter/material.dart';
import 'package:agilizadiarista/Model/diarista_model.dart';
import 'package:agilizadiarista/controller/diarista_controller.dart';
import 'diarista_detail_view.dart';

class AgendamentosEDiaristasView extends StatefulWidget {
  @override
  _AgendamentosEDiaristasViewState createState() => _AgendamentosEDiaristasViewState();
}

class _AgendamentosEDiaristasViewState extends State<AgendamentosEDiaristasView> {
  final controller = DiaristaController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamentos e Diaristas'),
      ),
      body: FutureBuilder<List<Diarista>>(
        future: controller.getDiaristas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
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
            return Center(child: Text('No diaristas found'));
          }
        },
      ),
    );
  }
}
