class Expense {
  final DateTime date;
  final String item;
  final double price;
  final String user;
  final bool didYouPay;
  final double splittedPrice;
  final int id;

  const Expense(
      {required this.date,
      required this.item,
      required this.price,
      required this.user,
      required this.didYouPay,
      required this.splittedPrice,
      required this.id});
}
