import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/status.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/status_repository.dart';

class GetStatus {
  final StatusRepository repository;

  GetStatus(this.repository);

  Future<Either<Failure, Status>> call(String itemId) async {
    return await repository.getStatus(itemId);
  }
}
