import 'package:flutter/material.dart';
import 'appointment_screen.dart';

class HomeScreen extends StatelessWidget {
  final String rut;

  HomeScreen({required this.rut});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: Colors.purple),
            SizedBox(height: 20),
            Text('Bienvenido, $rut', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentScreen()),
                );
              },
              child: Text('Pedir Hora'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Aquí se implementará la funcionalidad "Ver Horas"
              },
              child: Text('Ver Horas'),
            ),
          ],
        ),
      ),
    );
  }
}
