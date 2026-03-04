import 'package:dartz/dartz.dart';

import '../../../../achitecture.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final user = await localDataSource.getUser();
      return Right(user);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addUser(User user) async {
    try {
      await localDataSource.addUser(user);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
