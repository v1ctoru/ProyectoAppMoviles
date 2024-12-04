import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final List<String> options = [
    'Atención General',
    'Dentista',
    'Kinesiólogo',
    'Nutricionista',
    'Psicólogo'
  ];

  String? selectedOption;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedir Hora Médica'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Indique a qué doctor o motivo quiere solicitar una hora médica.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Seleccione',
                border: OutlineInputBorder(),
              ),
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Seleccione la fecha de la cita:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != selectedDate) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.purple),
                    SizedBox(width: 10),
                    Text(
                      selectedDate == null
                          ? 'Seleccione una fecha'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedOption != null && selectedDate != null) {
                    // Aquí puedes implementar la lógica para guardar la cita
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Éxito'),
                        content: Text('La hora ha sido ingresada exitosamente.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text('Aceptar'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Por favor, rellene todos los datos.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Aceptar'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
