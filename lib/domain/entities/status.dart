import 'package:equatable/equatable.dart';

/// Represents a purchase status in the system.
enum PurchaseStatus {
  /// The item has not been purchased.
  notPurchased,

  /// The item has been purchased.
  purchased,
}

/// Represents a status in the system.
class Status extends Equatable {
  /// Unique identifier for the status.
  final String id;

  /// The purchase status of the item.
  final PurchaseStatus status;

  /// Creates a [Status] instance.
  const Status({
    required this.id,
    required this.status,
  });

  @override
  List<Object?> get props => [id, status];

  /// Creates a copy of the status with the given parameters replaced.
  Status copyWith({
    String? id,
    PurchaseStatus? status,
  }) {
    return Status(
      id: id ?? this.id,
      status: status ?? this.status,
    );
  }

  /// Converts the status to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status.index,
    };
  }

  /// Creates a [Status] instance from a map.
  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      id: map['id'],
      status: PurchaseStatus.values[map['status']],
    );
  }
}
