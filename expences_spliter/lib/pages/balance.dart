import 'package:expences_spliter/firestore_service.dart';
import 'package:flutter/material.dart';

class GroupExpensesPage extends StatelessWidget {
  final String groupId;

  GroupExpensesPage({required this.groupId});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF76BBBF),
        title: const Text(
          "Settlement",
          style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold
          )
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, 
        ),
      ),
      body: Column(
        children: [
          // FutureBuilder dla łącznych wydatków grupy
          FutureBuilder<double>(
            future: FirestoreService().calculateGroupExpenses(groupId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData) {
                return const Center(child: Text("No total expenses found."));
              } else {
                final totalExpenses = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Total Group Expenses: ${totalExpenses.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
                );
              }
            },
          ),

          // FutureBuilder dla sald użytkowników
          Flexible(
            child: FutureBuilder<List<String>>(
              future: FirestoreService().fetchGroupMembers(groupId),
              builder: (context, membersSnapshot) {
                if (membersSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (membersSnapshot.hasError) {
                  return Center(child: Text("Error fetching group members: ${membersSnapshot.error}"));
                } else if (!membersSnapshot.hasData || membersSnapshot.data!.isEmpty) {
                  return const Center(child: Text("No group members found."));
                } else {
                  final groupMembers = membersSnapshot.data!;
                  return FutureBuilder<Map<String, double>>(
                    future: FirestoreService().calculateUserBalances(groupId, groupMembers),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No data available."));
                      } else {
                        final userBalances = snapshot.data!;
                        final transactions = _calculateTransactions(userBalances);

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: ListView(
                                children: userBalances.entries.map((entry) {
                                  final isPositive = entry.value >= 0;
                                  return Card (
                                    child: ListTile(
                                      title: Text(entry.key),
                                      trailing: Text(
                                        isPositive
                                            ? "Is owed: ${entry.value.toStringAsFixed(2)}"
                                            : "Needs to Pay: ${(entry.value.abs()).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: isPositive ? Colors.blue : Colors.red,
                                          fontSize: 16, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                  );
                                }).toList(),
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Who owes whom:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Flexible(
                              child: ListView(
                                children: transactions.map((transaction) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(
                                        "${transaction['from']} owes ${transaction['to']}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      trailing: Text(
                                        "${transaction['amount'].toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _calculateTransactions(Map<String, double> balances) {
    final creditors = <String, double>{};
    final debtors = <String, double>{};

    // Podziel użytkowników na wierzycieli i dłużników
    balances.forEach((user, balance) {
      if (balance > 0) {
        creditors[user] = balance;
      } else if (balance < 0) {
        debtors[user] = balance.abs();
      }
    });

    final transactions = <Map<String, dynamic>>[];

    // Oblicz transakcje między dłużnikami a wierzycielami
    for (final debtor in debtors.keys.toList()) {
      double debt = debtors[debtor]!;

      for (final creditor in creditors.keys.toList()) {
        double credit = creditors[creditor]!;

        // Jeżeli dług lub kredyt jest 0, przejdź do następnej iteracji
        if (debt <= 0 || credit <= 0) continue;

        final payment = debt > credit ? credit : debt;

        transactions.add({
          'from': debtor,
          'to': creditor,
          'amount': payment,
        });

        // Zaktualizowanie salda dłużnika i wierzyciela
        debtors[debtor] = debt - payment;
        creditors[creditor] = credit - payment;
      }

      // Jeśli dług dłużnika jest spłacony, usuń go z mapy
      if (debtors[debtor]! <= 0) {
        debtors.remove(debtor);
      }
    }

    // Usuwanie wierzycieli, którzy spłacili swój kredyt
    creditors.removeWhere((key, value) => value <= 0);

    return transactions;
  }


}
