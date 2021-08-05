class Login {
  String username;
  String password;

  Login({required this.username, required this.password});

  factory Login.fromJsonData(Map<String, dynamic> jsonObject) {
    return Login(
        username: jsonObject['username'], password: jsonObject['password']);
  }
}
