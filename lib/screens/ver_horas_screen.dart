import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> agregarCita(String userId, String motivo, DateTime fecha) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId)
      .collection('appointments').add({
        'motivo': motivo,
        'fecha': fecha,
        'createdAt': FieldValue.serverTimestamp(),
      });
  } catch (e) {
    print('Error al agregar la cita: $e');
  }
}



class ViewHoursScreen extends StatefulWidget {
  @override
  _ViewHoursScreenState createState() => _ViewHoursScreenState();
}

class _ViewHoursScreenState extends State<ViewHoursScreen> {
  List<String> appointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      appointments = prefs.getStringList('appointments') ?? [];
    });
  }

  void _deleteAppointment(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmación'),
        content: Text('¿Estás seguro de querer eliminar la hora médica?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                appointments.removeAt(index);
              });
              _saveAppointments();
              Navigator.pop(context);
            },
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('appointments', appointments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Horas Médicas'),
      ),
      body: appointments.isEmpty
          ? Center(
              child: Text(
                'No tienes horas médicas agendadas.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        appointments[index],
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteAppointment(index),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
