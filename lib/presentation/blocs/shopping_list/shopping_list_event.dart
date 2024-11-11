/// Events that can be triggered in the shopping list feature.
part of 'shopping_list_bloc.dart';

/// Base class for all shopping list events.
sealed class ShoppingListEvent extends Equatable {
  const ShoppingListEvent();

  @override
  List<Object> get props => [];
}

/// Event triggered when an item is added to the shopping list.
final class AddItemEvent extends ShoppingListEvent {
  /// The item to be added.
  final Item item;

  const AddItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

/// Event triggered when an item is removed from the shopping list.
final class RemoveItemEvent extends ShoppingListEvent {
  /// The ID of the item to be removed.
  final String itemId;

  const RemoveItemEvent(this.itemId);

  @override
  List<Object> get props => [itemId];
}

/// Event triggered when an item is marked as purchased.
final class MarkItemAsPurchasedEvent extends ShoppingListEvent {
  /// The ID of the item to be marked as purchased.
  final String itemId;

  const MarkItemAsPurchasedEvent(this.itemId);

  @override
  List<Object> get props => [itemId];
}

/// Event triggered when the shopping list items are requested.
final class GetItemsEvent extends ShoppingListEvent {}

/// Event triggered when the shopping list items are sorted alphabetically.
class SortItemsAlphabeticallyEvent extends ShoppingListEvent {}

/// Event triggered when the shopping list items are sorted by status.
class SortItemsByStatusEvent extends ShoppingListEvent {}

/// Event triggered when the theme color is changed.
class SetThemeColorEvent extends ShoppingListEvent {
  /// The new theme color.
  final Color color;

  const SetThemeColorEvent(this.color);

  @override
  List<Object> get props => [color];
}

/// Event triggered when an alert is set.
class SetAlertEvent extends ShoppingListEvent {
  /// The alert message.
  final String alert;

  const SetAlertEvent(this.alert);

  @override
  List<Object> get props => [alert];
}
