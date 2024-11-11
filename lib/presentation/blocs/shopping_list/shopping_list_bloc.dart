import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_ez/domain/entities/entities.dart';
import 'package:shop_ez/domain/usecases/usecases.dart';

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

/// Bloc responsible for managing the state of the shopping list.
class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  /// Use case for adding an item to the shopping list.
  final AddItem addItem;

  /// Use case for removing an item from the shopping list.
  final RemoveItem removeItem;

  /// Use case for marking an item as purchased.
  final MarkItemAsPurchased markItemAsPurchased;

  /// Use case for retrieving all items from the shopping list.
  final GetItems getItems;

  /// Creates a [ShoppingListBloc] instance.
  ShoppingListBloc({
    required this.addItem,
    required this.removeItem,
    required this.markItemAsPurchased,
    required this.getItems,
  }) : super(ShoppingListInitial()) {
    on<AddItemEvent>(_onAddItem);
    on<RemoveItemEvent>(_onRemoveItem);
    on<MarkItemAsPurchasedEvent>(_onMarkItemAsPurchased);
    on<GetItemsEvent>(_onGetItems);
    on<SortItemsAlphabeticallyEvent>(_onSortItemsAlphabetically);
    on<SortItemsByStatusEvent>(_onSortItemsByStatus);
    on<SetThemeColorEvent>(_onSetThemeColor);
    on<SetAlertEvent>(_onSetAlert);
  }

  /// Handles the [AddItemEvent].
  Future<void> _onAddItem(
      AddItemEvent event, Emitter<ShoppingListState> emit) async {
    emit(ShoppingListLoading());
    final result = await addItem(event.item);
    result.fold(
      (failure) => emit(ShoppingListError(failure.message)),
      (_) => add(GetItemsEvent()),
    );
  }

  /// Handles the [RemoveItemEvent].
  Future<void> _onRemoveItem(
      RemoveItemEvent event, Emitter<ShoppingListState> emit) async {
    emit(ShoppingListLoading());
    final result = await removeItem(event.itemId);
    result.fold(
      (failure) => emit(ShoppingListError(failure.message)),
      (_) => add(GetItemsEvent()),
    );
  }

  /// Handles the [MarkItemAsPurchasedEvent].
  Future<void> _onMarkItemAsPurchased(
      MarkItemAsPurchasedEvent event, Emitter<ShoppingListState> emit) async {
    emit(ShoppingListLoading());
    final result = await markItemAsPurchased(event.itemId);
    result.fold(
      (failure) => emit(ShoppingListError(failure.message)),
      (_) => add(GetItemsEvent()),
    );
  }

  /// Handles the [GetItemsEvent].
  Future<void> _onGetItems(
      GetItemsEvent event, Emitter<ShoppingListState> emit) async {
    emit(ShoppingListLoading());
    final result = await getItems();
    result.fold(
      (failure) => emit(ShoppingListError(failure.message)),
      (items) => emit(ShoppingListLoaded(items)),
    );
  }

  /// Handles the [SortItemsAlphabeticallyEvent].
  void _onSortItemsAlphabetically(
      SortItemsAlphabeticallyEvent event, Emitter<ShoppingListState> emit) {
    if (state is ShoppingListLoaded) {
      final currentState = state as ShoppingListLoaded;
      final sortedItems = List<Item>.from(currentState.items);
      sortedItems.sort((a, b) => a.name.compareTo(b.name));
      emit(ShoppingListLoaded(sortedItems));
    }
  }

  /// Handles the [SortItemsByStatusEvent].
  void _onSortItemsByStatus(
      SortItemsByStatusEvent event, Emitter<ShoppingListState> emit) {
    if (state is ShoppingListLoaded) {
      final currentState = state as ShoppingListLoaded;
      final sortedItems = List<Item>.from(currentState.items);
      sortedItems.sort((a, b) {
        if (a.isPurchased == b.isPurchased) {
          return 0;
        } else if (a.isPurchased) {
          return 1;
        } else {
          return -1;
        }
      });
      emit(ShoppingListLoaded(sortedItems));
    }
  }

  /// Handles the [SetThemeColorEvent].
  void _onSetThemeColor(
      SetThemeColorEvent event, Emitter<ShoppingListState> emit) {
    if (state is ShoppingListLoaded) {
      final currentState = state as ShoppingListLoaded;
      emit(ShoppingListLoaded(currentState.items, themeColor: event.color));
    }
  }

  /// Handles the [SetAlertEvent].
  void _onSetAlert(SetAlertEvent event, Emitter<ShoppingListState> emit) {
    if (state is ShoppingListLoaded) {
      final currentState = state as ShoppingListLoaded;
      emit(ShoppingListLoaded(currentState.items, alert: event.alert));
    }
  }
}
