import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUser(String userId, String name, String email) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  await users.doc(userId).set({
    'name': name,
    'email': email,
  });
}

Future<void> addAppointment(String userId, String specialty, DateTime date) async {
  CollectionReference appointments = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('appointments');

  await appointments.add({
    'specialty': specialty,
    'date': date,
    'timestamp': FieldValue.serverTimestamp(),
    'status': 'pendiente',
  });
}
