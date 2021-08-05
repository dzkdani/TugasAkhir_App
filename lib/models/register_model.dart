class Register {
  String email;
  String username;
  String password;
  String displayName;

  Register(
      {required this.email,
      required this.username,
      required this.password,
      required this.displayName});

  factory Register.fromJsonData(Map<String, dynamic> jsonObject) {
    return Register(
        email: jsonObject['email'],
        username: jsonObject['username'],
        password: jsonObject['password'],
        displayName: jsonObject['display_name']);
  }
}
