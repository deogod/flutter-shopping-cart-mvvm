import 'package:dartz/dartz.dart';

import '../../../../achitecture.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, void>> addUser(User user);
}
