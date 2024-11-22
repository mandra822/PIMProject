// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expences_spliter/components/listItem.dart';
import 'package:expences_spliter/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SingleGroup extends StatefulWidget {
  const SingleGroup({super.key});
  static List<Expense> allExpenses = [
    Expense(
        date: DateTime.now(),
        item: 'Papier toaletowy',
        price: 3.33,
        user: 'UserA',
        didYouPay: true,
        splittedPrice: 3.33,
        id: 1),
    Expense(
        date: DateTime.now(),
        item: 'Papier toaletowy',
        price: 3.33,
        user: 'UserA',
        didYouPay: true,
        splittedPrice: 3.33,
        id: 2),
  ];
  @override
  State<SingleGroup> createState() => _SingleGroupState();
}

class _SingleGroupState extends State<SingleGroup> {
  int _selectedIndex = 0;

  final TextEditingController _paidByController = TextEditingController();
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void refreshState() {
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(), body: createBody(), bottomNavigationBar: bottomBar());
  }

  Column createBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  // Settlement Strings
                  const Text('You are owed XX zł',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),

                  const SizedBox(height: 8),

                  const Text('UserA owes you YY zł',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),

                  const SizedBox(height: 4),

                  const Text('UserB owes you ZZ zł',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),

                  const SizedBox(height: 12),

                  // Settlement Button
                  ElevatedButton(
                      onPressed: () {
                        // settlement functionality
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                      ),
                      child: const Text('Settle It All',
                          style: TextStyle(color: Colors.blue, fontSize: 16))),

                  const SizedBox(height: 12),

                  // Expences List
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //
                        for (var ex in SingleGroup.allExpenses) ...[
                          ListItem(
                              onDelete: refreshState,
                              date: ex.date,
                              item: ex.item,
                              price: ex.price,
                              user: ex.user,
                              didYouPay: ex.didYouPay,
                              splittedPrice: ex.splittedPrice,
                              id: ex.id),
                          const Divider(),
                        ]
                      ]),
                ]))),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                onPressed: () {
                  _showAddExpenseDialog(context);
                },
                label: const Text('+ Add Expense',
                    style: TextStyle(
                      color: Colors.blue,
                    )),
              )

              // ElevatedButton(
              //   onPressed: () {},
              //   child: const Text('Delete Group'),
              //   style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.symmetric(
              //         horizontal: 20, vertical: 15),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
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
                decoration: const InputDecoration(
                  labelText: 'Paid by',
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: _expenseNameController,
                decoration: const InputDecoration(
                  labelText: 'Expense Name',
                ),
              ),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
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
                setState(() {
                  SingleGroup.allExpenses.add(Expense(
                    date: DateTime.now(),
                    item: _expenseNameController.text,
                    price: double.parse(_amountController.text),
                    user: _paidByController.text,
                    didYouPay: true, //TODO: Calculate if user paid
                    splittedPrice: 44.44, // TODO: Calculate the splitted price
                    id: SingleGroup.allExpenses.length +
                        1, //TODO get id from Firebase
                  ));
                });

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
      title: const Text(
        'Group X',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFF76BBBF),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          // Define your onTap behavior here
        },
        child: Container(
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //   color: const Color.fromARGB(255, 248, 247, 247),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          child: SvgPicture.asset('assets/icons/ArrowLeft2.svg',
              height: 20, width: 20, color: Colors.white),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            // Define your onTap behavior here
          },
          child: Container(
            alignment: Alignment.center,
            // decoration: BoxDecoration(
            //   color: const Color.fromARGB(255, 248, 247, 247),
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: SvgPicture.asset('assets/icons/dots.svg',
                height: 5, // Adjusted for better visibility
                width: 5, // Adjusted for better visibility
                color: Colors.white),
          ),
        ),
      ],
    );
  }

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Group',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[700],
        backgroundColor: const Color(0xFF76BBBF),
        onTap: _onItemTapped);
  }
}
