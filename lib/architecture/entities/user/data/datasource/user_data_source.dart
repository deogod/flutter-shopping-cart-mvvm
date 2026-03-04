import '../../../../achitecture.dart';

abstract class UserDataSource {
  Future<User> getUser();
  Future<void> addUser(User user);
}
