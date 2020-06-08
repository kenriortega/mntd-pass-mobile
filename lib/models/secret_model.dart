import 'package:flutter/foundation.dart';

class Secret {
  final String username;
  final String name;
  final String createdAt;
  final String category;

  Secret({
    @required this.username,
    @required this.name,
    @required this.createdAt,
    @required this.category,
  });

  factory Secret.fromJson(Map<String, dynamic> json) {
    return Secret(
      username: json['username'],
      name: json['name'],
      createdAt: json['createdAt'],
      category: json['category'],
    );
  }
}
