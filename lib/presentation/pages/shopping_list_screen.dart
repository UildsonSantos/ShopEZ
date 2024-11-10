import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_ez/domain/entities/item.dart';
import 'package:shop_ez/presentation/blocs/blocs.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
      ),
      body: BlocBuilder<ShoppingListBloc, ShoppingListState>(
        builder: (context, state) {
          if (state is ShoppingListInitial) {
            BlocProvider.of<ShoppingListBloc>(context).add(GetItemsEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is ShoppingListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ShoppingListLoaded) {
            final items = state.items;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.category),
                  trailing: Checkbox(
                    value: item.isPurchased,
                    onChanged: (value) {
                      BlocProvider.of<ShoppingListBloc>(context)
                          .add(MarkItemAsPurchasedEvent(item.id));
                    },
                  ),
                  onLongPress: () {
                    BlocProvider.of<ShoppingListBloc>(context)
                        .add(RemoveItemEvent(item.id));
                  },
                );
              },
            );
          } else if (state is ShoppingListError) {
            return Center(child: Text('Erro: ${state.message}'));
          } else {
            return const Center(child: Text('Erro desconhecido'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Adicionar Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Categoria'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final item = Item(
                  id: DateTime.now().toString(),
                  name: nameController.text,
                  category: categoryController.text,
                );
                BlocProvider.of<ShoppingListBloc>(context)
                    .add(AddItemEvent(item));
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
