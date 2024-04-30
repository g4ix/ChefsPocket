import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/ingredient.dart';
import '../models/section.dart';
import '../models/recipe_step.dart';
import '../config.dart';

class RecipeManager extends ChangeNotifier {
  final List<Recipe> _recipes = mockRecipies;

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
    if (index >= 0) {
      _recipes[index] = recipe;
      notifyListeners();
    }
  }
}
