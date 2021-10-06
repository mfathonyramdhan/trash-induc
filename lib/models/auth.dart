class Auth {
  String email;
  String password;
  String? phone;

  Auth({
    required this.email,
    required this.password,
    this.phone,
  });
}
