import 'package:equatable/equatable.dart';

/// Represents a category in the system.
class Category extends Equatable {
  /// Unique identifier for the category.
  final String id;

  /// Name of the category.
  final String name;

  /// Creates a [Category] instance.
  const Category({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];

  /// Creates a copy of the category with the given parameters replaced.
  Category copyWith({
    String? id,
    String? name,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  /// Converts the category to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  /// Creates a [Category] instance from a map.
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
    );
  }
}