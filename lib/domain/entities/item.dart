import 'package:equatable/equatable.dart';

/// Represents an item in the shopping list.
class Item extends Equatable {
  /// Unique identifier for the item.
  final String id;

  /// Name of the item.
  final String name;

  /// Category of the item.
  final String category;

  /// Indicates whether the item has been purchased.
  final bool isPurchased;

  /// Creates an [Item] instance.
  const Item({
    required this.id,
    required this.name,
    required this.category,
    this.isPurchased = false,
  });

  @override
  List<Object?> get props => [id, name, category, isPurchased];

  /// Creates a copy of the item with the given parameters replaced.
  Item copyWith({
    String? id,
    String? name,
    String? category,
    bool? isPurchased,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      isPurchased: isPurchased ?? this.isPurchased,
    );
  }

  /// Converts the item to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'isPurchased': isPurchased,
    };
  }

  /// Creates an [Item] instance from a map.
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      isPurchased: map['isPurchased'],
    );
  }
}
