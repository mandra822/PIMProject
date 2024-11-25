class Group {
  final String groupID;
  final String groupName;
  // users which have account and access to this group
  final List<String> usersIDs;
  // members meaning people who pay for expenses
  final List<String> groupMembers;
  final List<String> expensesIDs;

  // missing variables needed to settle up expenses

  const Group(
    {
      required this.groupID,    // możliwe ze id grupy moze byc jej nazwa bo raczej sie nie powtarzaja w grupach jednego usera
      required this.groupName,
      required this.usersIDs,
      required this.groupMembers,
      required this.expensesIDs
    }
  );

}