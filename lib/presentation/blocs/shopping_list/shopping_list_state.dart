/// States that can be reached in the shopping list feature.
part of 'shopping_list_bloc.dart';

/// Base class for all shopping list states.
sealed class ShoppingListState extends Equatable {
  const ShoppingListState();

  @override
  List<Object> get props => [];
}

/// Initial state of the shopping list.
final class ShoppingListInitial extends ShoppingListState {}

/// State indicating that the shopping list is being loaded.
final class ShoppingListLoading extends ShoppingListState {}

/// State indicating that the shopping list has been loaded successfully.
final class ShoppingListLoaded extends ShoppingListState {
  /// The list of items in the shopping list.
  final List<Item> items;

  /// The current theme color.
  final Color? themeColor;

  /// The current alert message.
  final String? alert;

  const ShoppingListLoaded(this.items, {this.themeColor, this.alert});

  @override
  List<Object> get props => [items, themeColor ?? '', alert ?? ''];
}

/// State indicating that an error occurred while loading the shopping list.
final class ShoppingListError extends ShoppingListState {
  /// The error message.
  final String message;

  const ShoppingListError(this.message);

  @override
  List<Object> get props => [message];
}
