import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../config.dart';

class RecipeManager extends ChangeNotifier {
  List<Recipe> _recipes = allSavedRecipes;

  List<Recipe> get recipe => _recipes;

 
  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  void removeRecipe(Recipe recipe) {
    _recipes.remove(recipe);
    notifyListeners();
  }

  void updateRecipe(Recipe recipe) {
    final index = _recipes.indexWhere((element) => element.id == recipe.id);
    _recipes[index] = recipe;
    notifyListeners();
  }
}
