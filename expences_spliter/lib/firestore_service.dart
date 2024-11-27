import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void getPassword(String login) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(login).get();
      String password = doc.get('password');
      print(password);
    } catch (e) {
      print('ERROR przy pobieraniu hasła: $e');
    }
  }



}