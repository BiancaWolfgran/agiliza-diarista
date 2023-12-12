import 'package:flutter/material.dart';
import '../model/diarista_model.dart';
import 'package:intl/intl.dart';

class AgendarView extends StatefulWidget {
  final Diarista diarista;

  AgendarView({Key? key, required this.diarista}) : super(key: key);

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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Agendar diária com ${widget.diarista.nome}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Image.network(widget.diarista.urlFotoPerfil), // Diarista photo
            SizedBox(height: 8),
            // Text(widget.diarista.nome, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // Diarista name
            // SizedBox(height: 4),
            Text("Avaliação: ${widget.diarista.avaliacao}"), // Diarista rating
            SizedBox(height: 20),
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
            onPressed: () {
              // Add your scheduling logic here
            },
            child: Text('Agendar'),
          ),
        ),
      ),
    );
  }
}