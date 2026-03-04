import 'package:dartz/dartz.dart';

import '../../../../achitecture.dart';

class AddUserUsecase {
  final UserRepository repository;

  AddUserUsecase(this.repository);

  Future<Either<Failure, void>> call(User user) {
    return repository.addUser(user);
  }
}
