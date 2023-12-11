import 'agendamento_model.dart';

class UserModel {
  String uid;
  String nomeCompleto;
  String cpfCnpj;
  String telefone;
  String cep;
  String ufEstado;
  String endereco;
  String complemento;
  int numeroLote;
  String cidade;
  String tipoUsuario;
  List<Agendamento> agendamentos;

  UserModel({
    // Inicializando variaveis
    required this.uid,
    required this.nomeCompleto,
    required this.cpfCnpj,
    required this.telefone,
    required this.cep,
    required this.ufEstado,
    required this.endereco,
    required this.complemento,
    required this.numeroLote,
    required this.cidade,
    required this.tipoUsuario,
    required this.agendamentos,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      nomeCompleto: json['nomeCompleto'],
      cpfCnpj: json['cpfCnpj'],
      telefone: json['telefone'],
      cep: json['cep'],
      ufEstado: json['ufEstado'],
      endereco: json['endereco'],
      complemento: json['complemento'],
      numeroLote: json['numeroLote'],
      cidade: json['cidade'],
      tipoUsuario: json['tipoUsuario'],
      agendamentos: (json['agendamentos'] as List<dynamic>? ?? [])
          .map((agendamentoJson) => Agendamento.fromJson(agendamentoJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nomeCompleto': nomeCompleto,
      'cpfCnpj': cpfCnpj,
      'telefone': telefone,
      'cep': cep,
      'ufEstado': ufEstado,
      'endereco': endereco,
      'complemento': complemento,
      'lote': numeroLote,
      'cidade': cidade,
      'tipoUsuario': tipoUsuario,
      'agendamentos': List<dynamic>.from(agendamentos.map((x) => x.toJson())),
    };
  }
}
