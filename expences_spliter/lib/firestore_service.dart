import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models/expense.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //method to register new users
  Future<String?> register(String email, String password, Map<String, dynamic> userData) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      await _db.collection('users').doc(uid).set(userData);

      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //method to log in users
  Future<String?> logIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // obliczanie łącznych wydatków w grupie
  Future<double> calculateGroupExpenses(String groupId) async {
    final expenses = await fetchExpenses(groupId);
    print("Fetching expenses for group: $groupId");

    Map<String, double> balances = {};
    for (var expense in expenses) {
      balances[expense.user] = (balances[expense.user] ?? 0.0) + expense.price;
        }

    final totalExpenses = expenses.fold(0.0, (sum, e) => sum + e.price);
    print("Balances calculated: $balances");
    return totalExpenses;
  }

  Future<Map<String, double>> calculateUserBalances(String groupId) async {
    final Map<String, double> balances = {};

    try {
      final expenses = await fetchExpenses(groupId);

      for (var expense in expenses) {
        final double perPerson = expense.didYouSplit
            ? expense.price / expenses.length 
            : 0.0;

        balances[expense.user] = (balances[expense.user] ?? 0.0) + expense.price;

        if (expense.didYouSplit) {
          for (var doc in expenses) {
            if (doc.user != expense.user) {
              balances[doc.user] = (balances[doc.user] ?? 0.0) - perPerson;
            }
          }
        }
      }
    } catch (e) {
      print("Error in calculateUserBalances: $e");
      rethrow;
    }

    return balances;
  }

  // pobieranie wydatków dla grupy
  Future<List<Expense>> fetchExpenses(String groupId) async {
    try {
      final querySnapshot = await _db
          .collection('groups')
          .doc(groupId)
          .collection('expenses')
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Expense(
          date: (data['date'] as Timestamp).toDate(),
          item: data['item'] as String,
          price: (data['price'] as num).toDouble(),
          user: data['user'] as String,
          didYouPay: data['didYouPay'] as bool,
          didYouSplit: data['didYouSplit'] as bool,
          id: data['id'] as String,
        );
      }).toList();
    } catch (e) {
      print("Error fetching expenses: $e");
      rethrow;
    }
  }

  Future<List<Expense>> getGroupExpenses(String groupId) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('groups')
          .doc(groupId)
          .collection('expenses')
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception("No expenses found for this group.");
      }

      List<Expense> expenses = snapshot.docs.map((doc) {
        return Expense.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      return expenses;
    } catch (e) {
      print("Error fetching expenses: $e");
      rethrow;
    }
  }

}