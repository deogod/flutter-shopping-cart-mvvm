import '../../../../achitecture.dart';

class UserMapper {
  User fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson(User user) {
    final Map<String, dynamic> data = {};
    data['name'] = user.name;
    data['email'] = user.email;
    data['password'] = user.password;
    return data;
  }
}
