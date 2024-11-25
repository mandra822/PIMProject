class User {
  final String userID;
  final String name;
  final String lastName;
  final String email;
  final String login;
  final String password;
  final List<String> groupsIDs; 

  const User(
    {
      required this.userID,
      required this.name,
      required this.lastName,
      required this.email,
      required this.login, // moze login wystarczy, bez ID
      required this.password,
      required this.groupsIDs
    }
  );
}