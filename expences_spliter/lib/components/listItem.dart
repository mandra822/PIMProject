import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListItem extends StatelessWidget {
  final String id;
  final String item;
  final double price;
  final String user;
  final DateTime date;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ListItem({
    Key? key,
    required this.id,
    required this.item,
    required this.price,
    required this.user,
    required this.date,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(

        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('yyyy-MM-dd').format(date).toString(),
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

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Paid by: $user'),
            Text('Price: \$${price.toStringAsFixed(2)}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
             icon: Icon(Icons.edit),
             onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete, 
            ),
          ],
        ),
      )
    );
  }
}
