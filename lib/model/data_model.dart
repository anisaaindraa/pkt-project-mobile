class LoginAuth {
  String message;
  late TokenAuth data;

  LoginAuth({required this.message, required Map<String, dynamic> jsonData})
      : data = TokenAuth.fromJson(jsonData);

  LoginAuth.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        data = TokenAuth.fromJson(json['data']);
}

class TokenAuth {
  String token;

  TokenAuth({required this.token});

  factory TokenAuth.fromJson(Map<String, dynamic> data) {
    return TokenAuth(
      token: data['token'],
    );
  }
}

class User {
  late String email;
  late String password;

  User({required this.email, required this.password});

  User.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      email = json['data']['email'] ?? "";
      password = json['data']['password'] ?? "";
    } else {
      email = "";
      password = "";
    }
  }
}
