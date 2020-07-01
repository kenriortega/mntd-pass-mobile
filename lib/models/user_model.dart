class User {
  final String username;
  final String fullName;
  final String role;
  final String token;
  final String createdAt;

  User({
    this.username,
    this.fullName,
    this.role,
    this.token,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      fullName: json['fullName'],
      role: json['role'],
      token: json['token'],
      createdAt: json['createdAt'],
    );
  }
  Map toJson() => {
        'username': username,
        'fullName': fullName,
        'role': role,
        'token': token,
        'createdAt': createdAt,
      };
}
