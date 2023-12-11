import 'package:agilizadiarista/model/diarista_model.dart';

class DiaristaController {
  final model = DiaristaModel();

  Future<List<Diarista>> getDiaristas() {
    return model.fetchDiaristas();
  }
}