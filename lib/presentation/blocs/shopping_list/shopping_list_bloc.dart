import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_ez/domain/entities/entities.dart';
import 'package:shop_ez/domain/usecases/usecases.dart';

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  final AddItem addItem;
  final RemoveItem removeItem;
  final MarkItemAsPurchased markItemAsPurchased;
  final GetItems getItems;

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
  }

  Future<void> _onAddItem(
      AddItemEvent event, Emitter<ShoppingListState> emit) async {
    emit(ShoppingListLoading());
    final result = await addItem(event.item);
    result.fold(
      (failure) => emit(ShoppingListError(failure.message)),
      (_) => add(GetItemsEvent()),
    );
  }

  Future<void> _onRemoveItem(
      RemoveItemEvent event, Emitter<ShoppingListState> emit) async {
    emit(ShoppingListLoading());
    final result = await removeItem(event.itemId);
    result.fold(
      (failure) => emit(ShoppingListError(failure.message)),
      (_) => add(GetItemsEvent()),
    );
  }

  Future<void> _onMarkItemAsPurchased(
      MarkItemAsPurchasedEvent event, Emitter<ShoppingListState> emit) async {
    emit(ShoppingListLoading());
    final result = await markItemAsPurchased(event.itemId);
    result.fold(
      (failure) => emit(ShoppingListError(failure.message)),
      (_) => add(GetItemsEvent()),
    );
  }

  Future<void> _onGetItems(
      GetItemsEvent event, Emitter<ShoppingListState> emit) async {
    emit(ShoppingListLoading());
    final result = await getItems();
    result.fold(
      (failure) => emit(ShoppingListError(failure.message)),
      (items) => emit(ShoppingListLoaded(items)),
    );
  }

  void _onSortItemsAlphabetically(
      SortItemsAlphabeticallyEvent event, Emitter<ShoppingListState> emit) {
    if (state is ShoppingListLoaded) {
      final currentState = state as ShoppingListLoaded;
      final sortedItems = List<Item>.from(currentState.items);
      sortedItems.sort((a, b) => a.name.compareTo(b.name));
      emit(ShoppingListLoaded(sortedItems));
    }
  }

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
}
