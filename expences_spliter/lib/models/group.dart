class Group {
  final String groupID;
  final String groupName;
  // users which have account and access to this group
  final List<String> usersIDs;
  // members meaning people who pay for expenses
  final List<String> groupMembers;
  final List<String> expensesIDs; // to nie do konca bedzie lista... albo bedzie ale to nie wystarczy, bo jeszcze reszta danych wydatków

  // missing variables needed to settle up expenses

  const Group(
    {
      required this.groupID,    
      required this.groupName,
      required this.usersIDs,
      required this.groupMembers,
      required this.expensesIDs
    }
  );

}