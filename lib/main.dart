import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_ez/data/datasources/database_helper.dart';
import 'package:shop_ez/data/datasources/local_data_source.dart';
import 'package:shop_ez/data/repositories/repositories.dart';
import 'package:shop_ez/domain/usecases/usecases.dart';
import 'package:shop_ez/presentation/blocs/blocs.dart';
import 'package:shop_ez/presentation/pages/pages.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopEZ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => ShoppingListBloc(
          addItem: AddItem(
              ShoppingListRepositoryImpl(LocalDataSource(DatabaseHelper()))),
          removeItem: RemoveItem(
              ShoppingListRepositoryImpl(LocalDataSource(DatabaseHelper()))),
          markItemAsPurchased: MarkItemAsPurchased(
              ShoppingListRepositoryImpl(LocalDataSource(DatabaseHelper()))),
          getItems: GetItems(
              ShoppingListRepositoryImpl(LocalDataSource(DatabaseHelper()))),
        )..add(GetItemsEvent()),
        child: const ShoppingListScreen(),
      ),
    );
  }
}
