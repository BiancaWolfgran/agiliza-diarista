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
  });

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
    };
  }
}
