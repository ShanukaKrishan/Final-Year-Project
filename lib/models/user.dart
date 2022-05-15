class User {
  final String imagePath;
  final String name;
  final String email;

  const User(
      {required this.imagePath, required this.name, required this.email});
}

class UserPreferences {
  static const myUser = User(
      imagePath: 'assets/images/armani-1.jpg',
      name: 'krishan',
      email: 'shanuka@yahoo.com');
}
