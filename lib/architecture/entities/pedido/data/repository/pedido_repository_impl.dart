import 'package:dartz/dartz.dart';
import 'package:flutter_shopping_cart_mvvm/architecture/entities/pedido/data/datasources/pedido_local_data_source.dart';

import '../../../../achitecture.dart';

class PedidoRepositoryImpl implements PedidoRepository {
  PedidoRemoteDataSource remoteDataSource;
  PedidoLocalDataSource localDataSource;

  PedidoRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> addPedido(Pedido pedido) async {
    try {
      await localDataSource.addPedido(pedido);
      return Right(await remoteDataSource.addPedido(pedido));
    } catch (e) {
      return Future.value(Left(Failure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<Pedido>>> getPedidos() async {
    try {
      await localDataSource.getPedidos();
      return Right(await remoteDataSource.getPedidos());
    } catch (e) {
      return Future.value(Left(Failure(e.toString())));
    }
  }
}
