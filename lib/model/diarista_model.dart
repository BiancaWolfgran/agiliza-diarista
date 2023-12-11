import 'dart:convert';
import 'package:http/http.dart' as http;

List<Diarista> diaristaFromJson(String str) => List<Diarista>.from(json.decode(str).map((x) => Diarista.fromJson(x)));

String diaristaToJson(List<Diarista> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Diarista {
  String id;
  String nome;
  double avaliacao;
  String urlFotoPerfil;
  String cidade;
  String uf;
  String sobre;
  List<Comentario> comentarios;

  Diarista({
    required this.id,
    required this.nome,
    required this.avaliacao,
    required this.urlFotoPerfil,
    required this.cidade,
    required this.uf,
    required this.sobre,
    required this.comentarios,
  });

  factory Diarista.fromJson(Map<String, dynamic> json) => Diarista(
    id: json["id"],
    nome: json["nome"],
    avaliacao: json["avaliacao"]?.toDouble(),
    urlFotoPerfil: json["url_foto_perfil"],
    cidade: json["cidade"],
    uf: json["uf"],
    sobre: json["sobre"],
    comentarios: List<Comentario>.from(json["comentarios"].map((x) => Comentario.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "avaliacao": avaliacao,
    "url_foto_perfil": urlFotoPerfil,
    "cidade": cidade,
    "uf": uf,
    "sobre": sobre,
    "comentarios": List<dynamic>.from(comentarios.map((x) => x.toJson())),
  };
}

class Comentario {
  String id;
  String nomeComentador;
  String comentario;

  Comentario({
    required this.id,
    required this.nomeComentador,
    required this.comentario,
  });

  factory Comentario.fromJson(Map<String, dynamic> json) => Comentario(
    id: json["id"],
    nomeComentador: json["nome_comentador"],
    comentario: json["comentario"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome_comentador": nomeComentador,
    "comentario": comentario,
  };
}

class DiaristaModel {
  Future<List<Diarista>> fetchDiaristas() async {
    var url = Uri.parse('https://raw.githubusercontent.com/ThiagoAM/thiagoam.github.io/master/api/test/diaristas.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> diaristasJson = json.decode(response.body);
      return diaristasJson.map((json) => Diarista.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load diaristas');
    }
  }
}