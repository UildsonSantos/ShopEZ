import 'package:dartz/dartz.dart';
import 'package:shop_ez/data/datasources/local_data_source.dart';
import 'package:shop_ez/data/models/status_model.dart';
import 'package:shop_ez/domain/entities/status.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/status_repository.dart';

class StatusRepositoryImpl implements StatusRepository {
  final LocalDataSource localDataSource;

  StatusRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Status>> updateStatus(Status status) async {
    return await localDataSource
        .updateStatus(StatusModel.fromEntity(status))
        .then((either) => either.map((model) => model as Status));
  }

  @override
  Future<Either<Failure, Status>> getStatus(String itemId) async {
    return await localDataSource
        .getStatus(itemId)
        .then((either) => either.map((model) => model as Status));
  }
}
