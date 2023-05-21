import 'dart:convert';

class UserAuth {
  String? username;
  String? password;
  String? token;
  String? id;

  UserAuth({this.username, this.password, this.token, this.id});

  @override
  String toString() {
    return 'UserAuth(username: $username, password: $password, token: $token, id: $id)';
  }

  factory UserAuth.fromMap(Map<String, dynamic> data) => UserAuth(
        username: data['username'] as String?,
        password: data['password'] as String?,
        token: data['token'] as String?,
        id: data['id'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'Username': username,
        'password': password,
        'token': token,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserAuth].
  factory UserAuth.fromJson(String data) {
    return UserAuth.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserAuth] to a JSON string.
  String toJson() => json.encode(toMap());

  UserAuth copyWith({
    String? username,
    String? password,
    String? token,
    String? id,
  }) {
    return UserAuth(
      username: username ?? this.username,
      password: password ?? this.password,
      token: token ?? this.token,
      id: id ?? this.id,
    );
  }
}
