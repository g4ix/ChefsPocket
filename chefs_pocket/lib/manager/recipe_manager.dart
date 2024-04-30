import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/ingredient.dart';
import '../models/section.dart';
import '../models/recipe_step.dart';
import '../config.dart';

class RecipeManager extends ChangeNotifier {
  Recipe _recipe = Recipe();

  Recipe get recipe => _recipe;

  void setTitle(String title) {
    _recipe.title = title;
    notifyListeners();
  }

  void setImageUrl(String imageUrl) {
    _recipe.imageUrl = imageUrl;
    notifyListeners();
  }

  void setRating(int rating) {
    _recipe.rating = rating;
    notifyListeners();
  }

  void setPortions(int portions) {
    _recipe.portions = portions;
    notifyListeners();
  }

  void addIngredient(Ingredient ingredient) {
    _recipe.ingredients.add(ingredient);
    notifyListeners();
  }

  void removeIngredient(Ingredient ingredient) {
    _recipe.ingredients.remove(ingredient);
    notifyListeners();
  }

  void addStep(RecipeStep step) {
    _recipe.steps.add(step);
    notifyListeners();
  }

  void removeStep(RecipeStep step) {
    _recipe.steps.remove(step);
    notifyListeners();
  }

  void setDuration(Duration duration) {
    _recipe.totalTime = duration;
    notifyListeners();
  }

  void setTag(tag) {
    _recipe.tags.add(tag);
    notifyListeners();
  }
}
