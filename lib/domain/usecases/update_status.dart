import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/status.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/status_repository.dart';

class UpdateStatus {
  final StatusRepository repository;

  UpdateStatus(this.repository);

  Future<Either<Failure, Status>> call(Status status) async {
    return await repository.updateStatus(status);
  }
}
