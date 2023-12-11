import 'package:agilizadiarista/Model/cadastro_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registrar(UserModel user) async {
    try {
      // Salvando os dados do usuário no Firestore
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
        }catch (e) {
    print("Erro ao salvar: $e"); // Tratamento de erros
    rethrow; // Lançar a exceção para tratamento externo
    }


  }
}
