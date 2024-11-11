import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/status.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/status_repository.dart';

/// Use case for retrieving the status of an item.
class GetStatus {
  /// Repository responsible for managing item statuses.
  final StatusRepository repository;

  /// Creates a [GetStatus] instance.
  GetStatus(this.repository);

  /// Retrieves the status of an item.
  ///
  /// Returns a [Right] with the status of the item if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, Status>> call(String itemId) async {
    return await repository.getStatus(itemId);
  }
}
