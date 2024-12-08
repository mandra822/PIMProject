import 'package:expences_spliter/pages/balance.dart';
import 'package:flutter/material.dart';
import 'package:expences_spliter/components/listItem.dart';
import 'package:expences_spliter/models/expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SingleGroup extends StatefulWidget {
  final String groupId;

  const SingleGroup({super.key, required this.groupId});

  @override
  State<SingleGroup> createState() => _SingleGroupState();
}

class _SingleGroupState extends State<SingleGroup> {
  int _selectedIndex = 0;
  final TextEditingController _paidByController = TextEditingController();
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Expense> _expenses = [];
  bool _didYouSplit = false; 
  bool _didYouPay = false;

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  void _loadExpenses() async {
    try {
      final snapshot = await _firestore.collection('groups').doc(widget.groupId).collection('expenses').get();
      if (mounted) {
        setState(() {
          _expenses = snapshot.docs.map((doc) {
            return Expense.fromMap(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();
        });
      }
    } catch (e) {
      print("Error loading expenses: $e");
    }
  }

  void _deleteExpense(String expenseId) async {
    try {
      await _firestore.collection('groups').doc(widget.groupId).collection('expenses').doc(expenseId).delete();
      _loadExpenses();
    } catch (e) {
      print("Error deleting expense: $e");
    }
  }

  void _addExpenseToFirestore(Expense expense) async {
    try {
      final docRef = await _firestore.collection('groups').doc(widget.groupId).collection('expenses').add(expense.toMap());
      await docRef.update({'id': docRef.id});
      _loadExpenses();
    } catch (e) {
      print("Error adding expense: $e");
    }
  }

  void _editExpense(Expense expense) async {
    try {
      await _firestore.collection('groups').doc(widget.groupId).collection('expenses').doc(expense.id).update({
        'item': _expenseNameController.text,
        'price': double.parse(_amountController.text),
        'user': _paidByController.text,
        'didYouSplit': _didYouSplit,
        'didYouPay': _didYouPay,
      });
      _loadExpenses();
    } catch (e) {
      print("Error editing expense: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: createBody(),
      bottomNavigationBar: bottomBar(),
    );
  }

  Column createBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                String groupId = widget.groupId;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupExpensesPage(groupId: groupId),
                  ),
                );
              },
              child: const Text('Settle It All'),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            itemCount: _expenses.length,
            itemBuilder: (context, index) {
              final ex = _expenses[index];
              return ListItem(
                onDelete: () => _deleteExpense(ex.id),
                onEdit: () {
                  _expenseNameController.text = ex.item;
                  _amountController.text = ex.price.toString();
                  _paidByController.text = ex.user;
                  _didYouSplit = ex.didYouSplit;
                  _didYouPay = ex.didYouPay;
                  _showEditExpenseDialog(ex);
                },
                date: ex.date,
                item: ex.item,
                price: ex.price,
                user: ex.user,
                didYouPay: ex.didYouPay,
                didYouSplit: ex.didYouSplit,
                id: ex.id,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                onPressed: () {
                  _showAddExpenseDialog(context);
                },
                label: const Text('+ Add Expense', style: TextStyle(color: Colors.blue)),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _showEditExpenseDialog(Expense expense) {
    _expenseNameController.text = expense.item;
    _amountController.text = expense.price.toString();
    _paidByController.text = expense.user;
    _didYouSplit = expense.didYouSplit;
    _didYouPay = expense.didYouPay;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _paidByController,
                decoration: const InputDecoration(labelText: 'Paid by'),
              ),
              TextField(
                controller: _expenseNameController,
                decoration: const InputDecoration(labelText: 'Expense Name'),
              ),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _didYouSplit,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _didYouSplit = newValue ?? false;
                      });
                    },
                  ),
                  const Text('Did you split this expense?'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _didYouPay,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _didYouPay = newValue ?? false;
                      });
                    },
                  ),
                  const Text('Did you pay for this expense?'),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                if (_expenseNameController.text.isEmpty ||
                    _amountController.text.isEmpty ||
                    _paidByController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields.')),
                  );
                  return;
                }

                final editedExpense = Expense(
                  id: expense.id,
                  item: _expenseNameController.text,
                  price: double.parse(_amountController.text),
                  user: _paidByController.text,
                  didYouPay: _didYouPay,
                  didYouSplit: _didYouSplit,
                  date: expense.date,
                );
                _editExpense(editedExpense);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    _expenseNameController.clear();
    _amountController.clear();
    _paidByController.clear();
    _didYouSplit = false;
    _didYouPay = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _paidByController,
                decoration: const InputDecoration(labelText: 'Paid by'),
              ),
              TextField(
                controller: _expenseNameController,
                decoration: const InputDecoration(labelText: 'Expense Name'),
              ),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _didYouSplit,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _didYouSplit = newValue ?? false;
                      });
                    },
                  ),
                  const Text('Did you split this expense?'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _didYouPay,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _didYouPay = newValue ?? false;
                      });
                    },
                  ),
                  const Text('Did you pay for this expense?'),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (_expenseNameController.text.isEmpty ||
                    _amountController.text.isEmpty ||
                    _paidByController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields.')),
                  );
                  return;
                }

                final expense = Expense(
                  date: DateTime.now(),
                  item: _expenseNameController.text,
                  price: double.parse(_amountController.text),
                  user: _paidByController.text,
                  didYouPay: _didYouPay,
                  didYouSplit: _didYouSplit,
                  id: '',
                );
                _addExpenseToFirestore(expense);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(widget.groupId, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
      backgroundColor: const Color(0xFF76BBBF),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }


  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Group'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue[700],
      backgroundColor: const Color(0xFF76BBBF),
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}
