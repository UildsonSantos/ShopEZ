import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/entities.dart';
import 'package:shop_ez/domain/errors/failure.dart';

/// Repository interface for managing item statuses.
abstract class StatusRepository {
  /// Updates the status of an item.
  ///
  /// Returns a [Right] with the updated status if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, Status>> updateStatus(Status status);

  /// Retrieves the status of an item.
  ///
  /// Returns a [Right] with the status of the item if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, Status>> getStatus(String itemId);
}
