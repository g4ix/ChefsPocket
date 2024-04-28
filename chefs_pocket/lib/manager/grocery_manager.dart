import 'package:chefs_pocket/models/ingredient.dart';
import 'package:flutter/material.dart';

class GroceryManager extends ChangeNotifier {

  final List<Ingredient> _ingredient = <Ingredient>[];

  List<Ingredient> get ingredient => List.unmodifiable(_ingredient);
  
 
  
  void deleteItem(int index){
    _ingredient.removeAt(index);
    notifyListeners();
  }

  void addItem(Ingredient item){
    _ingredient.add(item);
    notifyListeners();
  }

  void updateItem(Ingredient item, int index){
    _ingredient[index] = item;
    notifyListeners();
  }

  

}