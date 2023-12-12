import 'dart:convert';
import 'package:uuid/uuid.dart';

Agendamento agendamentoFromJson(String str) => Agendamento.fromJson(json.decode(str));

String agendamentoToJson(Agendamento data) => json.encode(data.toJson());

class Agendamento {
  String id;
  String idDiarista;
  String nomeDiarista;
  String data;
  String horario;
  bool confirmado;

  Agendamento({
    String? id,
    required this.idDiarista,
    required this.nomeDiarista,
    required this.data,
    required this.horario,
    required this.confirmado,
  }): id = id ?? Uuid().v4();

  factory Agendamento.fromJson(Map<String, dynamic> json) => Agendamento(
    id: json["id"],
    idDiarista: json["id_diarista"],
    nomeDiarista: json["nome_diarista"],
    data: json["data"],
    horario: json["horario"],
    confirmado: json["confirmado"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_diarista": idDiarista,
    "nome_diarista": nomeDiarista,
    "data": data,
    "horario": horario,
    "confirmado": confirmado,
  };
}