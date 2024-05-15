import 'package:chefs_pocket/models/ingredient.dart';
import 'package:flutter/material.dart';

class GroceryManager extends ChangeNotifier {

  final List<Ingredient> _ingredients = <Ingredient>[];

  List<Ingredient> get ingredient => List.unmodifiable(_ingredients);
  
 
  
  void deleteItem(int index){
    _ingredients.removeAt(index);
    notifyListeners();
  }

  void addItem(Ingredient item){
    _ingredients.add(item);
    notifyListeners();
  }

  void updateItem(Ingredient item, int index){
    _ingredients[index] = item;
    notifyListeners();
  }

  

}