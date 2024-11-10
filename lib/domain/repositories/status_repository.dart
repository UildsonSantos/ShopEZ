import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/entities.dart';
import 'package:shop_ez/domain/errors/failure.dart';

abstract class StatusRepository {
  Future<Either<Failure, Status>> updateStatus(Status status);
  Future<Either<Failure, Status>> getStatus(String itemId);
}
