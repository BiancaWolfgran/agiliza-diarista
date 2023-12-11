import 'package:agilizadiarista/model/cadastro_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/agendamento_model.dart';

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

  Future<List<Agendamento>> getAgendamentos(String userId) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        UserModel user = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
        return user.agendamentos;  // Assuming UserModel has a List<Agendamento> agendamentos
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      print("Error fetching user's agendamentos: $e");
      rethrow;
    }
  }
}
