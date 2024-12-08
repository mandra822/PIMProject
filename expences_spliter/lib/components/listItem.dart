import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String id;
  final String item;
  final double price;
  final String user;
  final bool didYouPay;
  final bool didYouSplit; 
  final DateTime date;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ListItem({
    Key? key,
    required this.id,
    required this.item,
    required this.price,
    required this.user,
    required this.didYouPay,
    required this.didYouSplit, 
    required this.date,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Paid by: $user'),
          Text('Price: \$${price.toStringAsFixed(2)}'),
          Text('Did you split? ${didYouSplit ? 'Yes' : 'No'}'),
          Text('Date: ${date.toLocal().toString()}'),
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
            icon: Icon(Icons.delete),
            onPressed: onDelete, 
          ),
        ],
      ),
    );
  }
}
