import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeshopper/ui/viewmodels/shopping_list_viewmodel.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ShoppingListViewModel>();
    return SafeArea(
      child: Container(),
    );
  }
}
