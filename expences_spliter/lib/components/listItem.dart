import 'package:expences_spliter/pages/singleGroup.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final DateTime date;
  final String item;
  final double price;
  final String user;
  final bool didYouPay;
  final double splittedPrice;
  final int id;
  final VoidCallback onDelete;

  const ListItem(
      {super.key,
      required this.onDelete,
      required this.date,
      required this.item,
      required this.price,
      required this.user,
      required this.didYouPay,
      required this.splittedPrice,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.toString(),
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
            title: Text(
              item,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            subtitle: Text(
              "$user paid $price zł",
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "You ${didYouPay ? "lent" : "borrowed"} $splittedPrice zł",
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => {
                    SingleGroup.allExpenses
                        .removeWhere((element) => element.id == id),
                    onDelete()
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                  iconSize: 32,
                ),
              ],
            )));
  }
}
