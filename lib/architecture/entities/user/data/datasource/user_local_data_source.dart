import '../../../../achitecture.dart';

class UserLocalDataSource implements UserDataSource {
  final LocalStorage localStorage;

  UserLocalDataSource({required this.localStorage});

  @override
  Future<void> addUser(User user) async {
    await localStorage.saveData(StorageKey.USER, UserMapper().toJson(user));
  }

  @override
  Future<User> getUser() async {
    final data = await localStorage.getData(StorageKey.USER);
    if (data != null) {
      return UserMapper().fromJson(data);
    } else {
      throw Exception('User not found');
    }
  }
}
