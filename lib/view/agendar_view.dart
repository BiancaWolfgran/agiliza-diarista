import 'package:flutter/material.dart';
import '../controller/cadastro_controller.dart';
import '../model/agendamento_model.dart';
import '../model/diarista_model.dart';
import 'package:intl/intl.dart';

class AgendarView extends StatefulWidget {
  final Diarista diarista;
  final String userId;
  final CadastroController cadastroController;
  final Function() onAgendamentoAdded;

  AgendarView({
    Key? key,
    required this.diarista,
    required this.userId,
    required this.cadastroController,
    required this.onAgendamentoAdded,
  }) : super(key: key);

  @override
  _AgendarViewState createState() => _AgendarViewState();
}

class _AgendarViewState extends State<AgendarView> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendar'),
        backgroundColor: Colors.teal.shade200,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Agendar diária com ${widget.diarista.nome}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
            SizedBox(height: 8),
            Image.network(widget.diarista.urlFotoPerfil), // Diarista photo
            SizedBox(height: 8),
            ListTile(
              title: Text("Data: ${DateFormat('dd/MM/yyyy').format(selectedDate)}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () => _selectDate(context),
            ),
            ListTile(
              title: Text("Horário: ${selectedTime.format(context)}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () => _selectTime(context),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () async {
              try {
                // Create the new Agendamento object
                Agendamento newAgendamento = Agendamento(
                  idDiarista: widget.diarista.id,
                  data: DateFormat('yyyy-MM-dd').format(selectedDate),
                  horario: selectedTime.format(context),
                  confirmado: false,
                  nomeDiarista: widget.diarista.nome,
                );

                // Call the method to add the Agendamento
                await widget.cadastroController.addAgendamento(widget.userId, newAgendamento);

                // After successful addition
                widget.onAgendamentoAdded();

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Tudo pronto!"),
                      content: Text("Agora é só aguardar a confirmação!"),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Ok"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            Navigator.of(context).pop(); // Close the AgendarDetailView screen
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } catch (e) {
                // Handle errors here
              }
            },
            child: Text('Agendar'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.grey.shade900,
              backgroundColor: Colors.teal.shade100, // Foreground (text & icon) color
            ),
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}
