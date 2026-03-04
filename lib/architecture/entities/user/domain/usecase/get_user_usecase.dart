import 'package:dartz/dartz.dart';

import '../../../../achitecture.dart';

class GetUserUsecase {
  final UserRepository repository;

  GetUserUsecase(this.repository);

  Future<Either<Failure, User>> call() {
    return repository.getUser();
  }
}
