import 'dart:convert';

Agendamento agendamentoFromJson(String str) => Agendamento.fromJson(json.decode(str));

String agendamentoToJson(Agendamento data) => json.encode(data.toJson());

class Agendamento {
  String idDiarista;
  String nomeDiarista;
  String data;
  String horario;
  bool confirmado;

  Agendamento({
    required this.idDiarista,
    required this.nomeDiarista,
    required this.data,
    required this.horario,
    required this.confirmado,
  });

  factory Agendamento.fromJson(Map<String, dynamic> json) => Agendamento(
    idDiarista: json["id_diarista"],
    nomeDiarista: json["nome_diarista"],
    data: json["data"],
    horario: json["horario"],
    confirmado: json["confirmado"],
  );

  Map<String, dynamic> toJson() => {
    "id_diarista": idDiarista,
    "nome_diarista": nomeDiarista,
    "data": data,
    "horario": horario,
    "confirmado": confirmado,
  };
}